package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.persistence.*;
import java.io.IOException;
import java.util.List;
import model.Product;
import model.Category;
import data.DBUtil;
import jakarta.servlet.annotation.WebServlet;

@WebServlet("/admin/product")
public class ProductServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String keyword = request.getParameter("keyword"); // 🔍 Lấy từ khóa tìm kiếm
        Long id = parseLongSafe(request.getParameter("id"));

        EntityManager em = DBUtil.getEmFactory().createEntityManager();

        try {
            switch (action != null ? action : "") {
                case "add": {
                    List<Category> categories = em.createQuery(
                            "SELECT c FROM Category c", Category.class).getResultList();

                    request.setAttribute("categories", categories);
                    request.setAttribute("action", "add");
                    request.getRequestDispatcher("/admin/product-edit.jsp").forward(request, response);
                    break;
                }

                case "edit": {
                    Product product = id != null ? em.find(Product.class, id) : null;
                    List<Category> categories = em.createQuery(
                            "SELECT c FROM Category c", Category.class).getResultList();

                    request.setAttribute("product", product);
                    request.setAttribute("categories", categories);
                    request.getRequestDispatcher("/admin/product-edit.jsp").forward(request, response);
                    break;
                }

                case "delete": {
                    if (id != null) {
                        EntityTransaction tx = em.getTransaction();
                        Product p = em.find(Product.class, id);
                        if (p != null) {
                            tx.begin();
                            em.remove(p);
                            tx.commit();
                        }
                    }
                    response.sendRedirect(request.getContextPath() + "/admin/product");
                    break;
                }

                default: {
                    List<Product> products;

                    if (keyword != null && !keyword.trim().isEmpty()) {
                        // 🔍 Tìm kiếm theo tên hoặc thương hiệu
                        products = em.createQuery(
                                "SELECT p FROM Product p JOIN FETCH p.category "
                                + "WHERE LOWER(p.name) LIKE LOWER(:kw) OR LOWER(p.brand) LIKE LOWER(:kw)",
                                Product.class
                        )
                                .setParameter("kw", "%" + keyword.trim() + "%")
                                .getResultList();

                        request.setAttribute("keyword", keyword);
                    } else {
                        // Hiển thị tất cả
                        products = em.createQuery(
                                "SELECT p FROM Product p JOIN FETCH p.category", Product.class
                        ).getResultList();
                    }

                    request.setAttribute("products", products);
                    request.getRequestDispatcher("/admin/product.jsp").forward(request, response);
                }
            }
        } finally {
            em.close();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        Long id = parseLongSafe(request.getParameter("id"));

        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String brand = request.getParameter("brand");
        String color = request.getParameter("color");
        String image = request.getParameter("image");

        Integer quantity = parseIntSafe(request.getParameter("quantity"));
        Double price = parseDoubleSafe(request.getParameter("price"));
        Integer sold = parseIntSafe(request.getParameter("sold"));

        Long categoryId = parseLongSafe(request.getParameter("categoryId"));

        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        EntityTransaction tx = em.getTransaction();

        try {
            tx.begin();
            Category category = em.find(Category.class, categoryId);

            Product p;
            if ("update".equals(action) && id != null) {
                p = em.find(Product.class, id);
            } else {
                p = new Product();
            }

            p.setName(name);
            p.setDescription(description);
            p.setBrand(brand);
            p.setColor(color);
            p.setImage(image);
            p.setQuantity(quantity != null ? quantity : 0);
            p.setPrice(price != null ? price : 0);
            p.setSold(sold != null ? sold : 0);
            p.setCategory(category);

            if ("add".equals(action)) {
                em.persist(p);
            } else if ("update".equals(action)) {
                em.merge(p);
            }

            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) {
                tx.rollback();
            }
            e.printStackTrace();
        } finally {
            em.close();
        }

        response.sendRedirect(request.getContextPath() + "/admin/product");
    }

    private Long parseLongSafe(String s) {
        try {
            return s != null ? Long.parseLong(s) : null;
        } catch (Exception e) {
            return null;
        }
    }

    private Integer parseIntSafe(String s) {
        try {
            return s != null ? Integer.parseInt(s) : null;
        } catch (Exception e) {
            return null;
        }
    }

    private Double parseDoubleSafe(String s) {
        try {
            return s != null ? Double.parseDouble(s) : null;
        } catch (Exception e) {
            return null;
        }
    }
}
