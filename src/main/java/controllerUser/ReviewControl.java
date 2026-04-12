package controllerUser;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;
import model.Product;
import model.Review;
import model.User;
import data.ProductDAO;
import data.ReviewDAO;
import data.OrderDAO;

import java.io.IOException;

@WebServlet("/review")
public class ReviewControl extends HttpServlet {

    private final ReviewDAO reviewDAO = new ReviewDAO();
    private final ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
if (!controller.CsrfUtil.isValidToken(request)) {
    response.sendError(HttpServletResponse.SC_FORBIDDEN, "CSRF token invalid");
    return;
}
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");
        if (account == null || !(account instanceof User)) {
            session.setAttribute("reviewError", "Vui lòng đăng nhập để đánh giá");
            response.sendRedirect(request.getContextPath() + "/client/login.jsp");
            return;
        }
        User user = (User) account;

        try {
            String productIdStr = request.getParameter("productId");
            String ratingStr = request.getParameter("rating");
            String comment = request.getParameter("comment");

            if (productIdStr == null || ratingStr == null) {
                session.setAttribute("reviewError", "Vui lòng chọn số sao đánh giá");
                response.sendRedirect(request.getContextPath() + "/detail?pid=" + productIdStr);
                return;
            }

            Long productId = Long.parseLong(productIdStr);
            int rating = Integer.parseInt(ratingStr);

            if (rating < 1 || rating > 5) {
                session.setAttribute("reviewError", "Đánh giá không hợp lệ");
                response.sendRedirect(request.getContextPath() + "/detail?pid=" + productId + "&tab=review");

                return;
            }

            boolean hasPurchased = OrderDAO.hasUserPurchasedProduct((long) user.getId(), productId);
            if (!hasPurchased) {
                session.setAttribute("reviewError", "Bạn cần mua và nhận sản phẩm trước khi đánh giá");
                response.sendRedirect(request.getContextPath() + "/detail?pid=" + productId + "&tab=review");

                return;
            }

            if (reviewDAO.hasUserReviewed(productId, user.getId())) {
                session.setAttribute("reviewError", "Bạn đã đánh giá sản phẩm này rồi");
                response.sendRedirect(request.getContextPath() + "/detail?pid=" + productId + "&tab=review");

                return;
            }

            Product product = productDAO.getProductById(productId);
            if (product == null) {
                session.setAttribute("reviewError", "Không tìm thấy sản phẩm");
                response.sendRedirect(request.getContextPath() + "/");
                return;
            }

            Review review = new Review();
            review.setRating(rating);
            review.setComment(comment != null ? comment.trim() : "");
            review.setProduct(product);
            review.setUser(user);
            review.setVerified(true); // User has purchased, so mark as verified

            boolean success = reviewDAO.insertReview(review);

            if (success) {
                session.setAttribute("reviewSuccess", "Cảm ơn bạn đã đánh giá! Đánh giá của bạn đã được đăng.");
            } else {
                session.setAttribute("reviewError", "Có lỗi xảy ra, vui lòng thử lại");
            }

            response.sendRedirect(request.getContextPath() + "/detail?pid=" + productId);

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("reviewError", "Có lỗi xảy ra: " + e.getMessage());
            String productIdStr = request.getParameter("productId");
            if (productIdStr != null) {
                response.sendRedirect(request.getContextPath() + "/detail?pid=" + productIdStr);
            } else {
                response.sendRedirect(request.getContextPath() + "/");
            }
        }
    }
}