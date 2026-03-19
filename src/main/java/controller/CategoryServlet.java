/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import data.CategoryDAO;
import model.Category;
import model.Product;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author Admin
 */
@WebServlet(name = "CategoryServlet", urlPatterns = {"/admin/category"})
public class CategoryServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "list"; // Mặc định là hiển thị danh sách
        }

        String url = "/admin/category.jsp";
        switch (action) {
            case "list" -> {
                // Mặc định, không cần làm gì thêm
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
                // Xử lý xóa category và redirect
                handleDelete(request, response);
                return; // Thoát khỏi doGet sau khi redirect
            }
        }

        // Luôn lấy danh sách categories để hiển thị trong bảng chính
        List<Category> categories = CategoryDAO.getAllCategory();
        request.setAttribute("categories", categories);

        getServletContext().getRequestDispatcher(url).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            response.sendRedirect(request.getContextPath() + "/admin/category");
            return;
        }

        switch (action) {
            case "add" ->
                handleAdd(request);
            case "update" ->
                handleUpdate(request);
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

    /**
     * Xử lý xóa danh mục với ràng buộc kiểm tra sản phẩm tồn tại.
     */
    private void handleDelete(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));

            // --- BƯỚC QUAN TRỌNG: KIỂM TRA RÀNG BUỘC ---
            // Chỉ xóa category khi không có sản phẩm nào thuộc về nó
            List<Product> products = CategoryDAO.getProductsByCategory(id);

            if (products == null || products.isEmpty()) {
                // Nếu không có sản phẩm, tiến hành xóa
                CategoryDAO.delete(id);
            } else {
                // Nếu có sản phẩm, không xóa và gửi thông báo lỗi về cho JSP
                String message = "Không thể xóa danh mục này vì nó đang chứa sản phẩm.";

                // Sử dụng session để lưu message qua redirect
                request.getSession().setAttribute("errorMessage", message);
            }
        } catch (NumberFormatException e) {
            System.out.println(e);
            request.getSession().setAttribute("errorMessage", "ID danh mục không hợp lệ.");
        }

        // Chuyển hướng người dùng trở lại trang quản lý danh mục
        response.sendRedirect(request.getContextPath() + "/admin/category");
    }

    @Override
    public String getServletInfo() {
        return "Servlet for managing categories";
    }
}
