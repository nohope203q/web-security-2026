package controllerUser;

import data.AccountDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.Random;
import model.Account;
import data.EmailUtil;

@WebServlet("/client/ChangeProfileServlet")
public class ChangeProfileServlet extends HttpServlet {

    private AccountDAO accountDAO = new AccountDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        Account currentAccount = (Account) session.getAttribute("account");

        if (currentAccount == null) {
            resp.sendRedirect(req.getContextPath() + "/client/login");
            return;
        }

        String name = req.getParameter("name");
        String phone = req.getParameter("phone");
        String newEmail = req.getParameter("email");

        boolean emailChanged = !newEmail.equals(currentAccount.getEmail());

        if (emailChanged) {
            // Kiểm tra xem email mới đã tồn tại chưa
            Account existing = accountDAO.findByEmail(newEmail);
            if (existing != null) {
                req.setAttribute("Lỗi!!", "Email này đã tồn tại. Vui lòng nhập email khác!");
                req.getRequestDispatcher("/client/changeProfile.jsp").forward(req, resp);
                return;
            }

            // Tạo OTP
            String otp = String.format("%06d", new Random().nextInt(999999));
            session.setAttribute("otp", otp);
            session.setAttribute("pendingName", name);
            session.setAttribute("pendingPhone", phone);
            session.setAttribute("pendingEmail", newEmail);

            // Gửi OTP qua email mới
            String subject = "Xác nhận OTP thay đổi email - PC SHOP";
            String body = "Mã OTP của bạn là: " + otp;

            boolean sent = EmailUtil.sendEmail(newEmail, subject, body);
            if (sent) {
                req.setAttribute("message", "Đã gửi mã OTP đến email mới, vui lòng xác nhận!");
                req.getRequestDispatcher("/client/verifyEmailChange.jsp").forward(req, resp);
            } else {
                req.setAttribute("error", "Không thể gửi OTP. Vui lòng thử lại sau.");
                req.getRequestDispatcher("/client/changeProfile.jsp").forward(req, resp);
            }

        } else {
            // Không đổi email → cập nhật trực tiếp
            currentAccount.setName(name);
            currentAccount.setPhone(phone);
            boolean updated = accountDAO.updateProfile(currentAccount);

            if (updated) {
                session.setAttribute("account", currentAccount);
                req.setAttribute("message", "Cập nhật thông tin thành công!");
                req.getRequestDispatcher("/client/profile.jsp").forward(req, resp);
            } else {
                req.setAttribute("error", "Không thể cập nhật hồ sơ!");
                req.getRequestDispatcher("/client/changeProfile.jsp").forward(req, resp);
            }
        }
    }
}
