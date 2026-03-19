package data;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;

public class TestConnectDB {

    public static void main(String[] args) {
        try {
            EntityManagerFactory emf = DBUtil.getEmFactory();
            EntityManager em = emf.createEntityManager();
            System.out.println("✅ Kết nối CSDL thành công!");
            em.close();
            emf.close();
        } catch (Exception e) {
            System.out.println("❌ Kết nối thất bại!");
            e.printStackTrace();
        }
    }
}
