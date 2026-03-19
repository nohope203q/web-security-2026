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

    // Các đường dẫn được phép đi qua không cần login (login page, API login, static)
    private static final Set<String> WHITELIST = Set.of();

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        String ctx = req.getContextPath();            // /project_web_Khang
        String uri = req.getRequestURI();             // /project_web_Khang/admin/...
        String path = uri.substring(ctx.length());    // /admin/...

        // Cho qua nếu là whitelist (trang login, static)
        for (String open : WHITELIST) {
            if (path.equals(open) || path.startsWith(open)) {
                chain.doFilter(request, response);
                return;
            }
        }

        // Lấy session nếu có, KHÔNG tạo mới
        HttpSession session = req.getSession(false);

        // Kiểm tra đã đăng nhập chưa
        Object user = (session == null) ? null : session.getAttribute("account");
        if (user == null) {
            // Chưa đăng nhập: chuyển tới trang login, kèm returnUrl để quay lại
            String returnUrl = req.getRequestURI() + (req.getQueryString() != null ? "?" + req.getQueryString() : "");
            resp.sendRedirect(ctx + "/");
            return;
        }

        // (Tuỳ chọn) Kiểm tra quyền admin
        Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
        if (isAdmin == null || !isAdmin) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền truy cập khu vực quản trị.");
            return;
        }

        // No-cache cho trang admin (back button không lộ dữ liệu sau logout)
        resp.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        resp.setHeader("Pragma", "no-cache");
        resp.setDateHeader("Expires", 0);

        // Hợp lệ -> cho đi tiếp
        chain.doFilter(request, response);
    }
}
