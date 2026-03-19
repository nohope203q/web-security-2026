package data;

import jakarta.persistence.*;
import java.time.LocalDate;
import java.util.*;
import model.Coupon;

public class CouponDAO {

    private static EntityManager em() {
        return DBUtil.getEmFactory().createEntityManager();
    }

    public static void insert(Coupon c) {
        tx(em(), em -> em.persist(c));
    }

    public static void update(Coupon c) {
        tx(em(), em -> em.merge(c));
    }

    public static void delete(int id) {
        tx(em(), em -> {
            Coupon c = em.find(Coupon.class, id);
            if (c != null) {
                em.remove(c);
            }
        });
    }

    public static Coupon findById(int id) {
        EntityManager em = em();
        try {
            return em.find(Coupon.class, id);
        } finally {
            em.close();
        }
    }

    public static Coupon findByCode(String code) {
        EntityManager em = em();
        try {
            List<Coupon> list = em.createQuery("SELECT c FROM Coupon c WHERE UPPER(c.code)=:code", Coupon.class)
                    .setParameter("code", code.toUpperCase()).setMaxResults(1).getResultList();
            return list.isEmpty() ? null : list.get(0);
        } finally {
            em.close();
        }
    }

    public static List<Coupon> listAll() {
        EntityManager em = em();
        try {
            return em.createQuery("SELECT c FROM Coupon c ORDER BY c.id DESC", Coupon.class).getResultList();
        } finally {
            em.close();
        }
    }
    // Helper TX

    private interface Tx {

        void run(EntityManager em);
    }

    private static void tx(EntityManager em, Tx fn) {
        try {
            em.getTransaction().begin();
            fn.run(em);
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }

    /**
     * Cập nhật status theo ngày (scheduled/active/expired)
     */
    public static void refreshStatuses() {
        LocalDate today = LocalDate.now();
        List<Coupon> all = listAll();
        for (Coupon c : all) {
            String s;
            if ("disabled".equals(c.getStatus())) {
                continue;
            }
            if (today.isBefore(c.getStartDate())) {
                s = "scheduled";
            } else if (today.isAfter(c.getEndDate())) {
                s = "expired";
            } else {
                s = "active";
            }
            if (!Objects.equals(c.getStatus(), s)) {
                c.setStatus(s);
                update(c);
            }
        }
    }
}
