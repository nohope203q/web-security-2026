package controllerUser;

import model.LineItem;
import model.Account;
import model.User;
import model.OrderItem;
import model.Order;
import jakarta.persistence.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Coupon;
import data.DBUtil;
import java.io.IOException;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.*;

@WebServlet("/client/vnpay-payment")
public class VnpayPaymentControl extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Account account = (Account) session.getAttribute("account");
        List<LineItem> cart = (List<LineItem>) session.getAttribute("cart");
        String shippingAddress = req.getParameter("address");

        if (account == null || cart == null || cart.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/home");
            return;
        }

        // --- Bước 1: Tạo đơn hàng với trạng thái "Chờ thanh toán" (-1) ---
        Coupon appliedCoupon = (Coupon) session.getAttribute("appliedCoupon");
        BigDecimal discountBigDecimal = (BigDecimal) session.getAttribute("discountAmount");
        Double discountAmount = (discountBigDecimal != null) ? discountBigDecimal.doubleValue() : 0.0;
        Double subtotal = 0.0;
        for (LineItem lineItem : cart) {
            subtotal += lineItem.getProduct().getPrice() * lineItem.getQuantity();
        }
        Double finalAmount = subtotal - discountAmount;
        if (finalAmount < 0) {
            finalAmount = 0.0;
        }

        Order order = new Order();
        order.setUser((User) account);
        order.setDateOrder(new Date());
        order.setShippingAddress(shippingAddress);
        order.setPaymentMethod("VNPAY");
        order.setStatus(-1); // -1: Chờ thanh toán VNPAY
        order.setSubtotal(subtotal);
        order.setDiscountAmount(discountAmount);
        order.setFinalAmount(finalAmount);
        if (appliedCoupon != null) {
            order.setCouponCode(appliedCoupon.getCode());
        }
        List<OrderItem> orderItems = new ArrayList<>();
        for (LineItem lineItem : cart) {
            OrderItem orderItem = new OrderItem();
            orderItem.setProduct(lineItem.getProduct());
            orderItem.setQuantity(lineItem.getQuantity());
            orderItem.setOrder(order);
            orderItems.add(orderItem);
        }
        order.setOrderItems(orderItems);

        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.persist(order);
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) {
                trans.rollback();
            }
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/client/order-error.jsp");
            return;
        } finally {
            em.close();
        }

        // --- Bước 2: Tạo URL thanh toán VNPAY ---
        String vnp_TxnRef = String.valueOf(order.getId());
        long amount = finalAmount.longValue() * 100;
        String vnp_IpAddr = VNPayConfig.getIpAddress(req);
        String vnp_TmnCode = VNPayConfig.vnp_TmnCode;

        Map<String, String> vnp_Params = new HashMap<>();
        vnp_Params.put("vnp_Version", VNPayConfig.vnp_Version);
        vnp_Params.put("vnp_Command", VNPayConfig.vnp_Command);
        vnp_Params.put("vnp_TmnCode", vnp_TmnCode);
        vnp_Params.put("vnp_Amount", String.valueOf(amount));
        vnp_Params.put("vnp_CurrCode", "VND");
        vnp_Params.put("vnp_TxnRef", vnp_TxnRef);
        vnp_Params.put("vnp_OrderInfo", "Thanh toan don hang #" + vnp_TxnRef);
        vnp_Params.put("vnp_OrderType", VNPayConfig.vnp_OrderType);
        vnp_Params.put("vnp_Locale", "vn");
        vnp_Params.put("vnp_ReturnUrl", VNPayConfig.vnp_ReturnUrl);
        vnp_Params.put("vnp_IpAddr", vnp_IpAddr);

        Calendar cld = Calendar.getInstance(TimeZone.getTimeZone("Etc/GMT+7"));
        SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
        String vnp_CreateDate = formatter.format(cld.getTime());
        vnp_Params.put("vnp_CreateDate", vnp_CreateDate);

        cld.add(Calendar.MINUTE, 15);
        String vnp_ExpireDate = formatter.format(cld.getTime());
        vnp_Params.put("vnp_ExpireDate", vnp_ExpireDate);

        List<String> fieldNames = new ArrayList<>(vnp_Params.keySet());
        Collections.sort(fieldNames);
        StringBuilder hashData = new StringBuilder();
        StringBuilder query = new StringBuilder();
        Iterator<String> itr = fieldNames.iterator();
        while (itr.hasNext()) {
            String fieldName = itr.next();
            String fieldValue = vnp_Params.get(fieldName);
            if ((fieldValue != null) && (fieldValue.length() > 0)) {
                hashData.append(fieldName);
                hashData.append('=');
                hashData.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));
                query.append(URLEncoder.encode(fieldName, StandardCharsets.US_ASCII.toString()));
                query.append('=');
                query.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));
                if (itr.hasNext()) {
                    query.append('&');
                    hashData.append('&');
                }
            }
        }
        String queryUrl = query.toString();
        String vnp_SecureHash = VNPayConfig.hmacSHA512(VNPayConfig.vnp_HashSecret, hashData.toString());
        queryUrl += "&vnp_SecureHash=" + vnp_SecureHash;

        String paymentUrl = VNPayConfig.vnp_PayUrl + "?" + queryUrl;
        resp.sendRedirect(paymentUrl);
    }
}
