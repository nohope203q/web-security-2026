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
                EntityManager em = DBUtil.getEmFactory().createEntityManager();
                EntityTransaction trans = em.getTransaction();
                try {
                    trans.begin();
                    Order order = em.find(Order.class, Integer.parseInt(txnRef));

                    if (order != null && order.getStatus() == -1) {
                        order.setStatus(0);

                        for (OrderItem item : order.getOrderItems()) {
                            Product product = em.find(Product.class, item.getProduct().getId());
                            if (product != null) {
                                product.setQuantity(product.getQuantity() - item.getQuantity());
                                em.merge(product);
                            }
                        }

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
                                System.out.println("Không tìm thấy coupon: " + order.getCouponCode());
                            }
                        }

                        Invoice invoice = Invoice.generateFromOrder(order);
                        em.persist(invoice);

                        em.merge(order);
                        trans.commit();

                        HttpSession session = req.getSession();
                        session.removeAttribute("cart");
                        session.removeAttribute("appliedCoupon");
                        session.removeAttribute("discountAmount");
                        session.setAttribute("latestOrder", order);
                        session.setAttribute("latestInvoice", invoice);

                        resp.sendRedirect(req.getContextPath() + "/client/order-success.jsp");
                        return;
                    } else {
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
                resp.sendRedirect(req.getContextPath() + "/client/order-error.jsp");
            }
        } else {
            resp.getWriter().println("<html><body><h3>Lỗi: Chữ ký không hợp lệ!</h3></body></html>");
        }
    }
}
