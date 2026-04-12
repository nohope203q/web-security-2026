package controllerUser;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import data.DBUtil;
import data.LineItemDAO;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;
import model.Address;
import model.Coupon;
import model.Invoice;
import model.LineItem;
import model.Order;
import model.Product;
import model.User;

@WebServlet("/client/order")
public class OrderControl extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String paymentMethod = request.getParameter("paymentMethod");

        if ("VNPAY".equals(paymentMethod)) {
            request.getRequestDispatcher("/client/vnpay-payment").forward(request, response);
        } else {
            processCOD(request, response);
        }
    }

    private void processCOD(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");
        List<LineItem> cart = (List<LineItem>) session.getAttribute("cart");

        if (account == null || !(account instanceof User) || cart == null || cart.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        String addressOption = request.getParameter("addressOption");
        String finalShippingAddress;

        if ("new".equals(addressOption)) {
            finalShippingAddress = request.getParameter("newAddress");
            if (finalShippingAddress != null) {
                // Khắc phục XSS (CWE-79)
                finalShippingAddress = finalShippingAddress.replaceAll("<", "&lt;").replaceAll(">", "&gt;");
            }
            if (finalShippingAddress == null || finalShippingAddress.trim().isEmpty()) {
                session.setAttribute("checkoutError", "Vui lòng nhập địa chỉ giao hàng mới.");
                response.sendRedirect(request.getContextPath() + "/client/checkout.jsp");
                return;
            }
        } else {

            Address defaultAddress = account.getAddress();

            java.util.List<String> addressParts = new java.util.ArrayList<>();

            if (defaultAddress.getStreet() != null && !defaultAddress.getStreet().trim().isEmpty()) {
                addressParts.add(defaultAddress.getStreet());
            }
            if (defaultAddress.getCity() != null && !defaultAddress.getCity().trim().isEmpty()) {
                addressParts.add(defaultAddress.getCity());
            }

            finalShippingAddress = String.join(", ", addressParts);
        }

        String paymentMethod = request.getParameter("paymentMethod");
        Coupon appliedCoupon = (Coupon) session.getAttribute("appliedCoupon");
        BigDecimal discountBigDecimal = (BigDecimal) session.getAttribute("discountAmount");
        double discountAmount = (discountBigDecimal != null) ? discountBigDecimal.doubleValue() : 0.0;

        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        EntityTransaction trans = em.getTransaction();

        try {
            trans.begin();

            double subtotal = 0.0;
            // Khắc phục Price Freezing (CWE-840): Luôn tải giá mới từ DB
            for (LineItem lineItem : cart) {
                Product realProduct = em.find(Product.class, lineItem.getProduct().getId());
                if (realProduct != null) {
                    subtotal += realProduct.getPrice() * lineItem.getQuantity();
                }
            }
            double finalAmount = subtotal - discountAmount;
            if (finalAmount < 0) {
                throw new RuntimeException("Phát hiện lỗi: Tổng tiền không hợp lệ.");
            }

            Order order = new Order();
            order.setUser((User) account);
            order.setDateOrder(new Date());
        order.setShippingAddress(finalShippingAddress);
        order.setPaymentMethod(paymentMethod);
        order.setStatus(0);
        order.setSubtotal(subtotal);
        order.setDiscountAmount(discountAmount);
        order.setFinalAmount(finalAmount);
        if (appliedCoupon != null) {
            order.setCouponCode(appliedCoupon.getCode());
        }
em.persist(order);

        for (LineItem lineItem : cart) {
            // Khắc phục Race Condition (CWE-362)
            Product product = em.find(Product.class, lineItem.getProduct().getId(), jakarta.persistence.LockModeType.PESSIMISTIC_WRITE);
            if (product != null) {
                int newStock = product.getQuantity() - lineItem.getQuantity();
                if (newStock < 0) {
                    throw new RuntimeException("Sản phẩm hết hàng hoặc không đủ số lượng!");
                }
                product.setQuantity(newStock);
                em.merge(product);
            }
        }

        if (appliedCoupon != null) {
            // Khắc phục Race Condition & Coupon Bypass (CWE-362 & CWE-285)
            Coupon couponToUpdate = em.find(Coupon.class, appliedCoupon.getId(), jakarta.persistence.LockModeType.PESSIMISTIC_WRITE);
            if (couponToUpdate != null) {
                if (!"active".equals(couponToUpdate.getStatus()) || 
                   (couponToUpdate.getUsageLimit() != null && couponToUpdate.getUsedCount() >= couponToUpdate.getUsageLimit())) {
                    throw new RuntimeException("Mã giảm giá đã hết lượt hoặc không hợp lệ!");
                }
                couponToUpdate.setUsedCount(couponToUpdate.getUsedCount() + 1);
                em.merge(couponToUpdate);
            }
        }

        Invoice invoice = Invoice.generateFromOrder(order);
        em.persist(invoice);

        trans.commit();

            LineItemDAO.clearCartForUser((User) account);

            session.removeAttribute("cart");
            session.removeAttribute("appliedCoupon");
            session.removeAttribute("discountAmount");
            session.removeAttribute("checkoutError");
            session.setAttribute("latestOrder", order);
            session.setAttribute("latestInvoice", invoice);

            response.sendRedirect(request.getContextPath() + "/client/order-success.jsp");

        } catch (Exception e) {
            if (trans.isActive()) {
                trans.rollback();
            }
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/client/order-error.jsp");
        } finally {
            em.close();
        }
    }
}
