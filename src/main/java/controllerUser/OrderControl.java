package controllerUser;

import model.LineItem;
import model.Account;
import model.User;
import model.OrderItem;
import model.Address;
import model.Product;
import model.Order;
import model.Invoice;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import model.Coupon;
import data.DBUtil;
import data.LineItemDAO;

@WebServlet("/client/order")
public class OrderControl extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String paymentMethod = request.getParameter("paymentMethod");

        if ("VNPAY".equals(paymentMethod)) {
            // Nếu là VNPAY, chuyển tiếp yêu cầu đến servlet tạo thanh toán VNPAY
            request.getRequestDispatcher("/client/vnpay-payment").forward(request, response);
        } else {
            // Nếu là COD hoặc phương thức khác, xử lý như bình thường
            processCOD(request, response);
        }
    }

    // Tách logic xử lý COD (và các phương thức thanh toán tại chỗ khác) ra một hàm riêng
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
            if (finalShippingAddress == null || finalShippingAddress.trim().isEmpty()) {
                session.setAttribute("checkoutError", "Vui lòng nhập địa chỉ giao hàng mới.");
                response.sendRedirect(request.getContextPath() + "/client/checkout.jsp");
                return;
            }
        } else {
            // ========================================================== //
            // === SỬA LỖI AN TOÀN KHI GHÉP ĐỊA CHỈ MẶC ĐỊNH === //
            // ========================================================== //
            Address defaultAddress = account.getAddress();

            // 1. Tạo một danh sách để chứa các phần của địa chỉ
            java.util.List<String> addressParts = new java.util.ArrayList<>();

            // 2. Chỉ thêm các phần có giá trị (không null và không rỗng) vào danh sách
            if (defaultAddress.getStreet() != null && !defaultAddress.getStreet().trim().isEmpty()) {
                addressParts.add(defaultAddress.getStreet());
            }
            if (defaultAddress.getCity() != null && !defaultAddress.getCity().trim().isEmpty()) {
                addressParts.add(defaultAddress.getCity());
            }

            // 3. Dùng String.join để nối các phần lại với nhau, cách này sẽ không bao giờ lỗi
            finalShippingAddress = String.join(", ", addressParts);
        }

        // ... (Phần còn lại của code không thay đổi) ...
        String paymentMethod = request.getParameter("paymentMethod");
        Coupon appliedCoupon = (Coupon) session.getAttribute("appliedCoupon");
        BigDecimal discountBigDecimal = (BigDecimal) session.getAttribute("discountAmount");
        double discountAmount = (discountBigDecimal != null) ? discountBigDecimal.doubleValue() : 0.0;
        double subtotal = 0.0;
        for (LineItem lineItem : cart) {
            subtotal += lineItem.getTotal();
        }
        double finalAmount = subtotal - discountAmount;
        if (finalAmount < 0) {
            finalAmount = 0.0;
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

            for (LineItem lineItem : cart) {
                Product product = em.find(Product.class, lineItem.getProduct().getId());
                if (product != null) {
                    int newStock = product.getQuantity() - lineItem.getQuantity();
                    product.setQuantity(newStock >= 0 ? newStock : 0);
                    em.merge(product);
                }
            }

            if (appliedCoupon != null) {
                Coupon couponToUpdate = em.find(Coupon.class, appliedCoupon.getId());
                if (couponToUpdate != null) {
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
