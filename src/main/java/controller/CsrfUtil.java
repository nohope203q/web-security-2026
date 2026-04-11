package controller;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import java.util.UUID;

public class CsrfUtil {
    public static String generateToken(HttpServletRequest request) {
        String token = UUID.randomUUID().toString();
        request.getSession().setAttribute("csrfToken", token);
        return token;
    }

    public static boolean isValidToken(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) return false;
        String sessionToken = (String) session.getAttribute("csrfToken");
        String requestToken = request.getParameter("_csrf");
        return sessionToken != null && sessionToken.equals(requestToken);
    }
}