package controllerUser;

import data.AccountDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import model.Account;
import model.User;
import model.Admin;
import model.LineItem;
import data.LineItemDAO;
import java.util.List;

@WebServlet("/client/login")
public class LoginServlet extends HttpServlet {

    private final AccountDAO accountDAO = new AccountDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/client/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String contextPath = req.getContextPath();

        Account account = accountDAO.findByEmail(email);

        if (account != null && account.getPassword().equals(data.PasswordUtil.hashPassword(password))) {
            HttpSession session = req.getSession();
            session.setAttribute("account", account);

            if (account instanceof User) {
                // Tải giỏ hàng của người dùng từ DB và đưa vào session
                List<LineItem> cart = LineItemDAO.getCartItemsByUser((User) account);
                session.setAttribute("cart", cart);
            }

            // **LOGIC CHUYỂN HƯỚNG THÔNG MINH**
            // Kiểm tra xem có URL cần quay lại được lưu trong session không
            String redirectUrl = (String) session.getAttribute("redirectAfterLogin");

            // Xóa thuộc tính này khỏi session để nó không được sử dụng lại
            session.removeAttribute("redirectAfterLogin");

            if (redirectUrl != null && !redirectUrl.isEmpty()) {
                resp.sendRedirect(redirectUrl); // Quay về trang người dùng muốn truy cập trước đó
            } else {
                // Nếu không có, chuyển hướng về trang mặc định dựa trên vai trò
                if (account instanceof Admin) {
                    session.setAttribute("isAdmin", true);
                    resp.sendRedirect(contextPath + "/admin/admin.jsp");
                } else {
                    resp.sendRedirect(contextPath + "/home");
                }
            }
        } else {
            // Xử lý đăng nhập thất bại
            req.setAttribute("error", "Invalid email or password");
            req.getRequestDispatcher("login.jsp").forward(req, resp);
        }
    }
}
