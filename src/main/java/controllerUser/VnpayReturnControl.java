package controllerUser;

import model.OrderItem;
import model.Product;
import model.Order;
import model.Invoice;
import jakarta.persistence.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Coupon;
import data.DBUtil;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/client/vnpay-return")
public class VnpayReturnControl extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Map<String, String> fields = new HashMap<>();
        for (String key : req.getParameterMap().keySet()) {
            String value = req.getParameter(key);
            if (value != null && !value.isEmpty()) {
                fields.put(key, value);
            }
        }

        String vnp_SecureHash = req.getParameter("vnp_SecureHash");
        fields.remove("vnp_SecureHashType");
        fields.remove("vnp_SecureHash");

        String signValue = VNPayConfig.hmacSHA512(VNPayConfig.vnp_HashSecret, VNPayConfig.hashAllFields(fields));

        if (signValue.equals(vnp_SecureHash)) {
            String vnp_ResponseCode = req.getParameter("vnp_ResponseCode");
            String txnRef = req.getParameter("vnp_TxnRef"); // Mã đơn hàng của bạn

            if ("00".equals(vnp_ResponseCode)) {
                // Thanh toán thành công
                EntityManager em = DBUtil.getEmFactory().createEntityManager();
                EntityTransaction trans = em.getTransaction();
                try {
                    trans.begin();
                    Order order = em.find(Order.class, Integer.parseInt(txnRef));

                    // Chỉ cập nhật nếu đơn hàng đang ở trạng thái chờ thanh toán
                    if (order != null && order.getStatus() == -1) {
                        order.setStatus(0); // Chuyển sang trạng thái "Chờ xử lý"

                        // Trừ kho sản phẩm
                        for (OrderItem item : order.getOrderItems()) {
                            Product product = em.find(Product.class, item.getProduct().getId());
                            if (product != null) {
                                product.setQuantity(product.getQuantity() - item.getQuantity());
                                em.merge(product);
                            }
                        }

                        // Cập nhật lượt sử dụng coupon (nếu có)
                        if (order.getCouponCode() != null && !order.getCouponCode().isEmpty()) {
                            try {
                                Coupon coupon = em.createQuery("SELECT c FROM Coupon c WHERE c.code = :code", Coupon.class)
                                        .setParameter("code", order.getCouponCode())
                                        .getSingleResult();
                                if (coupon != null) {
                                    coupon.setUsedCount(coupon.getUsedCount() + 1);
                                    em.merge(coupon);
                                }
                            } catch (NoResultException e) {
                                // Bỏ qua nếu không tìm thấy coupon, có thể log lỗi
                                System.out.println("Không tìm thấy coupon: " + order.getCouponCode());
                            }
                        }

                        // Tạo hóa đơn
                        Invoice invoice = Invoice.generateFromOrder(order);
                        em.persist(invoice);

                        em.merge(order);
                        trans.commit();

                        // Dọn dẹp và chuyển hướng
                        HttpSession session = req.getSession();
                        session.removeAttribute("cart");
                        session.removeAttribute("appliedCoupon");
                        session.removeAttribute("discountAmount");
                        session.setAttribute("latestOrder", order);
                        session.setAttribute("latestInvoice", invoice);

                        resp.sendRedirect(req.getContextPath() + "/client/order-success.jsp");
                        return; // Quan trọng: dừng servlet sau khi chuyển hướng
                    } else {
                        // Đơn hàng đã được xử lý hoặc không tồn tại, chỉ chuyển hướng
                        resp.sendRedirect(req.getContextPath() + "/client/order-tracking");
                        return;
                    }
                } catch (Exception e) {
                    if (trans.isActive()) {
                        trans.rollback();
                    }
                    e.printStackTrace();
                    resp.sendRedirect(req.getContextPath() + "/client/order-error.jsp");
                } finally {
                    em.close();
                }
            } else {
                // Thanh toán thất bại, có thể cập nhật trạng thái đơn hàng nếu muốn
                resp.sendRedirect(req.getContextPath() + "/client/order-error.jsp");
            }
        } else {
            // Chữ ký không hợp lệ
            resp.getWriter().println("<html><body><h3>Lỗi: Chữ ký không hợp lệ!</h3></body></html>");
        }
    }
}
