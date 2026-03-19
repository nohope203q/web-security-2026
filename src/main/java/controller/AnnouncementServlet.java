package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.*;
import model.Announcement;
import data.AnnouncementDAO;
import java.text.SimpleDateFormat;

@WebServlet("/admin/announcements")
public class AnnouncementServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // --- Bổ sung kiểm tra phân quyền Admin tại đây ---
        String action = req.getParameter("action");
        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "delete":
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
        String action = req.getParameter("action"); // "insert" | "update"

        Announcement a = new Announcement();
        a.setTitle(req.getParameter("title"));
        a.setContent(req.getParameter("content"));

        // Parse ngày CHẶT chẽ
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        sdf.setLenient(false);

        Date start, end;
        Date today = new Date();
        try {
            start = sdf.parse(req.getParameter("startDate"));
            end = sdf.parse(req.getParameter("endDate"));
        } catch (Exception e) {
            req.setAttribute("error", "Ngày không hợp lệ (định dạng yyyy-MM-dd).");
            // giữ lại dữ liệu user đã nhập
            req.setAttribute("announcements", a);
            req.getRequestDispatcher("/admin/announcement_form.jsp").forward(req, resp);
            return;
        }

        // ✅ VALIDATE: end phải >= start
        if (end.before(start) && end.before(today)) {
            req.setAttribute("error", "Ngày kết thúc phải ngày bắt đầu hoặc ngày kết thúc phải lớn hơn ngày hiện tại.");
            a.setStartDate(start);
            a.setEndDate(end);
            req.setAttribute("announcements", a); // để form hiển thị lại
            req.getRequestDispatcher("/admin/announcement_form.jsp").forward(req, resp);
            return;
        }

        a.setStartDate(start);
        a.setEndDate(end);

        String status = req.getParameter("status");
        if (status == null || status.isBlank()) {
            status = "active";
        }
        a.setStatus(deriveStatus(start, end));

        if ("update".equals(action)) {
            String idParam = req.getParameter("id");
            if (idParam != null && !idParam.trim().isEmpty()) {
                try {
                    int id = Integer.parseInt(idParam);
                    a.setId(id);
                    AnnouncementDAO.update(a);
                } catch (NumberFormatException e) {
                    resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid ID format for update.");
                    return;
                }
            }
        } else if ("insert".equals(action)) {
            AnnouncementDAO.insert(a);
        } else {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Unknown action.");
            return;
        }

        resp.sendRedirect(req.getContextPath() + "/admin/announcements");
    }

    // --- Các Phương thức mới/đã sửa để đảm bảo an toàn ---
    private void handleDelete(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String idParam = req.getParameter("id");
        if (idParam == null || idParam.trim().isEmpty()) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing ID for deletion.");
            return;
        }
        try {
            int id = Integer.parseInt(idParam);
            AnnouncementDAO.delete(id);
            // Có thể thêm message vào session
            resp.sendRedirect(req.getContextPath() + "/admin/announcements");
        } catch (NumberFormatException e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid ID format for deletion.");
        }
    }

    private void handleEditForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idParam = req.getParameter("id");
        if (idParam == null || idParam.trim().isEmpty()) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing ID for edit form.");
            return;
        }
        try {
            int idd = Integer.parseInt(idParam);
            Announcement a = AnnouncementDAO.select(idd);

            if (a != null) {
                req.setAttribute("announcements", a);
                getServletContext().getRequestDispatcher("/admin/announcement_form.jsp").forward(req, resp);
            } else {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Announcement not found.");
            }
        } catch (NumberFormatException e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid ID format for edit form.");
        }
    }

    private void showDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam == null || idParam.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing ID for viewing details.");
            return;
        }
        try {
            int id = Integer.parseInt(idParam);
            Announcement a = AnnouncementDAO.select(id);

            if (a != null) {
                request.setAttribute("announ", a);
                request.getRequestDispatcher("/admin/announ_detail.jsp").forward(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Announcement not found.");
            }
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid ID format for viewing details.");
        }
    }

    private String deriveStatus(Date start, Date end) {
        Date today = new Date();
        if (today.before(start)) {
            return "scheduled";
        }
        if (today.after(end)) {
            return "expired";
        }
        return "active";
    }
}
