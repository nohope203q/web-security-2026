package data;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DBUtil {

    private static final Logger logger = Logger.getLogger(DBUtil.class.getName());
    private static EntityManagerFactory emf = null;

    static {
        try {
            logger.log(Level.INFO, "Creating EntityManagerFactory for 'pcshopPU'...");
            emf = Persistence.createEntityManagerFactory("pcshopPU");
        } catch (Exception ex) {
            logger.log(Level.SEVERE, "Cannot create 'pcshopPU'. Application cannot access DB. Reason: {0}", ex.toString());
            throw new ExceptionInInitializerError(ex);
        }
    }

    public static EntityManagerFactory getEmFactory() {
        return emf;
    }

    public static void closeFactory() {
        if (emf != null && emf.isOpen()) {
            emf.close();
            logger.log(Level.INFO, "EntityManagerFactory closed.");
        }
    }
}