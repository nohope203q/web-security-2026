package filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;
import model.Admin;
import java.io.IOException;

@WebFilter(urlPatterns = {"/admin", "/admin/*"})
public class AdminFilter implements Filter {

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;

        HttpSession session = request.getSession(false);
        Object account = (session != null) ? session.getAttribute("account") : null;

        //  Kiểm tra server-side: phải là Admin mới được vào
        if (account instanceof Admin) {
            chain.doFilter(req, res);
        } else {
            // Redirect về trang login nếu không có quyền
            response.sendRedirect(request.getContextPath() + "/client/login");
        }
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void destroy() {}
}