package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.*;
import model.Coupon;
import data.CouponDAO;

@WebServlet("/admin/coupons")
public class CouponServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = Optional.ofNullable(req.getParameter("action")).orElse("list");
        switch (action) {
            case "addForm":
                req.getRequestDispatcher("/admin/coupon_form.jsp").forward(req, resp);
                return;
            case "editForm":
                int id = Integer.parseInt(req.getParameter("id"));
                req.setAttribute("coupon", CouponDAO.findById(id));
                req.getRequestDispatcher("/admin/coupon_form.jsp").forward(req, resp);
                return;
            case "delete":
                CouponDAO.delete(Integer.parseInt(req.getParameter("id")));
                resp.sendRedirect(req.getContextPath() + "/admin/coupons");
                return;
            case "toggle":
                Coupon c = CouponDAO.findById(Integer.parseInt(req.getParameter("id")));
                if (c != null) {
                    c.setStatus("disabled".equals(c.getStatus()) ? "active" : "disabled");
                    CouponDAO.update(c);
                }
                resp.sendRedirect(req.getContextPath() + "/admin/coupons");
                return;
            default:
                CouponDAO.refreshStatuses();
                req.setAttribute("coupons", CouponDAO.listAll());
                req.getRequestDispatcher("/admin/coupons.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        req.setCharacterEncoding("UTF-8");
        String idStr = req.getParameter("id");
        String code = req.getParameter("code").toUpperCase().replaceAll("\\s+", "");
        String type = req.getParameter("type");
        BigDecimal value = new BigDecimal(req.getParameter("value"));
        BigDecimal minOrder = new BigDecimal(Optional.ofNullable(req.getParameter("minOrder")).orElse("0"));
        String maxDiscountStr = req.getParameter("maxDiscount");
        BigDecimal maxDiscount = (maxDiscountStr == null || maxDiscountStr.isBlank()) ? null : new BigDecimal(maxDiscountStr);
        String usageLimitStr = req.getParameter("usageLimit");
        Integer usageLimit = (usageLimitStr == null || usageLimitStr.isBlank()) ? null : Integer.valueOf(usageLimitStr);
        LocalDate startDate = LocalDate.parse(req.getParameter("startDate"));
        LocalDate endDate = LocalDate.parse(req.getParameter("endDate"));

        // Validate
        List<String> errs = new ArrayList<>();
        if (!"PERCENT".equals(type) && !"FIXED".equals(type)) {
            errs.add("Loại mã không hợp lệ");
        }
        if ("PERCENT".equals(type) && (value.compareTo(BigDecimal.ZERO) < 0 || value.compareTo(new BigDecimal("100")) > 0)) {
            errs.add("Giá trị % phải từ 0–100");
        }
        if (endDate.isBefore(startDate)) {
            errs.add("Ngày kết thúc phải sau hoặc bằng ngày bắt đầu");
        }
        Coupon dup = CouponDAO.findByCode(code);
        if (dup != null && (idStr == null || dup.getId() != Integer.parseInt(idStr))) {
            errs.add("Mã đã tồn tại");
        }

        if (!errs.isEmpty()) {
            req.setAttribute("errors", errs);
            req.setAttribute("coupon", build(code, type, value, minOrder, maxDiscount, usageLimit, startDate, endDate, idStr));
            req.getRequestDispatcher("/admin/coupon_form.jsp").forward(req, resp);
            return;
        }

        Coupon coupon = (idStr == null || idStr.isBlank()) ? new Coupon() : CouponDAO.findById(Integer.parseInt(idStr));
        coupon.setCode(code);
        coupon.setType(type);
        coupon.setValue(value);
        coupon.setMinOrder(minOrder);
        coupon.setMaxDiscount(maxDiscount);
        coupon.setUsageLimit(usageLimit);
        coupon.setStartDate(startDate);
        coupon.setEndDate(endDate);
        // status sẽ được refreshStatuses() set theo ngày
        if (coupon.getId() == null) {
            CouponDAO.insert(coupon);
        } else {
            CouponDAO.update(coupon);
        }

        resp.sendRedirect(req.getContextPath() + "/admin/coupons");
    }

    private Coupon build(String code, String type, BigDecimal value, BigDecimal minOrder, BigDecimal maxDiscount, Integer usageLimit, LocalDate s, LocalDate e, String id) {
        Coupon c = new Coupon();
        c.setCode(code);
        c.setType(type);
        c.setValue(value);
        c.setMinOrder(minOrder);
        c.setMaxDiscount(maxDiscount);
        c.setUsageLimit(usageLimit);
        c.setStartDate(s);
        c.setEndDate(e);
        if (id != null && !id.isBlank()) {
            c.setId(Integer.parseInt(id));
        }
        return c;
    }
}
