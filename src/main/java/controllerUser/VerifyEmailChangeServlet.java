package controllerUser;

import data.AccountDAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import model.Account;

@WebServlet("/client/VerifyEmailChangeServlet")
public class VerifyEmailChangeServlet extends HttpServlet {

    private AccountDAO accountDAO = new AccountDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        String inputOtp = req.getParameter("otp");
        String sessionOtp = (String) session.getAttribute("otp");

        if (sessionOtp == null || !sessionOtp.equals(inputOtp)) {
            req.setAttribute("error", "Mã OTP không hợp lệ hoặc đã hết hạn!");
            req.getRequestDispatcher("/client/verifyEmailChange.jsp").forward(req, resp);
            return;
        }

        Account account = (Account) session.getAttribute("account");
        if (account == null) {
            resp.sendRedirect(req.getContextPath() + "/client/login");
            return;
        }

        // Cập nhật thông tin mới
        String newName = (String) session.getAttribute("pendingName");
        String newPhone = (String) session.getAttribute("pendingPhone");
        String newEmail = (String) session.getAttribute("pendingEmail");

        account.setName(newName);
        account.setPhone(newPhone);
        account.setEmail(newEmail);

        boolean updated = accountDAO.updateProfile(account);

        if (updated) {
            // Cập nhật lại session
            session.setAttribute("account", account);
            session.removeAttribute("otp");
            session.removeAttribute("pendingName");
            session.removeAttribute("pendingPhone");
            session.removeAttribute("pendingEmail");

            req.setAttribute("message", "Cập nhật thông tin thành công!");
            req.getRequestDispatcher("/client/profile.jsp").forward(req, resp);
        } else {
            req.setAttribute("error", "Không thể cập nhật thông tin!");
            req.getRequestDispatcher("/client/verifyEmailChange.jsp").forward(req, resp);
        }
    }
}
