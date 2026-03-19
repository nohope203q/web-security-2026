package controllerUser;

import data.AccountDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import data.PasswordUtil;

@WebServlet("/client/resetPassword")
public class ResetPasswordServlet extends HttpServlet {

    private AccountDAO accountDAO = new AccountDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/client/resetPassword.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        HttpSession session = request.getSession(false);
        String email = (String) session.getAttribute("email");

        if (email == null) {
            request.setAttribute("error", "Phiên đã hết hạn, vui lòng gửi lại OTP.");
            request.getRequestDispatcher("/client/resetPassword.jsp").forward(request, response);
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "Mật khẩu không khớp!");
            request.getRequestDispatcher("/client/resetPassword.jsp").forward(request, response);
            return;
        }
        if (!PasswordUtil.isStrongPassword(newPassword)) {
            request.setAttribute("error", "Mật khẩu phải có ít nhất 8 ký tự, bao gồm chữ hoa, chữ thường, số và ký tự đặc biệt!");
            request.getRequestDispatcher("/client/resetPassword.jsp").forward(request, response);
            return;
        }

        AccountDAO dao = new AccountDAO();
        boolean ok = dao.updatePassword(email, newPassword);

        if (ok) {
            session.removeAttribute("email");
            request.setAttribute("message", "Đổi mật khẩu thành công!");
            request.getRequestDispatcher("/client/login.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Lỗi hệ thống, chưa cập nhật được mật khẩu!");
            request.getRequestDispatcher("/client/resetPassword.jsp").forward(request, response);
        }
    }
}
