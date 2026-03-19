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
import model.Address;

@WebServlet("/client/profile")
public class UserProfileServlet extends HttpServlet {

    private AccountDAO accountDAO = new AccountDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute("account") != null) {
            Account currentAccount = (Account) session.getAttribute("account");

            currentAccount = accountDAO.findById(currentAccount.getId());

            session.setAttribute("account", currentAccount);

            req.getRequestDispatcher("profile.jsp").forward(req, resp);
        } else {
            resp.sendRedirect("login.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("account") == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        Account currentAccount = (Account) session.getAttribute("account");

        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String phone = req.getParameter("phone");

        currentAccount.setName(name);
        currentAccount.setEmail(email);
        currentAccount.setPhone(phone);

        String street = req.getParameter("street");
        String city = req.getParameter("city");
        String postalCode = req.getParameter("postalCode");

        Address address = currentAccount.getAddress();
        if (address == null) {
            address = new Address();
        }
        address.setStreet(street);
        address.setCity(city);
        address.setPostalCode(postalCode);
        currentAccount.setAddress(address);

        accountDAO.update(currentAccount);

        session.setAttribute("account", currentAccount);

        req.setAttribute("message", "Profile updated successfully!");
        req.getRequestDispatcher("profile.jsp").forward(req, resp);
    }
}
