package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.*;
import model.Announcement;
import data.AnnouncementDAO;
import controller.CsrfUtil; 
import java.text.SimpleDateFormat;

@WebServlet("/admin/announcements")
public class AnnouncementServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "delete":
                // --- BƯỚC 2: CHECK TOKEN CHO HÀNH ĐỘNG XÓA QUA URL (GET) ---
                if (!CsrfUtil.isValidToken(req)) {
                    resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Yêu cầu không hợp lệ (CSRF)");
                    return;
                }
                handleDelete(req, resp);
                return;
            case "addForm":
                getServletContext().getRequestDispatcher("/admin/announcement_form.jsp").forward(req, resp);
                return;
            case "editForm":
                handleEditForm(req, resp);
                return;
            case "view":
                showDetail(req, resp);
                return;
            default:
                List<Announcement> list = AnnouncementDAO.selectAll();
                req.setAttribute("announcements", list);
                getServletContext().getRequestDispatcher("/admin/announcements.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        // --- BƯỚC 3: CHECK TOKEN KHI SUBMIT FORM (INSERT/UPDATE) ---
        if (!CsrfUtil.isValidToken(req)) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Phiên làm việc hết hạn hoặc yêu cầu không hợp lệ");
            return;
        }

        String action = req.getParameter("action"); // "insert" | "update"

        Announcement a = new Announcement();
        a.setTitle(req.getParameter("title"));
        a.setContent(req.getParameter("content"));

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        sdf.setLenient(false);

        Date start, end;
        Date today = new Date();
        try {
            start = sdf.parse(req.getParameter("startDate"));
            end = sdf.parse(req.getParameter("endDate"));
        } catch (Exception e) {
            // Nếu lỗi form, tạo lại token để form tiếp theo vẫn an toàn
            req.setAttribute("csrfToken", CsrfUtil.generateToken(req));
            req.setAttribute("error", "Ngày không hợp lệ (định dạng yyyy-MM-dd).");
            req.setAttribute("announcements", a);
            req.getRequestDispatcher("/admin/announcement_form.jsp").forward(req, resp);
            return;
        }

        if (end.before(start)) {
            req.setAttribute("csrfToken", CsrfUtil.generateToken(req));
            req.setAttribute("error", "Ngày kết thúc phải sau ngày bắt đầu.");
            a.setStartDate(start);
            a.setEndDate(end);
            req.setAttribute("announcements", a); 
            req.getRequestDispatcher("/admin/announcement_form.jsp").forward(req, resp);
            return;
        }

        a.setStartDate(start);
        a.setEndDate(end);
        a.setStatus(deriveStatus(start, end));

        if ("update".equals(action)) {
            String idParam = req.getParameter("id");
            if (idParam != null && !idParam.trim().isEmpty()) {
                try {
                    int id = Integer.parseInt(idParam);
                    a.setId(id);
                    AnnouncementDAO.update(a);
                } catch (NumberFormatException e) {
                    resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid ID format.");
                    return;
                }
            }
        } else if ("insert".equals(action)) {
            AnnouncementDAO.insert(a);
        }

        resp.sendRedirect(req.getContextPath() + "/admin/announcements");
    }

    private void handleDelete(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String idParam = req.getParameter("id");
        if (idParam != null && !idParam.trim().isEmpty()) {
            try {
                int id = Integer.parseInt(idParam);
                AnnouncementDAO.delete(id);
                resp.sendRedirect(req.getContextPath() + "/admin/announcements");
            } catch (NumberFormatException e) {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid ID format.");
            }
        }
    }

    private void handleEditForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idParam = req.getParameter("id");
        if (idParam != null && !idParam.trim().isEmpty()) {
            try {
                int id = Integer.parseInt(idParam);
                Announcement a = AnnouncementDAO.select(id);
                if (a != null) {
                    req.setAttribute("announcements", a);
                    getServletContext().getRequestDispatcher("/admin/announcement_form.jsp").forward(req, resp);
                } else {
                    resp.sendError(HttpServletResponse.SC_NOT_FOUND);
                }
            } catch (NumberFormatException e) {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST);
            }
        }
    }

    private void showDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam != null && !idParam.trim().isEmpty()) {
            try {
                int id = Integer.parseInt(idParam);
                Announcement a = AnnouncementDAO.select(id);
                if (a != null) {
                    request.setAttribute("announ", a);
                    request.getRequestDispatcher("/admin/announ_detail.jsp").forward(request, response);
                } else {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND);
                }
            } catch (NumberFormatException e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            }
        }
    }

    private String deriveStatus(Date start, Date end) {
        Date today = new Date();
        // Reset thời gian về 00:00:00 để so sánh ngày chính xác
        Calendar cal = Calendar.getInstance();
        cal.setTime(today);
        cal.set(Calendar.HOUR_OF_DAY, 0);
        cal.set(Calendar.MINUTE, 0);
        cal.set(Calendar.SECOND, 0);
        cal.set(Calendar.MILLISECOND, 0);
        Date todayReset = cal.getTime();

        if (todayReset.before(start)) return "scheduled";
        if (todayReset.after(end)) return "expired";
        return "active";
    }
}