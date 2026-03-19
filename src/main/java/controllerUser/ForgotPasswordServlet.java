package controllerUser;

import data.AccountDAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Account;
import data.EmailUtil;
import java.io.IOException;

@WebServlet("/client/forgotPassword")
public class ForgotPasswordServlet extends HttpServlet {

    private AccountDAO accountDAO = new AccountDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String email = req.getParameter("email");
        Account acc = accountDAO.findByEmail(email);

        if (acc != null) {
            String otp = String.valueOf((int) (Math.random() * 900000) + 100000);
            req.getSession().setAttribute("otp", otp);
            req.getSession().setAttribute("email", email);

            String subject = "Xác nhận OTP khôi phục mật khẩu";
            String body = "Mã OTP của bạn là: " + otp + "\nMã có hiệu lực trong 5 phút.";

            boolean sent = EmailUtil.sendEmail(email, subject, body);
            if (sent) {
                req.getRequestDispatcher("/client/verifyOTP.jsp").forward(req, resp);
            } else {
                req.setAttribute("error", "Không thể gửi email. Vui lòng thử lại!");
                req.getRequestDispatcher("/client/forgotPassword.jsp").forward(req, resp);
            }
        } else {
            req.setAttribute("error", "Email không tồn tại!");
            req.getRequestDispatcher("/client/forgotPassword.jsp").forward(req, resp);
        }
    }
}
