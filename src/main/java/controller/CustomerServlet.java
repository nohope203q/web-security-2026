package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import data.UserDB;
import jakarta.servlet.annotation.WebServlet;
import model.User;
import controller.CsrfUtil;

@WebServlet("/admin/customer")
public class CustomerServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        

        String action = request.getParameter("action");
        if (action == null) {
            action = "search";
        }

        String url = "/admin/users.jsp";

        switch (action) {
            case "search":
                listUsers(request, response);
                return;
            case "viewCustomer":
                showDetail(request, response);
                break;
            case "deleteCustomer":
                // --- BƯỚC 2: KIỂM TRA TOKEN TRƯỚC KHI THỰC HIỆN XÓA (VÌ XÓA ĐANG DÙNG GET) ---
                if (!CsrfUtil.isValidToken(request)) {
                    response.sendError(HttpServletResponse.SC_FORBIDDEN, "Yêu cầu bị từ chối: CSRF Token không hợp lệ.");
                    return;
                }
                deleteUser(request, response);
                // Lưu ý: deleteUser bên dưới đã có sendRedirect nên không cần thêm ở đây nữa
                return;
            default:
                listUsers(request, response);
                return;
        }

        getServletContext().getRequestDispatcher(url).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Nếu sau này mầy thêm tính năng Update User bằng POST thì nhớ gọi CsrfUtil.isValidToken(request) ở đây nhé.
        doGet(request, response);
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

        // Thực hiện xóa cascade (xóa các dữ liệu liên quan để tránh lỗi ràng buộc FK)
        boolean ok = UserDB.deleteUserCascade(userId);

        if (ok) {
            response.sendRedirect(request.getContextPath() + "/admin/customer");
        } else {
            // Nếu lỗi, quay lại trang danh sách và báo lỗi
            request.setAttribute("error", "Không thể xóa user do lỗi ràng buộc dữ liệu hoặc lỗi hệ thống.");
            listUsers(request, response);
        }
    }

    private void showDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idStr = request.getParameter("id");
        if (idStr != null) {
            try {
                int id = Integer.parseInt(idStr);
                User user = UserDB.select(id);
                if (user != null) {
                    request.setAttribute("user", user); // Đổi "users" thành "user" cho đúng ngữ nghĩa detail
                    request.getRequestDispatcher("/admin/customer_detail.jsp").forward(request, response);
                    return;
                }
            } catch (NumberFormatException e) {}
        }
        response.sendRedirect(request.getContextPath() + "/admin/customer");
    }
}