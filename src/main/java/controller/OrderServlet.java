package controller;

import data.OrderDAO;
import data.ProductDAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.*;
import model.Order;
import model.OrderItem;
import model.Product;

@WebServlet("/admin/order")
public class OrderServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "edit":
                showEditForm(request, response);
                break;
            case "delete":
                deleteOrder(request, response);
                break;
            case "detail":
                showDetail(request, response);
                break;
            default:
                listOrders(request, response);
                break;
        }
    }

    private void listOrders(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("orders", OrderDAO.selectAll());
        request.getRequestDispatcher("/admin/order.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Order order = OrderDAO.selectWithRelations(id); // Lấy order + danh sách order_items
        List<Product> products = ProductDAO.selectAll(); // để admin chọn thêm sản phẩm mới
        request.setAttribute("order", order);
        request.setAttribute("products", products);
        request.getRequestDispatcher("/admin/order-edit.jsp").forward(request, response);
    }

    private void deleteOrder(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        OrderDAO.delete(id);
        response.sendRedirect("order");
    }

    private void showDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Order order = OrderDAO.selectWithRelations(id);
        request.setAttribute("order", order);
        request.getRequestDispatcher("/admin/order-detail.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if ("update".equals(action)) {
            updateOrder(request, response);
        }
    }

    private void updateOrder(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        int orderId = Integer.parseInt(request.getParameter("id"));
        Order order = OrderDAO.selectWithRelations(orderId);

        if (order != null) {
            order.setShippingAddress(request.getParameter("shippingAddress"));
            order.setPaymentMethod(request.getParameter("paymentMethod"));
            order.setStatus(Integer.parseInt(request.getParameter("status")));

            // Lấy danh sách item từ form
            String[] productIds = request.getParameterValues("productId");
            String[] quantities = request.getParameterValues("quantity");

            // Xóa toàn bộ item cũ trước
            order.getOrderItems().clear();

            if (productIds != null && quantities != null) {
                for (int i = 0; i < productIds.length; i++) {
                    int pid = Integer.parseInt(productIds[i]);
                    int qty = Integer.parseInt(quantities[i]);

                    Product product = ProductDAO.select(pid);
                    if (product != null && qty > 0) {
                        OrderItem item = new OrderItem();
                        item.setProduct(product);
                        item.setQuantity(qty);
                        item.setOrder(order);
                        order.getOrderItems().add(item);
                    }
                }
            }

            OrderDAO.update(order); // Hibernate sẽ tự cascade update order_items nếu mapping có CascadeType.ALL
        }

        response.sendRedirect(request.getContextPath() + "/admin/order");
    }
}
