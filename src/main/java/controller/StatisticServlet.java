package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.time.*;
import java.util.*;
import com.google.gson.Gson;
import data.StatsDB;

@WebServlet("/admin/statistic")
public class StatisticServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        resp.setContentType("application/json; charset=UTF-8");

        LocalDate today = LocalDate.now();
        LocalDate from, to;

        String fromStr = req.getParameter("from");
        String toStr = req.getParameter("to");
        String range = req.getParameter("range");

        if (fromStr != null && toStr != null) {
            from = LocalDate.parse(fromStr);
            to = LocalDate.parse(toStr);
        } else {
            if (range == null) {
                range = "this_month";
            }
            switch (range) {
                case "today" -> {
                    from = today;
                    to = today;
                }
                case "yesterday" -> {
                    from = today.minusDays(1);
                    to = today.minusDays(1);
                }
                case "this_week" -> {
                    var start = today.with(java.time.DayOfWeek.MONDAY);
                    from = start;
                    to = start.plusDays(6);
                }
                case "last_week" -> {
                    var start = today.with(java.time.DayOfWeek.MONDAY).minusWeeks(1);
                    from = start;
                    to = start.plusDays(6);
                }
                case "last_month" -> {
                    var first = today.minusMonths(1).withDayOfMonth(1);
                    from = first;
                    to = first.withDayOfMonth(first.lengthOfMonth());
                }
                default -> {
                    var first = today.withDayOfMonth(1);
                    from = first;
                    to = first.withDayOfMonth(first.lengthOfMonth());
                }
            }
        }

        var rev = StatsDB.revenuePerDay(from, to);
        var ord = StatsDB.ordersPerDay(from, to);
        var usr = StatsDB.newUsersPerDay(from, to);

        double totalRev = rev.stream().mapToDouble(x -> ((Number) x.get("value")).doubleValue()).sum();
        long totalOrd = ord.stream().mapToLong(x -> ((Number) x.get("value")).longValue()).sum();
        long totalUsr = usr.stream().mapToLong(x -> ((Number) x.get("value")).longValue()).sum();

        Map<String, Object> data = new HashMap<>();
        data.put("from", from.toString());
        data.put("to", to.toString());
        data.put("revenueByDay", rev);
        data.put("ordersByDay", ord);
        data.put("newUsersByDay", usr);
        data.put("totals", Map.of("revenue", totalRev, "orders", totalOrd, "users", totalUsr));

        resp.getWriter().write(new Gson().toJson(data));
//        RequestDispatcher dispatcher = req.getRequestDispatcher("/admin/statistic.jsp");
//        dispatcher.forward(req, resp);
    }
}
