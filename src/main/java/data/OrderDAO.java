package data;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import java.util.List;
import model.Order;

public class OrderDAO {

    /**
     * Thêm một đối tượng Order mới vào cơ sở dữ liệu. Bao gồm cả các OrderItem
     * liên quan nhờ CascadeType.ALL.
     *
     * @param order Đối tượng Order cần lưu.
     */
    public static void insert(Order order) {
        EntityManager em = DBUtil.getEmFactory().createEntityManager();  // ✅ tạo EntityManager
        EntityTransaction trans = em.getTransaction();                   // ✅ lấy transaction

        try {
            trans.begin();                    // Bắt đầu giao dịch
            em.persist(order);                // Lưu đối tượng Order (và các OrderItem con)
            trans.commit();                   // Hoàn tất giao dịch
        } catch (Exception e) {
            if (trans.isActive()) {
                trans.rollback();              // Nếu có lỗi, rollback
            }
            e.printStackTrace();
        } finally {
            em.close();                        // Đóng EntityManager sau khi xong
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

    // --- Lấy 1 đơn hàng theo ID (kèm user & chi tiết sản phẩm) ---
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

    // --- Thêm đơn hàng ---
//    public static void insert(Order order) {
//        EntityManager em = DBUtil.getEmFactory().createEntityManager();
//        EntityTransaction tx = em.getTransaction();
//        try {
//            tx.begin();
//            em.persist(order);
//            tx.commit();
//        } catch (Exception e) {
//            if (tx.isActive()) {
//                tx.rollback();
//            }
//            e.printStackTrace();
//        } finally {
//            em.close();
//        }
//    }
    // --- Cập nhật đơn hàng ---
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

    // --- Xóa đơn hàng ---
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
