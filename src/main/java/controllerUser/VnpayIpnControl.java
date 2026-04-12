package controllerUser;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import data.DBUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.LockModeType;
import jakarta.persistence.NoResultException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Coupon;
import model.Invoice;
import model.Order;
import model.OrderItem;
import model.Product;

// IPN Endpoint xử lý tự động khi có thông báo thanh toán
@WebServlet("/api/vnpay-ipn")
public class VnpayIpnControl extends HttpServlet {

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
            String txnRef = req.getParameter("vnp_TxnRef");

            if ("00".equals(vnp_ResponseCode)) {
                EntityManager em = DBUtil.getEmFactory().createEntityManager();
                EntityTransaction trans = em.getTransaction();
                try {
                    trans.begin();
                    
                    // Khắc phục Race Condition (CWE-362) với LockModeType.PESSIMISTIC_WRITE
                    Order order = em.find(Order.class, Integer.parseInt(txnRef), LockModeType.PESSIMISTIC_WRITE);

                    if (order != null && order.getStatus() == -1) {
                        order.setStatus(0);

                        for (OrderItem item : order.getOrderItems()) {
                            Product product = em.find(Product.class, item.getProduct().getId(), LockModeType.PESSIMISTIC_WRITE);
                            if (product != null) {
                                int newStock = product.getQuantity() - item.getQuantity();
                                if (newStock < 0) {
                                    throw new RuntimeException("Sản phẩm không đủ số lượng!");
                                }
                                product.setQuantity(newStock);
                                em.merge(product);
                            }
                        }

                        if (order.getCouponCode() != null && !order.getCouponCode().isEmpty()) {
                            try {
                                // Khắc phục Coupon Validation Bypass & Race Condition
                                Coupon coupon = em.createQuery("SELECT c FROM Coupon c WHERE c.code = :code", Coupon.class)
                                        .setParameter("code", order.getCouponCode())
                                        .setLockMode(LockModeType.PESSIMISTIC_WRITE)
                                        .getSingleResult();
                                if (coupon != null) {
                                    if (!"active".equals(coupon.getStatus()) || 
                                       (coupon.getUsageLimit() != null && coupon.getUsedCount() >= coupon.getUsageLimit())) {
                                        throw new RuntimeException("Mã giảm giá đã hết lượt!");
                                    }
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

                        resp.getWriter().println("{\"RspCode\":\"00\",\"Message\":\"Confirm Success\"}");
                        return;
                    } else if (order != null && order.getStatus() == 0) {
                        resp.getWriter().println("{\"RspCode\":\"02\",\"Message\":\"Order already confirmed\"}");
                        return;
                    } else {
                        resp.getWriter().println("{\"RspCode\":\"01\",\"Message\":\"Order not found\"}");
                        return;
                    }
                } catch (Exception e) {
                    if (trans.isActive()) {
                        trans.rollback();
                    }
                    e.printStackTrace();
                    resp.getWriter().println("{\"RspCode\":\"99\",\"Message\":\"Unknown error\"}");
                } finally {
                    em.close();
                }
            } else {
                resp.getWriter().println("{\"RspCode\":\"97\",\"Message\":\"Transaction failed\"}");
            }
        } else {
            resp.getWriter().println("{\"RspCode\":\"97\",\"Message\":\"Invalid signature\"}");
        }
    }
}
