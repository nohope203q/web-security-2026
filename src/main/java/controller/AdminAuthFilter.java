package controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Set;

@WebFilter(urlPatterns = {"/admin/*"})
public class AdminAuthFilter implements Filter {

    private static final Set<String> WHITELIST = Set.of();

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        String ctx = req.getContextPath();            // /project_web_Khang
        String uri = req.getRequestURI();             // /project_web_Khang/admin/...
        String path = uri.substring(ctx.length());    // /admin/...

        for (String open : WHITELIST) {
            if (path.equals(open) || path.startsWith(open)) {
                chain.doFilter(request, response);
                return;
            }
        }

        HttpSession session = req.getSession(false);

        Object user = (session == null) ? null : session.getAttribute("account");
        if (user == null) {
            String returnUrl = req.getRequestURI() + (req.getQueryString() != null ? "?" + req.getQueryString() : "");
            resp.sendRedirect(ctx + "/");
            return;
        }

        Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
        if (isAdmin == null || !isAdmin) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền truy cập khu vực quản trị.");
            return;
        }

        resp.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        resp.setHeader("Pragma", "no-cache");
        resp.setDateHeader("Expires", 0);

        chain.doFilter(request, response);
    }
}
