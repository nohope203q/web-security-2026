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

    /**
     * Lấy tất cả các LineItem (giỏ hàng) của một người dùng cụ thể từ database.
     *
     * @param user Người dùng cần lấy giỏ hàng.
     * @return Một danh sách LineItem. Trả về danh sách rỗng nếu không có.
     */
    public static List<LineItem> getCartItemsByUser(User user) {
        EntityManager em = DBUtil.getEmFactory().createEntityManager();

        // SỬA LẠI CÂU TRUY VẤN NÀY
        // JOIN FETCH li.product sẽ ép JPA tải luôn thông tin của Product
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

    /**
     * Lưu hoặc cập nhật một danh sách các LineItem vào database. Phương thức
     * này sẽ xóa các item cũ và chèn lại toàn bộ giỏ hàng để đảm bảo đồng bộ.
     *
     * @param cartItems Danh sách các LineItem cần lưu.
     * @param user Người dùng sở hữu giỏ hàng này.
     */
    public static void saveCart(List<LineItem> cartItems, User user) {
        // Đầu tiên, xóa giỏ hàng cũ của user
        clearCartForUser(user);

        // Sau đó, thêm lại các item mới
        if (cartItems == null || cartItems.isEmpty()) {
            return; // Không có gì để lưu
        }

        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        EntityTransaction trans = em.getTransaction();
        trans.begin();
        try {
            for (LineItem item : cartItems) {
                // *** DÒNG SỬA DUY NHẤT ***
                // Ép JPA coi đây là một đối tượng mới hoàn toàn bằng cách xóa ID cũ.
                item.setId(null);

                item.setUser(user); // Đảm bảo mỗi item đều được liên kết với đúng user
                em.persist(item);   // Dùng persist vì ta đã xóa các item cũ
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

    /**
     * Xóa tất cả các LineItem của một người dùng khỏi database. Thường được gọi
     * khi người dùng thanh toán thành công hoặc khi cần cập nhật giỏ hàng.
     *
     * @param user Người dùng cần xóa giỏ hàng.
     */
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
