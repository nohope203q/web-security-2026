package data;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import model.Category;
import java.util.List;
import model.Product;

public class CategoryDAO {

    public static List<Category> getAllCategory() {
        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        try {
            return em.createQuery("SELECT c FROM Category c", Category.class).getResultList();
        } finally {
            em.close();
        }
    }

    public static List<Category> selectAll() {
        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        try {
            TypedQuery<Category> query = em.createQuery(
                    "SELECT c FROM Category c ORDER BY c.id",
                    Category.class
            );
            return query.getResultList();
        } finally {
            em.close();
        }
    }

//    public static List<Category> getAllCategory() {
//        EntityManager em = DBUtil.getEmFactory().createEntityManager();
//        try {
//            return em.createQuery("SELECT c FROM Category c", Category.class).getResultList();
//        } finally {
//            em.close();
//        }
//    }
    // --- Lấy danh mục theo ID ---
    public static Category select(int id) {
        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        try {
            return em.find(Category.class, id);
        } finally {
            em.close();
        }
    }

    // --- Lấy sản phẩm theo category ID ---
    public static List<Product> getProductsByCategory(int categoryId) {
        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        try {
            TypedQuery<Product> query = em.createQuery(
                    "SELECT p FROM Product p WHERE p.category.id = :categoryId",
                    Product.class
            );
            query.setParameter("categoryId", categoryId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    // --- Thêm danh mục ---
    public static void insert(Category c) {
        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.persist(c);
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

    // --- Cập nhật danh mục ---
    public static void update(Category c) {
        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.merge(c);
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

    // --- Xóa danh mục theo ID ---
    public static void delete(int id) {
        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            Category c = em.find(Category.class, id);
            if (c != null) {
                tx.begin();
                em.remove(c);
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
}
