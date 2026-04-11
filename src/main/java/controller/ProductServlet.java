package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.persistence.*;
import java.io.IOException;
import java.util.List;
import model.Product;
import model.Category;
import data.DBUtil;
import controller.CsrfUtil; 
import jakarta.servlet.annotation.WebServlet;

@WebServlet("/admin/product")
public class ProductServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // --- BƯỚC 1: TẠO CSRF TOKEN MỚI CHO MỖI LẦN TRUY CẬP ---
        String csrfToken = CsrfUtil.generateToken(request);
        request.setAttribute("csrfToken", csrfToken);

        String action = request.getParameter("action");
        String keyword = request.getParameter("keyword");
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
                    // --- BƯỚC 2: KIỂM TRA TOKEN KHI XÓA QUA LINK GET ---
                    if (!CsrfUtil.isValidToken(request)) {
                        response.sendError(HttpServletResponse.SC_FORBIDDEN, "Yêu cầu không hợp lệ (CSRF Token mismatch)");
                        return;
                    }

                    if (id != null) {
                        EntityTransaction tx = em.getTransaction();
                        try {
                            Product p = em.find(Product.class, id);
                            if (p != null) {
                                tx.begin();
                                em.remove(p);
                                tx.commit();
                            }
                        } catch (Exception e) {
                            if (tx.isActive()) tx.rollback();
                        }
                    }
                    response.sendRedirect(request.getContextPath() + "/admin/product");
                    break;
                }

                default: {
                    List<Product> products;
                    if (keyword != null && !keyword.trim().isEmpty()) {
                        products = em.createQuery(
                                "SELECT p FROM Product p JOIN FETCH p.category "
                                + "WHERE LOWER(p.name) LIKE LOWER(:kw) OR LOWER(p.brand) LIKE LOWER(:kw)",
                                Product.class
                        )
                        .setParameter("kw", "%" + keyword.trim() + "%")
                        .getResultList();
                        request.setAttribute("keyword", keyword);
                    } else {
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

        // --- BƯỚC 3: KIỂM TRA TOKEN KHI SUBMIT FORM (ADD/UPDATE) ---
        if (!CsrfUtil.isValidToken(request)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Yêu cầu bị từ chối vì lý do bảo mật");
            return;
        }

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
            Category category = (categoryId != null) ? em.find(Category.class, categoryId) : null;

            Product p;
            if ("update".equals(action) && id != null) {
                p = em.find(Product.class, id);
            } else {
                p = new Product();
            }

            if (p != null) {
                p.setName(name);
                p.setDescription(description);
                p.setBrand(brand);
                p.setColor(color);
                p.setImage(image);
                p.setQuantity(quantity != null ? quantity : 0);
                p.setPrice(price != null ? price : 0.0);
                p.setSold(sold != null ? sold : 0);
                p.setCategory(category);

                if ("add".equals(action)) {
                    em.persist(p);
                } else if ("update".equals(action)) {
                    em.merge(p);
                }
            }
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }

        response.sendRedirect(request.getContextPath() + "/admin/product");
    }

    // --- CÁC HÀM HELPER PARSE DỮ LIỆU AN TOÀN ---
    private Long parseLongSafe(String s) {
        try { return (s != null && !s.isEmpty()) ? Long.parseLong(s) : null; } 
        catch (Exception e) { return null; }
    }

    private Integer parseIntSafe(String s) {
        try { return (s != null && !s.isEmpty()) ? Integer.parseInt(s) : null; } 
        catch (Exception e) { return null; }
    }

    private Double parseDoubleSafe(String s) {
        try { return (s != null && !s.isEmpty()) ? Double.parseDouble(s) : null; } 
        catch (Exception e) { return null; }
    }
}