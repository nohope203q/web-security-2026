package controller;

import data.CategoryDAO;
import model.Category;
import model.Product;
import controller.CsrfUtil; 
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "CategoryServlet", urlPatterns = {"/admin/category"})
public class CategoryServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        String url = "/admin/category.jsp";
        switch (action) {
            case "list" -> {
            }
            case "edit" -> {
                try {
                    int id = Integer.parseInt(request.getParameter("id"));
                    Category category = CategoryDAO.select(id);
                    if (category != null) {
                        request.setAttribute("categoryToEdit", category);
                    }
                } catch (NumberFormatException e) {
                    System.out.println(e);
                }
            }
            case "viewDetails" -> {
                try {
                    int id = Integer.parseInt(request.getParameter("id"));
                    Category selectedCategory = CategoryDAO.select(id);
                    List<Product> products = CategoryDAO.getProductsByCategory(id);
                    request.setAttribute("selectedCategory", selectedCategory);
                    request.setAttribute("productsOfCategory", products);
                } catch (NumberFormatException e) {
                    System.out.println(e);
                }
            }
            case "delete" -> {
                // --- BƯỚC 2: KIỂM TRA TOKEN KHI XÓA QUA URL (GET) ---
                if (!CsrfUtil.isValidToken(request)) {
                    response.sendError(HttpServletResponse.SC_FORBIDDEN, "Invalid CSRF token");
                    return;
                }
                handleDelete(request, response);
                return;
            }
        }

        List<Category> categories = CategoryDAO.getAllCategory();
        request.setAttribute("categories", categories);

        getServletContext().getRequestDispatcher(url).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // --- BƯỚC 3: KIỂM TRA TOKEN KHI SUBMIT FORM (ADD/UPDATE) ---
        if (!CsrfUtil.isValidToken(request)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Invalid CSRF token");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) {
            response.sendRedirect(request.getContextPath() + "/admin/category");
            return;
        }

        switch (action) {
            case "add" -> handleAdd(request);
            case "update" -> handleUpdate(request);
        }

        response.sendRedirect(request.getContextPath() + "/admin/category");
    }

    private void handleAdd(HttpServletRequest request) {
        String name = request.getParameter("categoryName");
        if (name != null && !name.trim().isEmpty()) {
            Category newCategory = new Category();
            newCategory.setName(name);
            CategoryDAO.insert(newCategory);
        }
    }

    private void handleUpdate(HttpServletRequest request) {
        try {
            int id = Integer.parseInt(request.getParameter("categoryId"));
            String name = request.getParameter("categoryName");
            if (name != null && !name.trim().isEmpty()) {
                Category category = new Category();
                category.setId(id);
                category.setName(name);
                CategoryDAO.update(category);
            }
        } catch (NumberFormatException e) {
            System.out.println(e);
        }
    }

    private void handleDelete(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            List<Product> products = CategoryDAO.getProductsByCategory(id);

            if (products == null || products.isEmpty()) {
                CategoryDAO.delete(id);
            } else {
                String message = "Không thể xóa danh mục này vì nó đang chứa sản phẩm.";
                request.getSession().setAttribute("errorMessage", message);
            }
        } catch (NumberFormatException e) {
            System.out.println(e);
            request.getSession().setAttribute("errorMessage", "ID danh mục không hợp lệ.");
        }
        response.sendRedirect(request.getContextPath() + "/admin/category");
    }

    @Override
    public String getServletInfo() {
        return "Servlet for managing categories with CSRF protection";
    }
}