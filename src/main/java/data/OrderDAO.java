package data;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import java.util.List;
import model.Order;

public class OrderDAO {

    public static void insert(Order order) {
        EntityManager em = DBUtil.getEmFactory().createEntityManager();  // ✅ tạo EntityManager
        EntityTransaction trans = em.getTransaction();                   // ✅ lấy transaction

        try {
            trans.begin();
            em.persist(order);
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) {
                trans.rollback();
            }
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    public static boolean hasUserPurchasedProduct(long userId, long productId) {
        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        try {
            String jpql = "SELECT COUNT(o) FROM Order o "
                    + "JOIN o.orderItems oi "
                    + "WHERE o.user.id = :userId "
                    + "AND oi.product.id = :productId "
                    + "AND o.status = 3";

            TypedQuery<Long> query = em.createQuery(jpql, Long.class);
            query.setParameter("userId", userId);
            query.setParameter("productId", productId);

            Long count = query.getSingleResult();
            return count != null && count > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }

    public static List<Order> selectAll() {
        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        try {
            TypedQuery<Order> query = em.createQuery(
                    "SELECT DISTINCT o FROM Order o "
                    + "LEFT JOIN FETCH o.user "
                    + "LEFT JOIN FETCH o.orderItems i "
                    + "LEFT JOIN FETCH i.product",
                    Order.class
            );
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public static Order select(int id) {
        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        try {
            TypedQuery<Order> query = em.createQuery(
                    "SELECT DISTINCT o FROM Order o "
                    + "LEFT JOIN FETCH o.user "
                    + "LEFT JOIN FETCH o.orderItems i "
                    + "LEFT JOIN FETCH i.product "
                    + "WHERE o.id = :id",
                    Order.class
            );
            query.setParameter("id", id);
            return query.getSingleResult();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            em.close();
        }
    }

    public static void update(Order order) {
        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.merge(order);
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) {
                tx.rollback();
            }
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    public static void delete(int id) {
        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            Order order = em.find(Order.class, id);
            if (order != null) {
                tx.begin();
                em.remove(order);
                tx.commit();
            }
        } catch (Exception e) {
            if (tx.isActive()) {
                tx.rollback();
            }
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    public static Order selectWithRelations(int id) {
        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        try {
            TypedQuery<Order> query = em.createQuery(
                    "SELECT DISTINCT o FROM Order o "
                    + "LEFT JOIN FETCH o.user "
                    + "LEFT JOIN FETCH o.orderItems i "
                    + "LEFT JOIN FETCH i.product "
                    + "WHERE o.id = :id", Order.class
            );
            query.setParameter("id", id);
            return query.getSingleResult();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            em.close();
        }
    }
}
