package controller;

import data.ProductDAO;
import data.ReviewDAO;
import model.Product;
import model.Review;
import controller.CsrfUtil; 
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ReviewServlet", urlPatterns = {"/admin/review"})
public class ReviewServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String csrfToken = (String) session.getAttribute("csrfToken");
        
        if (csrfToken == null) {
            csrfToken = CsrfUtil.generateToken(request);
        }
        request.setAttribute("csrfToken", csrfToken);

        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        if (action.equals("delete")) {
            if (!CsrfUtil.isValidToken(request)) {
                response.sendError(HttpServletResponse.SC_FORBIDDEN, "Yêu cầu không hợp lệ (CSRF Token mismatch)");
                return;
            }
            handleDelete(request, response);
            return;
        }

        String url = "/admin/review.jsp";
        List<Review> reviews;
        String viewMode;

        String productIdStr = request.getParameter("productId");
        int productId = 0;
        if (productIdStr != null && !productIdStr.isEmpty()) {
            try {
                productId = Integer.parseInt(productIdStr);
            } catch (NumberFormatException e) {
                productId = 0;
            }
        }

        if (action.equals("view_profane")) {
            viewMode = "profane";
            if (productId > 0) {
                reviews = ReviewDAO.selectProfaneReviewsByProduct(productId);
            } else {
                reviews = ReviewDAO.selectProfaneReviews();
            }
        } else {
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
        
        if (!CsrfUtil.isValidToken(request)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Yêu cầu bị từ chối do bảo mật (CSRF)");
            return;
        }
        doGet(request, response);
    }
}