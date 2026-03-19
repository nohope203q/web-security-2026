package controllerUser;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import jakarta.persistence.*;
import model.Account;
import model.Order;
import model.Product;
import data.DBUtil;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "OrderTrackingServlet", urlPatterns = {"/client/order-tracking"})
public class OrderTrackingControl extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Account currentUser = (Account) session.getAttribute("account");

        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/client/login.jsp");
            return;
        }

        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        String statusParam = request.getParameter("status");
        String keyword = request.getParameter("keyword");
        List<Order> orders;

        try {
            String jpql = "SELECT DISTINCT o FROM Order o "
                    + "LEFT JOIN FETCH o.orderItems oi "
                    + "LEFT JOIN FETCH oi.product p "
                    + "WHERE o.user.id = :userId ";

            if (statusParam != null && !statusParam.equals("all") && !statusParam.isEmpty()) {
                jpql += "AND o.status = :status ";
            }

            if (keyword != null && !keyword.trim().isEmpty()) {
                jpql += "AND (LOWER(p.name) LIKE LOWER(:keyword) "
                        + "OR LOWER(o.shippingAddress) LIKE LOWER(:keyword) "
                        + "OR CAST(o.id AS string) LIKE :keyword) ";
            }

            jpql += "ORDER BY o.dateOrder DESC";

            TypedQuery<Order> query = em.createQuery(jpql, Order.class);

            query.setParameter("userId", currentUser.getId());

            if (statusParam != null && !statusParam.equals("all") && !statusParam.isEmpty()) {
                try {
                    query.setParameter("status", Integer.parseInt(statusParam));
                } catch (NumberFormatException e) {
                    // Bỏ qua nếu status không phải là số
                }
            }

            if (keyword != null && !keyword.trim().isEmpty()) {
                query.setParameter("keyword", "%" + keyword.trim() + "%");
            }

            orders = query.getResultList();

            for (Order order : orders) {
                order.getOrderItems().forEach(item -> {
                    Product p = item.getProduct();
                    if (p != null) {
                        p.getName();
                    }
                    item.getSubtotal();
                });
                order.getTotalPrice();
            }

            request.setAttribute("orders", orders);
            request.setAttribute("activeTab", statusParam != null ? statusParam : "all");
            request.setAttribute("keyword", keyword);
            request.getRequestDispatcher("/client/order-tracking.jsp").forward(request, response);

        } finally {
            em.close();
        }
    }
}
