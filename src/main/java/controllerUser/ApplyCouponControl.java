package controllerUser;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import model.Coupon; // Đảm bảo bạn đã import đúng model Coupon
import model.LineItem;
import data.CouponDAO; // Đảm bảo bạn đã import đúng CouponDAO

@WebServlet("/client/apply-coupon")
public class ApplyCouponControl extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String code = request.getParameter("couponCode");
        List<LineItem> cart = (List<LineItem>) session.getAttribute("cart");

        // Luôn xóa coupon cũ trước khi áp dụng mã mới
        session.removeAttribute("appliedCoupon");
        session.removeAttribute("discountAmount");

        if (code == null || code.trim().isEmpty()) {
            session.setAttribute("couponMessage", "Vui lòng nhập mã giảm giá.");
            session.setAttribute("couponStatus", "error");
            response.sendRedirect(request.getContextPath() + "/client/checkout.jsp");
            return;
        }

        // Làm mới trạng thái của các coupon trước khi kiểm tra
        CouponDAO.refreshStatuses();
        Coupon coupon = CouponDAO.findByCode(code);

        // --- Bắt đầu kiểm tra các điều kiện của coupon ---
        String errorMessage = null;
        if (coupon == null) {
            errorMessage = "Mã giảm giá không hợp lệ hoặc không tồn tại.";
        } else if (!"active".equals(coupon.getStatus())) {
            errorMessage = "Mã này đã hết hạn hoặc chưa đến ngày sử dụng.";
        } else if (coupon.getUsageLimit() != null && coupon.getUsedCount() >= coupon.getUsageLimit()) {
            errorMessage = "Mã giảm giá đã hết lượt sử dụng.";
        } else {
            // Tính tổng tiền đơn hàng (subtotal)
            BigDecimal subtotal = BigDecimal.ZERO;
            if (cart != null && !cart.isEmpty()) {
                for (LineItem item : cart) {
                    subtotal = subtotal.add(
                            BigDecimal.valueOf(item.getProduct().getPrice()).multiply(new BigDecimal(item.getQuantity()))
                    );
                }
            }

            // Kiểm tra điều kiện giá trị đơn hàng tối thiểu
            if (subtotal.compareTo(coupon.getMinOrder()) < 0) {
                errorMessage = "Đơn hàng chưa đạt giá trị tối thiểu (" + coupon.getMinOrder() + " VND) để áp dụng mã này.";
            }
        }

        // --- Xử lý kết quả kiểm tra ---
        if (errorMessage != null) {
            session.setAttribute("couponMessage", errorMessage);
            session.setAttribute("couponStatus", "error");
        } else {
            // Mã hợp lệ, tiến hành tính toán số tiền giảm giá
            BigDecimal subtotal = BigDecimal.ZERO;
            for (LineItem item : cart) {
                subtotal = subtotal.add(BigDecimal.valueOf(item.getProduct().getPrice()).multiply(new BigDecimal(item.getQuantity())));
            }

            BigDecimal discountAmount = BigDecimal.ZERO;
            if ("PERCENT".equals(coupon.getType())) {
                discountAmount = subtotal.multiply(coupon.getValue().divide(new BigDecimal("100")));
                // Kiểm tra giới hạn giảm giá tối đa (nếu có)
                if (coupon.getMaxDiscount() != null && discountAmount.compareTo(coupon.getMaxDiscount()) > 0) {
                    discountAmount = coupon.getMaxDiscount();
                }
            } else if ("FIXED".equals(coupon.getType())) {
                discountAmount = coupon.getValue();
            }

            // Lưu thông tin vào session
            session.setAttribute("appliedCoupon", coupon);
            session.setAttribute("discountAmount", discountAmount);
            session.setAttribute("couponMessage", "Áp dụng mã giảm giá thành công!");
            session.setAttribute("couponStatus", "success");
        }

        // Chuyển hướng người dùng trở lại trang thanh toán để xem kết quả
        response.sendRedirect(request.getContextPath() + "/client/checkout.jsp");
    }
}
