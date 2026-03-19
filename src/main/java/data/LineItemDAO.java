package data;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.NoResultException;
import jakarta.persistence.Query;
import jakarta.persistence.TypedQuery;
import model.LineItem;
import model.User;
import java.util.List;
import java.util.ArrayList;

public class LineItemDAO {

    public static List<LineItem> getCartItemsByUser(User user) {
        EntityManager em = DBUtil.getEmFactory().createEntityManager();

        String qString = "SELECT li FROM LineItem li JOIN FETCH li.product p WHERE li.user.id = :userId";

        TypedQuery<LineItem> q = em.createQuery(qString, LineItem.class);
        q.setParameter("userId", user.getId());
        try {
            return q.getResultList();
        } catch (NoResultException e) {
            return new ArrayList<>();
        } finally {
            em.close();
        }
    }

    public static void saveCart(List<LineItem> cartItems, User user) {

        clearCartForUser(user);

        if (cartItems == null || cartItems.isEmpty()) {
            return;
        }

        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        EntityTransaction trans = em.getTransaction();
        trans.begin();
        try {
            for (LineItem item : cartItems) {

                item.setId(null);

                item.setUser(user);
                em.persist(item);
            }
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

    public static void clearCartForUser(User user) {
        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        EntityTransaction trans = em.getTransaction();
        trans.begin();
        try {
            String qString = "DELETE FROM LineItem li WHERE li.user.id = :userId";
            Query q = em.createQuery(qString);
            q.setParameter("userId", user.getId());
            q.executeUpdate();
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
}
