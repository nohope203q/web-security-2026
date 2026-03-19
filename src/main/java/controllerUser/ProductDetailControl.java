package controllerUser;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import data.ProductDAO;
import data.ReviewDAO;
import data.OrderDAO;
import model.Product;
import model.Review;
import model.Account;
import model.User;

@WebServlet("/detail")
public class ProductDetailControl extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String pidStr = req.getParameter("pid");
        if (pidStr == null) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing pid");
            return;
        }

        long pid;
        try {
            pid = Long.parseLong(pidStr);
        } catch (NumberFormatException nfe) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid pid");
            return;
        }

        ProductDAO dao = new ProductDAO();
        Product product = dao.getProductByIdWithCategory(pid);

        if (product == null) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Product not found");
            return;
        }

        // (Tuỳ chọn) gợi ý sản phẩm cùng danh mục
        List<Product> related = null;
        if (product.getCategory() != null) {
            long catId = product.getCategory().getId();
            related = dao.getRelatedByCategory(catId, pid, 6);
        }

        ReviewDAO reviewDAO = new ReviewDAO();
        List<Review> reviews = reviewDAO.getReviewsByProductId(pid);
        double avgRating = reviewDAO.getAverageRating(pid);
        long totalReviews = reviewDAO.getTotalReviewCount(pid);
        Map<Integer, Long> ratingDistribution = reviewDAO.getRatingDistribution(pid);

        HttpSession session = req.getSession();
        Account account = (Account) session.getAttribute("account");
        boolean canReview = false;
        boolean hasReviewed = false;

        if (account != null && account instanceof User) {
            User user = (User) account;
            // Check if user has purchased and received the product (status = 3)
            canReview = OrderDAO.hasUserPurchasedProduct((long) user.getId(), pid);
            // Check if user has already reviewed
            hasReviewed = reviewDAO.hasUserReviewed(pid, user.getId());
        }

        req.setAttribute("product", product);
        req.setAttribute("related", related);
        req.setAttribute("reviews", reviews);
        req.setAttribute("avgRating", avgRating);
        req.setAttribute("totalReviews", totalReviews);
        req.setAttribute("ratingDistribution", ratingDistribution);
        req.setAttribute("canReview", canReview);
        req.setAttribute("hasReviewed", hasReviewed);

        RequestDispatcher rd = req.getRequestDispatcher("/client/product-detail.jsp");
        rd.forward(req, resp);
    }
}
