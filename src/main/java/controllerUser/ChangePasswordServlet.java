package controllerUser;

import data.PasswordUtil;
import data.AccountDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import model.Account;

@WebServlet("/client/changePassword")
public class ChangePasswordServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private AccountDAO accountDAO = new AccountDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/client/changePassword.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("account") == null) {
            resp.sendRedirect(req.getContextPath() + "/client/login.jsp");
            return;
        }

        Account currentAcc = (Account) session.getAttribute("account");

        String oldPassword = req.getParameter("oldPassword");
        String newPassword = req.getParameter("newPassword");
        String confirmPassword = req.getParameter("confirmPassword");

        if (oldPassword == null || newPassword == null || confirmPassword == null
                || oldPassword.isEmpty() || newPassword.isEmpty() || confirmPassword.isEmpty()) {
            req.setAttribute("error", "Vui lòng nhập đầy đủ thông tin!");
            req.getRequestDispatcher("/client/changePassword.jsp").forward(req, resp);
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            req.setAttribute("error", "Mật khẩu mới và xác nhận không khớp!");
            req.getRequestDispatcher("/client/changePassword.jsp").forward(req, resp);
            return;
        }
        if (!PasswordUtil.isStrongPassword(newPassword)) {
            req.setAttribute("error", "Mật khẩu mới phải có ít nhất 8 ký tự, gồm chữ hoa, chữ thường, số và ký tự đặc biệt!");
            req.getRequestDispatcher("/client/changePassword.jsp").forward(req, resp);
            return;
        }

        Account accountDB = accountDAO.findByEmail(currentAcc.getEmail());

        if (accountDB == null) {
            req.setAttribute("error", "Tài khoản không tồn tại!");
            req.getRequestDispatcher("/client/changePassword.jsp").forward(req, resp);
            return;
        }

        String oldHashed = data.PasswordUtil.hashPassword(oldPassword);
        if (!accountDB.getPassword().equals(oldHashed)) {
            req.setAttribute("error", "Mật khẩu hiện tại không đúng!");
            req.getRequestDispatcher("/client/changePassword.jsp").forward(req, resp);
            return;
        }

        String email = (String) session.getAttribute("email");
        AccountDAO dao = new AccountDAO();
        boolean ok = dao.updatePassword(accountDB.getEmail(), newPassword);

        if (ok) {
            accountDB.setPassword(newPassword);
            session.setAttribute("account", accountDB);
            req.setAttribute("message", "Đổi mật khẩu thành công!");
            resp.sendRedirect(req.getContextPath() + "/client/profile");
        } else {
            req.setAttribute("error", "Lỗi hệ thống, chưa cập nhật được mật khẩu!");
            req.getRequestDispatcher("/client/changePassword.jsp").forward(req, resp);
        }
    }
}
