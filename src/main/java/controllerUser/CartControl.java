package controllerUser;

import java.io.IOException;
import java.util.List;

import data.LineItemDAO;
import data.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;
import model.LineItem;
import model.Product;
import model.User;

@WebServlet("/cart")
public class CartControl extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");

        if (!(account instanceof User)) {
            response.sendRedirect(request.getContextPath() + "/client/login");
            return;
        }

        User user = (User) account;
        List<LineItem> cart = LineItemDAO.getCartItemsByUser(user);
        session.setAttribute("cart", cart);

        double subtotal = 0;
        for (LineItem item : cart) {
            subtotal += item.getTotal();
        }

        double shippingFee = 30000.0;
        if (cart.isEmpty()) {
            shippingFee = 0;
        }
        double total = subtotal + shippingFee;

        request.setAttribute("cartItems", cart);
        request.setAttribute("subtotal", subtotal);
        request.setAttribute("shippingFee", shippingFee);
        request.setAttribute("total", total);

        getServletContext().getRequestDispatcher("/client/cart.jsp").forward(request, response);
    }

    @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    request.setCharacterEncoding("UTF-8");
    HttpSession session = request.getSession();
    // KIỂM TRA BẢO MẬT CSRF TRƯỚC TIÊN
    if (!controller.CsrfUtil.isValidToken(request)) {
        // Nếu không khớp hoặc không có token, chặn ngay lập tức
        response.sendError(HttpServletResponse.SC_FORBIDDEN, "Yêu cầu bị từ chối do thiếu mã xác thực bảo mật (CSRF)!");
        return;
    }
    Account account = (Account) session.getAttribute("account");
    if (!(account instanceof User)) {
        session.setAttribute("redirectAfterLogin", request.getRequestURI());
        response.sendRedirect(request.getContextPath() + "/client/login");
        return;
    }

    User user = (User) account;
    List<LineItem> cart = LineItemDAO.getCartItemsByUser(user);

    String action = request.getParameter("action");
    if (action == null) { action = "cart"; }

    handleCartAction(request, action, cart);

        // CWE-840 / CWE-391: Session State Inconsistency - Xoá dữ liệu mã giảm giá khi giỏ hàng bị thay đổi
        session.removeAttribute("appliedCoupon");
        session.removeAttribute("discountAmount");

        LineItemDAO.saveCart(cart, user);
        session.setAttribute("cart", cart);

        // CWE-601: Open Redirect - Fix chuyển hướng tĩnh
        response.sendRedirect(request.getContextPath() + "/client/cart");
    }

    private void handleCartAction(HttpServletRequest request, String action, List<LineItem> cart) {
        try {
            long productId;
            switch (action) {
                case "add":
                    productId = Long.parseLong(request.getParameter("productId"));
                    int quantity = 1; // Mặc định
                    String quantityString = request.getParameter("quantity");
                    if (quantityString != null && !quantityString.isEmpty()) {
                        quantity = Integer.parseInt(quantityString);
                        // CWE-682/ CWE-20: Price Manipulation qua Negative Quantity
                        if (quantity <= 0 || quantity > 100) throw new IllegalArgumentException("Số lượng không hợp lệ!");
                    }
                    addItem(productId, quantity, cart);
                    break;
                case "update":
                    productId = Long.parseLong(request.getParameter("productId"));
                    int newQuantity = Integer.parseInt(request.getParameter("quantity"));
                    // CWE-682/ CWE-20: Price Manipulation qua Negative Quantity
                    if (newQuantity < 0) throw new IllegalArgumentException("Số lượng không hợp lệ!");
                    updateItem(productId, newQuantity, cart);
                    break;
                case "remove":
                    productId = Long.parseLong(request.getParameter("productId"));
                    removeItem(productId, cart);
                    break;
            }
        } catch (NumberFormatException e) {
            System.err.println("Lỗi tham số không hợp lệ trong CartControl: " + e.getMessage());
        }
    }

    private void addItem(long productId, int quantity, List<LineItem> cart) {
        for (LineItem item : cart) {
            if (item.getProduct().getId() == productId) {
                try {
                    // CWE-190: Integer Overflow - Fix bằng cách giới hạn số lượng tối đa
                    item.setQuantity(Math.addExact(item.getQuantity(), quantity));
                } catch (ArithmeticException e) {
                    item.setQuantity(100);
                }
                return;
            }
        }
        Product product = ProductDAO.getProductById(productId);
        if (product != null) {
            cart.add(new LineItem(product, quantity));
        }
    }

    private void updateItem(long productId, int newQuantity, List<LineItem> cart) {
        if (newQuantity <= 0) {
            removeItem(productId, cart);
            return;
        }
        for (LineItem item : cart) {
            if (item.getProduct().getId() == productId) {
                item.setQuantity(newQuantity);
                return;
            }
        }
    }

    private void removeItem(long productId, List<LineItem> cart) {
        cart.removeIf(item -> item.getProduct().getId() == productId);
    }
}
