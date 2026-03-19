package data;

import jakarta.persistence.EntityManager;
import jakarta.persistence.*;
import java.util.List;
import model.User;

public class UserDB {

    public static List<User> selectAll() {
        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        try {
            TypedQuery<User> query = em.createQuery("SELECT u FROM User u", User.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public static User select(int id) {
        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        try {
            User user = em.find(User.class, id);
            return user;
        } finally {
            em.close();
        }
    }

    public static List<User> searchUsers(String searchTerm) {
        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        List<User> users;

        try {
            TypedQuery<User> query;

            if (searchTerm != null && !searchTerm.trim().isEmpty()) {
                String jpql = "SELECT u FROM User u WHERE "
                        + "LOWER(u.name) LIKE LOWER(:term) OR "
                        + "LOWER(u.email) LIKE LOWER(:term)";
                query = em.createQuery(jpql, User.class);
                query.setParameter("term", "%" + searchTerm + "%");
                users = query.getResultList();
            } else {
                users = selectAll();
            }
        } finally {
            em.close();
        }

        return users;
    }

    public static User selectUser(String email) {
        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        String qString = "SELECT u FROM User u "
                + "WHERE u.email = :email";
        TypedQuery<User> q = em.createQuery(qString, User.class);
        q.setParameter("email", email);
        try {
            User user = q.getSingleResult();
            return user;
        } catch (NoResultException e) {
            return null;
        } finally {
            em.close();
        }
    }

    public static boolean emailExists(String email) {
        User u = selectUser(email);
        if (u != null) {
            return true;
        }
        return false;
    }

    public static void insert(User user) {
        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        EntityTransaction trans = em.getTransaction();
        trans.begin();
        try {
            em.persist(user);
            trans.commit();
        } catch (Exception e) {
            System.out.println(e);
            trans.rollback();
        } finally {
            em.close();
        }
    }

    public static void update(User user) {
        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        EntityTransaction trans = em.getTransaction();
        trans.begin();
        try {
            em.merge(user);
            trans.commit();
        } catch (Exception e) {
            System.out.println(e);
            trans.rollback();
        } finally {
            em.close();
        }

    }

    public static void delete(User user) {
        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        EntityTransaction trans = em.getTransaction();
        trans.begin();
        try {
            em.remove(em.merge(user));
            trans.commit();
        } catch (Exception e) {
            System.out.println(e);
            trans.rollback();
        } finally {
            em.close();
        }
    }

    public static boolean deleteUserCascade(int userId) {
        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();

            // Khóa/đảm bảo bản ghi tồn tại
            User user = em.find(User.class, userId, LockModeType.PESSIMISTIC_WRITE);
            if (user == null) {
                trans.rollback();
                return false;
            }

            // 1) XÓA CÁC BẢN GHI CON LIÊN QUAN TỚI USER
            // --- Ví dụ: Review của user
            em.createQuery("DELETE FROM Review r WHERE r.user.id = :uid")
                    .setParameter("uid", userId)
                    .executeUpdate();

            // --- Ví dụ: Invoice liên quan tới các đơn hàng của user
            em.createQuery("DELETE FROM Invoice i WHERE i.order.user.id = :uid")
                    .setParameter("uid", userId)
                    .executeUpdate();

            // --- Ví dụ: Order của user
            em.createQuery("DELETE FROM Order o WHERE o.user.id = :uid")
                    .setParameter("uid", userId)
                    .executeUpdate();

            // Thêm các bảng con khác nếu có:
            // em.createQuery("DELETE FROM CartItem c WHERE c.user.id = :uid")...
            // em.createQuery("DELETE FROM Address a WHERE a.user.id = :uid")...
            // 2) XÓA USER
            em.remove(user);

            trans.commit();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            if (trans.isActive()) {
                trans.rollback();
            }
            return false;
        } finally {
            em.close();
        }
    }

}
