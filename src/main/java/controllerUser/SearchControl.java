package controllerUser;

import data.ProductDAO;
import model.Category;
import model.Product;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import data.CategoryDAO;

@WebServlet(name = "SearchControl", urlPatterns = {"/client/search"})
public class SearchControl extends HttpServlet {

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

        // Lấy tham số từ request
        String searchKeyword = request.getParameter("txt");
        String categoryIdStr = request.getParameter("category");
        String brand = request.getParameter("brand");
        String minPriceStr = request.getParameter("minPrice");
        String maxPriceStr = request.getParameter("maxPrice");

        // Parse các tham số
        Integer categoryId = null;
        Double minPrice = null;
        Double maxPrice = null;
        try {
            if (categoryIdStr != null && !categoryIdStr.trim().isEmpty()) {
                categoryId = Integer.parseInt(categoryIdStr);
            }
            if (minPriceStr != null && !minPriceStr.trim().isEmpty()) {
                minPrice = Double.parseDouble(minPriceStr);
            }
            if (maxPriceStr != null && !maxPriceStr.trim().isEmpty()) {
                maxPrice = Double.parseDouble(maxPriceStr);
            }
        } catch (NumberFormatException e) {
            System.out.println("Parse error: " + e.getMessage());
        }

        // Khởi tạo DAO
        ProductDAO productDAO = new ProductDAO();
        CategoryDAO categoryDAO = new CategoryDAO();

        // LOGIC QUAN TRỌNG: Xác định xem đang ở mode nào
        boolean hasSearchKeyword = searchKeyword != null && !searchKeyword.trim().isEmpty();
        boolean hasFilter = categoryId != null
                || (brand != null && !brand.trim().isEmpty())
                || minPrice != null
                || maxPrice != null;

        // QUY TẮC MỚI:
        // - Nếu có filter parameters (category, brand, price) => CHỈ LỌC, KHÔNG TÌM KIẾM
        // - Nếu chỉ có từ khóa => TÌM KIẾM
        String keywordToUse = null;
        if (hasFilter) {
            // Đang ở chế độ lọc => KHÔNG dùng từ khóa tìm kiếm
            keywordToUse = null;
        } else if (hasSearchKeyword) {
            // Đang ở chế độ tìm kiếm => dùng từ khóa
            keywordToUse = searchKeyword;
        }

        // Lấy danh sách sản phẩm
        List<Product> filteredProducts = productDAO.searchAndFilterProducts(
                keywordToUse, categoryId, brand, minPrice, maxPrice
        );

        // PHÂN TRANG
        String pageStr = request.getParameter("page");
        int currentPage = 1;
        if (pageStr != null && !pageStr.isEmpty()) {
            try {
                currentPage = Integer.parseInt(pageStr);
            } catch (NumberFormatException e) {
                currentPage = 1;
            }
        }

        int productsPerPage = 6;
        int totalProducts = filteredProducts.size();
        int totalPages = (int) Math.ceil((double) totalProducts / productsPerPage);

        if (currentPage > totalPages && totalPages > 0) {
            currentPage = totalPages;
        } else if (currentPage < 1) {
            currentPage = 1;
        }

        int startIndex = (currentPage - 1) * productsPerPage;
        int endIndex = Math.min(startIndex + productsPerPage, totalProducts);

        List<Product> paginatedProducts = filteredProducts.subList(startIndex, endIndex);

        // Lấy các dữ liệu khác cho sidebar filter
        List<Category> listCC = categoryDAO.getAllCategory();
        List<String> brands = productDAO.getAllBrands();
        Map<Integer, Long> productCountByCategory = productDAO.getProductCountByCategory();

        // Set dữ liệu lên request
        request.setAttribute("listP", paginatedProducts);
        request.setAttribute("listCC", listCC);
        request.setAttribute("brands", brands);
        request.setAttribute("searchKeyword", searchKeyword);
        request.setAttribute("productCountByCategory", productCountByCategory);
        request.setAttribute("hasSearchKeyword", hasSearchKeyword);
        request.setAttribute("hasFilter", hasFilter);

        // Gửi thông tin phân trang sang JSP
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalProducts", totalProducts);

        // Forward tới trang search
        request.getRequestDispatcher("/client/searchPage.jsp").forward(request, response);
    }
}
