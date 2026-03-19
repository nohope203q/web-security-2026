package data;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import model.Announcement; // Đảm bảo import đúng model Announcement
import java.util.Date;
import java.util.List;
import model.Announcement;

public class AnnouncementDAO {

    public List<Announcement> getActiveAnnouncements() {
        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        try {

            String jpql = "SELECT a FROM Announcement a "
                    + "WHERE a.status = 'active' "
                    + "ORDER BY a.startDate DESC";

            TypedQuery<Announcement> query = em.createQuery(jpql, Announcement.class);

            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public List<Announcement> getAllAnnouncements() {
        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        try {
            return em.createQuery("SELECT a FROM Announcement a", Announcement.class)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    public static void insert(Announcement a) {
        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.persist(a);
            trans.commit();
        } catch (Exception e) {
            System.out.println(e);
            trans.rollback();
        } finally {
            em.close();
        }
    }

    public static List<Announcement> selectAll() {
        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        try {
            return em.createQuery(
                    "SELECT a FROM Announcement a ORDER BY a.startDate DESC",
                    Announcement.class
            ).getResultList();
        } finally {
            em.close();
        }
    }

    public static Announcement select(int id) {
        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        try {
            return em.find(Announcement.class, id);
        } finally {
            em.close();
        }
    }

    public static void update(Announcement a) {
        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.merge(a);
            trans.commit();
        } catch (Exception e) {
            System.out.println(e);
            trans.rollback();
        } finally {
            em.close();
        }
    }

    public static void delete(int id) {
        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            Announcement a = em.find(Announcement.class, id);
            if (a != null) {
                em.remove(a);
            }
            trans.commit();
        } catch (Exception e) {
            System.out.println(e);
            trans.rollback();
        } finally {
            em.close();
        }
    }
}
