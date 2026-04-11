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
import controller.CsrfUtil;

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
                // --- BƯỚC 2: KIỂM TRA TOKEN KHI XÓA QUA URL ---
                if (!CsrfUtil.isValidToken(request)) {
                    response.sendError(HttpServletResponse.SC_FORBIDDEN, "CSRF Token mismatch!");
                    return;
                }
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
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Order order = OrderDAO.selectWithRelations(id); 
            List<Product> products = ProductDAO.selectAll(); 
            request.setAttribute("order", order);
            request.setAttribute("products", products);
            request.getRequestDispatcher("/admin/order-edit.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect("order");
        }
    }

    private void deleteOrder(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            OrderDAO.delete(id);
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
        response.sendRedirect(request.getContextPath() + "/admin/order");
    }

    private void showDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Order order = OrderDAO.selectWithRelations(id);
            request.setAttribute("order", order);
            request.getRequestDispatcher("/admin/order-detail.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect("order");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");

        // --- BƯỚC 3: KIỂM TRA TOKEN KHI CẬP NHẬT TRẠNG THÁI/DỮ LIỆU ĐƠN HÀNG ---
        if (!CsrfUtil.isValidToken(request)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Invalid CSRF Token");
            return;
        }

        String action = request.getParameter("action");
        if ("update".equals(action)) {
            updateOrder(request, response);
        }
    }

    private void updateOrder(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        try {
            int orderId = Integer.parseInt(request.getParameter("id"));
            Order order = OrderDAO.selectWithRelations(orderId);

            if (order != null) {
                order.setShippingAddress(request.getParameter("shippingAddress"));
                order.setPaymentMethod(request.getParameter("paymentMethod"));
                order.setStatus(Integer.parseInt(request.getParameter("status")));

                String[] productIds = request.getParameterValues("productId");
                String[] quantities = request.getParameterValues("quantity");

                // Cập nhật lại danh sách item
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
                OrderDAO.update(order);
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }

        response.sendRedirect(request.getContextPath() + "/admin/order");
    }
}