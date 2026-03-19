package data;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import model.Product;
import java.util.List;
import java.util.Map;
import model.Category;

public class ProductDAO {

    public List<Product> getAllProduct() {
        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        try {
            return em.createQuery("SELECT p FROM Product p", Product.class).getResultList();
        } finally {
            em.close();
        }
    }

    public Product getLast() {
        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        try {
            return em.createQuery("SELECT p FROM Product p ORDER BY p.id DESC", Product.class)
                    .setMaxResults(1)
                    .getSingleResult();
        } finally {
            em.close();
        }
    }

    public void insert(Product product) {
        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(product);
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    public static Product getProductById(long productId) {
        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        try {
            return em.find(Product.class, productId);
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public Product getProductByIdWithCategory(long productId) {
        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        try {
            TypedQuery<Product> query = em.createQuery(
                    "SELECT p FROM Product p LEFT JOIN FETCH p.category WHERE p.id = :productId",
                    Product.class
            );
            query.setParameter("productId", productId);
            List<Product> results = query.getResultList();
            return results.isEmpty() ? null : results.get(0);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            em.close();
        }
    }

    public List<Product> getRelatedByCategory(Long categoryId, Long excludeProductId, int limit) {
        if (categoryId == null) {
            return new ArrayList<>();
        }
        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        try {
            TypedQuery<Product> query = em.createQuery(
                    "SELECT p FROM Product p WHERE p.category.id = :categoryId AND p.id != :excludeId ORDER BY p.sold DESC",
                    Product.class
            );
            query.setParameter("categoryId", categoryId);
            query.setParameter("excludeId", excludeProductId == null ? -1L : excludeProductId);
            query.setMaxResults(Math.max(1, limit));
            return query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        } finally {
            em.close();
        }
    }

    public List<Category> getAllCategory() {
        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        try {
            return em.createQuery("SELECT c FROM Category c", Category.class)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    public List<String> getAllBrands() {
        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        try {
            List<String> brands = em.createQuery("SELECT DISTINCT p.brand FROM Product p WHERE p.brand IS NOT NULL ORDER BY p.brand", String.class)
                    .getResultList();
            return brands != null ? brands : new ArrayList<>();
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        } finally {
            em.close();
        }
    }

    public List<Product> searchAndFilterProducts(String keyword, Integer categoryId,
            String brand, Double minPrice, Double maxPrice) {
        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        try {
            StringBuilder sql = new StringBuilder("SELECT p FROM Product p WHERE 1=1");
            Map<String, Object> params = new HashMap<>();

            if (keyword != null && !keyword.trim().isEmpty()) {
                String[] searchTerms = keyword.trim().toLowerCase().split("\\s+");
                sql.append(" AND (");

                List<String> orConditions = new ArrayList<>();
                for (int i = 0; i < searchTerms.length; i++) {
                    String term = searchTerms[i];
                    if (!term.isEmpty()) {
                        orConditions.add("(LOWER(p.name) LIKE LOWER(:term" + i + ") OR "
                                + "LOWER(p.brand) LIKE LOWER(:term" + i + ") OR "
                                + "LOWER(p.description) LIKE LOWER(:term" + i + "))");
                        params.put("term" + i, "%" + term + "%");
                    }
                }

                sql.append(String.join(" OR ", orConditions));
                sql.append(")");
            }

            if (categoryId != null && categoryId > 0) {
                sql.append(" AND p.category.id = :categoryId");
                params.put("categoryId", categoryId);
            }

            if (brand != null && !brand.trim().isEmpty()) {
                sql.append(" AND LOWER(p.brand) = LOWER(:brand)");
                params.put("brand", brand.trim());
            }

            if (minPrice != null && minPrice > 0) {
                sql.append(" AND p.price >= :minPrice");
                params.put("minPrice", minPrice);
            }

            if (maxPrice != null && maxPrice > 0) {
                sql.append(" AND p.price <= :maxPrice");
                params.put("maxPrice", maxPrice);
            }

            sql.append(" ORDER BY p.name");

            TypedQuery<Product> query = em.createQuery(sql.toString(), Product.class);

            for (Map.Entry<String, Object> entry : params.entrySet()) {
                query.setParameter(entry.getKey(), entry.getValue());
            }

            List<Product> results = query.getResultList();

            if (keyword != null && !keyword.trim().isEmpty() && !results.isEmpty()) {
                results = sortBySearchPriority(results, keyword.toLowerCase());
            }

            return results != null ? results : new ArrayList<>();

        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        } finally {
            em.close();
        }
    }

    private List<Product> sortBySearchPriority(List<Product> products, String keyword) {
        String[] searchTerms = keyword.split("\\s+");

        List<Product> sortedProducts = new ArrayList<>(products);

        sortedProducts.sort((p1, p2) -> {
            int score1 = calculateSearchPriority(p1, searchTerms);
            int score2 = calculateSearchPriority(p2, searchTerms);
            return Integer.compare(score1, score2); // Số nhỏ hơn = ưu tiên cao hơn
        });

        return sortedProducts;
    }

    private int calculateSearchPriority(Product product, String[] searchTerms) {
        String brandLower = product.getBrand() != null ? product.getBrand().toLowerCase() : "";
        String categoryLower = product.getCategory() != null ? product.getCategory().getName().toLowerCase() : "";
        String nameLower = product.getName() != null ? product.getName().toLowerCase() : "";

        for (String term : searchTerms) {
            if (brandLower.equals(term)) {
                return 1;
            }
        }

        for (String term : searchTerms) {
            if (brandLower.contains(term)) {
                return 2;
            }
        }

        for (String term : searchTerms) {
            if (categoryLower.contains(term)) {
                return 3;
            }
        }

        for (String term : searchTerms) {
            if (nameLower.contains(term)) {
                return 4;
            }
        }

        return 5;
    }

    public Map<Integer, Long> getProductCountByCategory() {
        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        try {
            return new HashMap<>();
        } catch (Exception e) {
            e.printStackTrace();
            return new HashMap<>();
        } finally {
            em.close();
        }
    }

    public List<Product> getByIds(List<Integer> ids) {
        if (ids == null || ids.isEmpty()) {
            return Collections.emptyList();
        }
        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        try {
            return em.createQuery("SELECT p FROM Product p WHERE p.id IN :ids", Product.class)
                    .setParameter("ids", ids)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    public List<Product> searchProducts(String keyword) {
        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        try {
            String jpql = "SELECT p FROM Product p "
                    + "WHERE p.name LIKE :keyword "
                    + "OR p.description LIKE :keyword "
                    + "OR p.brand LIKE :keyword";

            TypedQuery<Product> query = em.createQuery(jpql, Product.class);
            query.setParameter("keyword", "%" + keyword + "%");

            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public static List<Product> selectAll() {
        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        try {
            TypedQuery<Product> query = em.createQuery(
                    "SELECT DISTINCT p FROM Product p LEFT JOIN FETCH p.category",
                    Product.class
            );
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public static Product select(int id) {
        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        try {
            return em.find(Product.class, id);
        } finally {
            em.close();
        }
    }

    public static void update(Product p) {
        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.merge(p);
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
            Product p = em.find(Product.class, id);
            if (p != null) {
                tx.begin();
                em.remove(p);
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
