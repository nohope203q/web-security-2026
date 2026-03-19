package data;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import model.Review;
import model.Product;
import model.User;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

public class ReviewDAO {

    /**
     * Get all reviews for a specific product
     */
    public List<Review> getReviewsByProductId(Long productId) {
        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        try {
            TypedQuery<Review> query = em.createQuery(
                    "SELECT r FROM Review r "
                    + "LEFT JOIN FETCH r.user "
                    + "WHERE r.product.id = :productId "
                    + "ORDER BY r.createdAt DESC",
                    Review.class
            );
            query.setParameter("productId", productId);
            return query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        } finally {
            em.close();
        }
    }

    /**
     * Get reviews by product and rating filter
     */
    public List<Review> getReviewsByProductAndRating(Long productId, Integer rating) {
        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        try {
            TypedQuery<Review> query = em.createQuery(
                    "SELECT r FROM review r "
                    + "LEFT JOIN FETCH r.user "
                    + "WHERE r.product.id = :productId AND r.rating = :rating "
                    + "ORDER BY r.createdAt DESC",
                    Review.class
            );
            query.setParameter("productId", productId);
            query.setParameter("rating", rating);
            return query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        } finally {
            em.close();
        }
    }

    /**
     * Insert a new review
     */
    public boolean insertReview(Review review) {
        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        try {
            em.getTransaction().begin();
            review.setCreatedAt(new Date());
            em.persist(review);
            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }

    /**
     * Get average rating for a product
     */
    public double getAverageRating(Long productId) {
        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        try {
            TypedQuery<Double> query = em.createQuery(
                    "SELECT AVG(r.rating) FROM Review r WHERE r.product.id = :productId",
                    Double.class
            );
            query.setParameter("productId", productId);
            Double avg = query.getSingleResult();
            return avg != null ? avg : 0.0;
        } catch (Exception e) {
            e.printStackTrace();
            return 0.0;
        } finally {
            em.close();
        }
    }

    /**
     * Get total review count for a product
     */
    public long getTotalReviewCount(Long productId) {
        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        try {
            TypedQuery<Long> query = em.createQuery(
                    "SELECT COUNT(r) FROM Review r WHERE r.product.id = :productId",
                    Long.class
            );
            query.setParameter("productId", productId);
            return query.getSingleResult();
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        } finally {
            em.close();
        }
    }

    /**
     * Get rating distribution (count for each star rating)
     */
    public Map<Integer, Long> getRatingDistribution(Long productId) {
        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        Map<Integer, Long> distribution = new HashMap<>();

        // Initialize all ratings to 0
        for (int i = 1; i <= 5; i++) {
            distribution.put(i, 0L);
        }

        try {
            TypedQuery<Object[]> query = em.createQuery(
                    "SELECT r.rating, COUNT(r) FROM Review r "
                    + "WHERE r.product.id = :productId "
                    + "GROUP BY r.rating",
                    Object[].class
            );
            query.setParameter("productId", productId);

            List<Object[]> results = query.getResultList();
            for (Object[] result : results) {
                Integer rating = (Integer) result[0];
                Long count = (Long) result[1];
                distribution.put(rating, count);
            }

            return distribution;
        } catch (Exception e) {
            e.printStackTrace();
            return distribution;
        } finally {
            em.close();
        }
    }

    /**
     * Check if user has already reviewed a product
     */
    public boolean hasUserReviewed(Long productId, Long userId) {
        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        try {
            TypedQuery<Long> query = em.createQuery(
                    "SELECT COUNT(r) FROM Review r "
                    + "WHERE r.product.id = :productId AND r.user.id = :userId",
                    Long.class
            );
            query.setParameter("productId", productId);
            query.setParameter("userId", userId);
            return query.getSingleResult() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }

    /**
     * Check if user has purchased the product (for verified badge)
     */
    public boolean hasUserPurchased(Long productId, Long userId) {
        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        try {
            TypedQuery<Long> query = em.createQuery(
                    "SELECT COUNT(oi) FROM OrderItem oi "
                    + "WHERE oi.product.id = :productId "
                    + "AND oi.order.user.id = :userId "
                    + "AND oi.order.status = '3'",
                    Long.class
            );
            query.setParameter("productId", productId);
            query.setParameter("userId", userId);
            return query.getSingleResult() > 0;
        } catch (Exception e) {
            // If OrderItem entity doesn't exist or query fails, return false
            return false;
        } finally {
            em.close();
        }
    }

    private static final List<String> PROFANE_WORDS = Arrays.asList(
            "đụ", "đéo", "đm", "cmm", "lồn", "cặc", "sv", "ml", "địt"
    );

    // --- NEW: Hàm kiểm tra một bình luận có chứa từ khiếm nhã không ---
    private static boolean containsProfanity(String comment) {
        if (comment == null || comment.trim().isEmpty()) {
            return false;
        }
        String lowerCaseComment = comment.toLowerCase();
        for (String word : PROFANE_WORDS) {
            if (lowerCaseComment.contains(word)) {
                return true;
            }
        }
        return false;
    }

    // --- NEW: Lấy các bình luận "sạch" (không có từ khiếm nhã) ---
    public static List<Review> selectCleanReviews() {
        return selectAll().stream()
                .filter(r -> !containsProfanity(r.getComment()))
                .collect(Collectors.toList());
    }

    // --- NEW: Lấy các bình luận "bẩn" (có từ khiếm nhã) ---
    public static List<Review> selectProfaneReviews() {
        return selectAll().stream()
                .filter(r -> containsProfanity(r.getComment()))
                .collect(Collectors.toList());
    }

    // --- NEW: Lọc bình luận "sạch" theo sản phẩm ---
    public static List<Review> selectCleanReviewsByProduct(int productId) {
        return selectByProduct(productId).stream()
                .filter(r -> !containsProfanity(r.getComment()))
                .collect(Collectors.toList());
    }

    // --- NEW: Lọc bình luận "bẩn" theo sản phẩm ---
    public static List<Review> selectProfaneReviewsByProduct(int productId) {
        return selectByProduct(productId).stream()
                .filter(r -> containsProfanity(r.getComment()))
                .collect(Collectors.toList());
    }

    // --- CÁC HÀM CŨ ĐỂ LẤY DỮ LIỆU GỐC ---
    public static List<Review> selectAll() {
        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        String qString = "SELECT r FROM Review r JOIN FETCH r.user JOIN FETCH r.product ORDER BY r.createdAt DESC";
        TypedQuery<Review> q = em.createQuery(qString, Review.class);
        try {
            return q.getResultList();
        } finally {
            em.close();
        }
    }

    public static List<Review> selectByProduct(int productId) {
        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        String qString = "SELECT r FROM Review r JOIN FETCH r.user JOIN FETCH r.product WHERE r.product.id = :productId ORDER BY r.createdAt DESC";
        TypedQuery<Review> q = em.createQuery(qString, Review.class);
        q.setParameter("productId", productId);
        try {
            return q.getResultList();
        } finally {
            em.close();
        }
    }

    public static void delete(int reviewId) {
        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        EntityTransaction trans = em.getTransaction();
        trans.begin();
        try {
            Review review = em.find(Review.class, reviewId);
            if (review != null) {
                em.remove(review);
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
