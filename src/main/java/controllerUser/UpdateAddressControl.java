package controllerUser;

import data.AccountDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import model.Account;
import model.Address;

@WebServlet("/client/updateAddress")
public class UpdateAddressControl extends HttpServlet {

    private AccountDAO accountDAO = new AccountDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute("account") != null) {
            req.getRequestDispatcher("/client/UpdateAddress.jsp").forward(req, resp);
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

        // Sau khi cập nhật xong quay lại profile
        resp.sendRedirect(req.getContextPath() + "/client/profile");
    }
}
