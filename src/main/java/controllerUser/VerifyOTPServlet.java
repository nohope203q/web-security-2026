package controllerUser;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/client/verifyOtp")
public class VerifyOTPServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String otp = request.getParameter("otp");

        HttpSession session = request.getSession();
        String storedOtp = (String) session.getAttribute("otp");

        if (storedOtp != null && storedOtp.equals(otp)) {
            // OTP hợp lệ → chuyển sang đặt lại mật khẩu
            response.sendRedirect(request.getContextPath() + "/client/resetPassword.jsp");
        } else {
            // OTP sai → báo lỗi
            request.setAttribute("error", "Mã OTP không hợp lệ hoặc đã hết hạn!");
            request.getRequestDispatcher("/client/verifyOTP.jsp").forward(request, response);
        }
    }
}
