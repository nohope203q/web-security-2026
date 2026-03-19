package controller;

import data.ProductDAO;
import data.ReviewDAO;
import model.Product;
import model.Review;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ReviewServlet", urlPatterns = {"/admin/review"})
public class ReviewServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        // Xử lý xóa riêng vì nó redirect
        if (action.equals("delete")) {
            handleDelete(request, response);
            return;
        }

        String url = "/admin/review.jsp";
        List<Review> reviews;
        String viewMode; // "clean" hoặc "profane"

        String productIdStr = request.getParameter("productId");
        int productId = 0;
        if (productIdStr != null && !productIdStr.isEmpty()) {
            try {
                productId = Integer.parseInt(productIdStr);
            } catch (NumberFormatException e) {
                productId = 0; // Reset nếu ID không hợp lệ
            }
        }

        if (action.equals("view_profane")) {
            viewMode = "profane";
            if (productId > 0) {
                reviews = ReviewDAO.selectProfaneReviewsByProduct(productId);
            } else {
                reviews = ReviewDAO.selectProfaneReviews();
            }
        } else { // Mặc định là action "list" (hoặc "filter")
            viewMode = "clean";
            if (productId > 0) {
                reviews = ReviewDAO.selectCleanReviewsByProduct(productId);
            } else {
                reviews = ReviewDAO.selectCleanReviews();
            }
        }

        List<Product> products = ProductDAO.selectAll();

        if (productId > 0) {
            request.setAttribute("selectedProductId", productId);
        }

        request.setAttribute("viewMode", viewMode);
        request.setAttribute("reviews", reviews);
        request.setAttribute("products", products);
        getServletContext().getRequestDispatcher(url).forward(request, response);
    }

    private void handleDelete(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            int reviewId = Integer.parseInt(request.getParameter("id"));
            ReviewDAO.delete(reviewId);
        } catch (NumberFormatException e) {
            System.out.println("Invalid review ID for deletion: " + e.getMessage());
        }
        response.sendRedirect(request.getContextPath() + "/admin/review");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
