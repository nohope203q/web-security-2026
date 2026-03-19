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
                List<LineItem> cart = LineItemDAO.getCartItemsByUser((User) account);
                session.setAttribute("cart", cart);
            }

            String redirectUrl = (String) session.getAttribute("redirectAfterLogin");

            session.removeAttribute("redirectAfterLogin");

            if (redirectUrl != null && !redirectUrl.isEmpty()) {
                resp.sendRedirect(redirectUrl);
            } else {
                if (account instanceof Admin) {
                    session.setAttribute("isAdmin", true);
                    resp.sendRedirect(contextPath + "/admin/admin.jsp");
                } else {
                    resp.sendRedirect(contextPath + "/home");
                }
            }
        } else {
            req.setAttribute("error", "Invalid email or password");
            req.getRequestDispatcher("login.jsp").forward(req, resp);
        }
    }
}
