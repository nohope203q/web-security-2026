package controllerUser;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import data.DBUtil;
import jakarta.persistence.EntityManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Invoice;
import model.Order;

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
                try {
                    Order order = em.find(Order.class, Integer.parseInt(txnRef));

                    if (order != null && (order.getStatus() == -1 || order.getStatus() == 0)) {
                        
                        // CWE-841: Khắc phục kiến trúc - Nhường lại logic xử lý duyệt đơn, trừ kho cho IPN Webhook
                        // Ở file ReturnURL này chỉ tiến hành thông báo hiển thị cho người dùng và xóa giỏ hàng
                        
                        HttpSession session = req.getSession();
                        session.removeAttribute("cart");
                        session.removeAttribute("appliedCoupon");
                        session.removeAttribute("discountAmount");
                        session.setAttribute("latestOrder", order);
                        
                        // Tìm hiển thị Invoice nếu IPN đã kịp sinh ra
                        try {
                            Invoice invoice = em.createQuery("SELECT i FROM Invoice i WHERE i.order.id = :orderId", Invoice.class)
                                      .setParameter("orderId", order.getId()).setMaxResults(1).getSingleResult();
                            session.setAttribute("latestInvoice", invoice);
                        } catch (Exception ex) {}

                        resp.sendRedirect(req.getContextPath() + "/client/order-success.jsp");
                        return;
                    } else {
                        resp.sendRedirect(req.getContextPath() + "/client/order-tracking");
                        return;
                    }
                } catch (Exception e) {
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
