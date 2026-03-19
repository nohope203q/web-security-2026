package controllerUser;

import data.PasswordUtil;
import data.AccountDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import model.Account;
import model.Address;
import model.User;

@WebServlet("/client/register")
public class RegisterServlet extends HttpServlet {

    private AccountDAO accountDAO = new AccountDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/client/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String name = req.getParameter("name");
        String phone = req.getParameter("phone");
        String confirmPassword = req.getParameter("confirmPassword");
        Account existing = accountDAO.findByEmail(email);
        if (existing != null) {
            req.setAttribute("error", "Email already exists!");
            req.getRequestDispatcher("register.jsp").forward(req, resp);
            return;
        }
        if (!PasswordUtil.isStrongPassword(password)) {
            req.setAttribute("error",
                    "Mật khẩu phải có ít nhất 8 ký tự, bao gồm chữ hoa, chữ thường, số và ký tự đặc biệt!");
            req.getRequestDispatcher("/client/register.jsp").forward(req, resp);
            return;
        }
        if (!password.equals(confirmPassword)) {
            req.setAttribute("error", "Mật khẩu không khớp!");
            req.getRequestDispatcher("/client/register.jsp").forward(req, resp);
            return;
        }

        String hashedPassword = PasswordUtil.hashPassword(password);

        User newUser = new User();
        newUser.setEmail(email);
        newUser.setPassword(hashedPassword);
        newUser.setPhone(phone);
        newUser.setName(name);
        newUser.setStatus(1);
        newUser.setCreatedAt(new java.util.Date());
        newUser.setAddress(new Address());

        accountDAO.save(newUser);
        req.setAttribute("message", "Registration successful! Please login.");
        req.getRequestDispatcher("login.jsp").forward(req, resp);

    }

}
