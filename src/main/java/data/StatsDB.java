package data;

import jakarta.persistence.EntityManager;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.*;
import java.time.format.DateTimeFormatter;

public class StatsDB {

    private static EntityManager em() {
        return DBUtil.getEmFactory().createEntityManager();
    }

    private static final DateTimeFormatter fmt = DateTimeFormatter.ofPattern("yyyy-MM-dd");

    // === 1️⃣ Doanh thu theo ngày ===
    public static List<Map<String, Object>> revenuePerDay(LocalDate from, LocalDate to) {
        EntityManager em = em();
        List<Map<String, Object>> list = new ArrayList<>();
        try {
            LocalDateTime fromDt = from.atStartOfDay();
            LocalDateTime toDt = to.plusDays(1).atStartOfDay();

            List<Object[]> raw = em.createQuery(
                    "SELECT FUNCTION('DATE', o.dateOrder), SUM(oi.product.price * oi.quantity) "
                    + "FROM Order o JOIN o.orderItems oi "
                    + "WHERE o.dateOrder >= :from AND o.dateOrder < :to "
                    + "GROUP BY FUNCTION('DATE', o.dateOrder) "
                    + "ORDER BY FUNCTION('DATE', o.dateOrder)",
                    Object[].class)
                    .setParameter("from", Timestamp.valueOf(fromDt))
                    .setParameter("to", Timestamp.valueOf(toDt))
                    .getResultList();

            for (Object[] row : raw) {
                Map<String, Object> m = new HashMap<>();
                java.sql.Date d = (java.sql.Date) row[0];
                m.put("date", d.toLocalDate().format(fmt));
                m.put("value", row[1] == null ? 0 : row[1]);
                list.add(m);
            }
        } finally {
            em.close();
        }
        return list;
    }

    // === 2️⃣ Đơn hàng theo ngày ===
    public static List<Map<String, Object>> ordersPerDay(LocalDate from, LocalDate to) {
        EntityManager em = em();
        List<Map<String, Object>> list = new ArrayList<>();
        try {
            LocalDateTime fromDt = from.atStartOfDay();
            LocalDateTime toDt = to.plusDays(1).atStartOfDay();

            List<Object[]> raw = em.createQuery(
                    "SELECT FUNCTION('DATE', o.dateOrder), COUNT(o) "
                    + "FROM Order o "
                    + "WHERE o.dateOrder >= :from AND o.dateOrder < :to "
                    + "GROUP BY FUNCTION('DATE', o.dateOrder) "
                    + "ORDER BY FUNCTION('DATE', o.dateOrder)",
                    Object[].class)
                    .setParameter("from", Timestamp.valueOf(fromDt))
                    .setParameter("to", Timestamp.valueOf(toDt))
                    .getResultList();

            for (Object[] row : raw) {
                Map<String, Object> m = new HashMap<>();
                java.sql.Date d = (java.sql.Date) row[0];
                m.put("date", d.toLocalDate().format(fmt));
                m.put("value", ((Number) row[1]).intValue());
                list.add(m);
            }
        } finally {
            em.close();
        }
        return list;
    }

    // === 3️⃣ Người đăng ký mới theo ngày ===
    public static List<Map<String, Object>> newUsersPerDay(LocalDate from, LocalDate to) {
        EntityManager em = em();
        List<Map<String, Object>> list = new ArrayList<>();
        try {
            LocalDateTime fromDt = from.atStartOfDay();
            LocalDateTime toDt = to.plusDays(1).atStartOfDay();

            List<Object[]> raw = em.createQuery(
                    "SELECT FUNCTION('DATE', a.createdAt), COUNT(a) "
                    + "FROM Account a "
                    + "WHERE a.createdAt >= :from AND a.createdAt < :to "
                    + "GROUP BY FUNCTION('DATE', a.createdAt) "
                    + "ORDER BY FUNCTION('DATE', a.createdAt)",
                    Object[].class)
                    .setParameter("from", Timestamp.valueOf(fromDt))
                    .setParameter("to", Timestamp.valueOf(toDt))
                    .getResultList();

            for (Object[] row : raw) {
                Map<String, Object> m = new HashMap<>();
                java.sql.Date d = (java.sql.Date) row[0];
                m.put("date", d.toLocalDate().format(fmt));
                m.put("value", ((Number) row[1]).intValue());
                list.add(m);
            }
        } finally {
            em.close();
        }
        return list;
    }
}
