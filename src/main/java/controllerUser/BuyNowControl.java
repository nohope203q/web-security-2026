package controllerUser;

import jakarta.persistence.EntityManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account; // <-- Thêm import này
import model.LineItem;
import model.Product;
import data.DBUtil;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/client/buy-now")
public class BuyNowControl extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        // ========================================================
        // === BƯỚC QUAN TRỌNG: KIỂM TRA NGƯỜI DÙNG ĐÃ ĐĂNG NHẬP CHƯA ===
        Account account = (Account) session.getAttribute("account");
        if (account == null) {
            // Nếu chưa đăng nhập, chuyển hướng họ đến trang đăng nhập
            response.sendRedirect(request.getContextPath() + "/client/login.jsp");
            return; // Dừng servlet ngay lập tức
        }
        // ========================================================

        // Lấy ID của sản phẩm từ URL
        String productIdStr = request.getParameter("pid");
        if (productIdStr == null || productIdStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        try {
            int productId = Integer.parseInt(productIdStr);

            // Lấy thông tin sản phẩm từ cơ sở dữ liệu
            EntityManager em = DBUtil.getEmFactory().createEntityManager();
            Product product;
            try {
                product = em.find(Product.class, productId);
                if (product == null) {
                    response.sendRedirect(request.getContextPath() + "/home?error=productNotFound");
                    return;
                }
            } finally {
                em.close();
            }

            // Tạo một giỏ hàng tạm thời chỉ chứa sản phẩm này
            List<LineItem> buyNowCart = new ArrayList<>();
            LineItem lineItem = new LineItem();
            lineItem.setProduct(product);
            lineItem.setQuantity(1);
            buyNowCart.add(lineItem);

            // Ghi đè giỏ hàng trong session
            session.setAttribute("cart", buyNowCart);

            // Xóa coupon đã áp dụng trước đó (nếu có)
            session.removeAttribute("appliedCoupon");
            session.removeAttribute("discountAmount");

            // Chuyển hướng người dùng thẳng đến trang thanh toán
            response.sendRedirect(request.getContextPath() + "/client/checkout.jsp");

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/home?error=invalidProductId");
        }
    }
}
