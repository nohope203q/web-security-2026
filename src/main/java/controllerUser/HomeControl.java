package controllerUser;

import data.ProductDAO;
import model.Category;
import model.Product;
import model.Announcement;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import data.AnnouncementDAO;
import data.CategoryDAO;

@WebServlet(name = "HomeControl", urlPatterns = {"/home"})
public class HomeControl extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        // b1: Lấy dữ liệu từ DAO (giữ nguyên)
        ProductDAO dao = new ProductDAO();
        CategoryDAO daoC = new CategoryDAO();
        AnnouncementDAO daoAno = new AnnouncementDAO();

        List<Category> listC = daoC.getAllCategory();
        List<Announcement> listAno = daoAno.getActiveAnnouncements();
        Product last = dao.getLast();

        // Lấy toàn bộ danh sách sản phẩm để phân trang
        List<Product> allProducts = dao.getAllProduct();
        String pageStr = request.getParameter("page");
        int currentPage = 1;
        if (pageStr != null && !pageStr.isEmpty()) {
            try {
                currentPage = Integer.parseInt(pageStr);
            } catch (NumberFormatException e) {
                currentPage = 1;
            }
        }

        // 2. Đặt số sản phẩm trên mỗi trang
        int productsPerPage = 8;

        // 3. Tính tổng số trang
        int totalProducts = allProducts.size();
        int totalPages = (int) Math.ceil((double) totalProducts / productsPerPage);

        // Đảm bảo trang hiện tại hợp lệ
        if (currentPage > totalPages && totalPages > 0) {
            currentPage = totalPages;
        } else if (currentPage < 1) {
            currentPage = 1;
        }

        int startIndex = (currentPage - 1) * productsPerPage;
        int endIndex = Math.min(startIndex + productsPerPage, totalProducts);

        List<Product> paginatedProducts = allProducts.subList(startIndex, endIndex);

        request.setAttribute("listP", paginatedProducts);
        request.setAttribute("listCC", listC);
        request.setAttribute("listAno", listAno);
        request.setAttribute("p", last);

        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", currentPage);

        request.getRequestDispatcher("/client/homepage.jsp").forward(request, response);
    }
}
