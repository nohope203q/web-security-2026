package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import data.UserDB;
import jakarta.servlet.annotation.WebServlet;
import model.User;

@WebServlet("/admin/customer")
public class CustomerServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        if (action == null) {
            action = "search"; // Mặc định là hiển thị danh sách
        }

        String url = "/admin/users.jsp"; // Trang mặc định

        switch (action) {
            case "search":
                listUsers(request, response);
                return; // Dùng return vì đã forward bên trong phương thức
            case "viewCustomer":
                showDetail(request, response);
                break;
            case "deleteCustomer":
                deleteUser(request, response);
                response.sendRedirect(request.getContextPath() + "/admin/customer");
                return;
        }

        getServletContext().getRequestDispatcher(url).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    private void listUsers(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String searchTerm = request.getParameter("searchTerm");
        List<User> users;

        users = UserDB.searchUsers(searchTerm);

        request.setAttribute("users", users);
        request.setAttribute("searchTerm", searchTerm);
        getServletContext().getRequestDispatcher("/admin/users.jsp").forward(request, response);
    }

    
    private void deleteUser(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        String idStr = request.getParameter("id");
        if (idStr == null || idStr.isBlank()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing id");
            return;
        }

        int userId;
        try {
            userId = Integer.parseInt(idStr);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid id");
            return;
        }

        boolean ok = UserDB.deleteUserCascade(userId);

        // ✅ KHÔNG ghi gì ra response trước dòng dưới
        // chỉ redirect nếu chưa forward/in ra gì
        if (ok) {
            response.sendRedirect(request.getContextPath() + "/admin/customer");
        } else {
            request.setAttribute("error", "Không thể xóa user do lỗi ràng buộc dữ liệu.");
            // forward tới trang báo lỗi thay vì redirect
        }
    }


    private void showDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        User user = UserDB.select(id);
        request.setAttribute("users", user);
        request.getRequestDispatcher("/admin/customer_detail.jsp").forward(request, response);
    }
}
