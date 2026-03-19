package controllerUser;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Product;
import data.ProductDAO;

import java.io.IOException;
import java.util.*;
import java.util.stream.Collectors;

@WebServlet("/compare")
public class CompareServlet extends HttpServlet {

    // Tối đa 2 sản phẩm để so sánh
    private static final int MAX_COMPARE = 2;
    private final ProductDAO productDAO = new ProductDAO();

    @SuppressWarnings("unchecked")
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = Optional.ofNullable(req.getParameter("action")).orElse("add");
        String pidStr = req.getParameter("productId");

        HttpSession session = req.getSession();
        // Lưu set id trong session để không trùng và giữ thứ tự chọn
        LinkedHashSet<Integer> compareSet
                = (LinkedHashSet<Integer>) Optional.ofNullable(session.getAttribute("compareList"))
                        .orElse(new LinkedHashSet<>());

        switch (action) {
            case "add": {
                if (pidStr != null) {
                    int id = Integer.parseInt(pidStr);
                    if (!compareSet.contains(id)) {
                        // Nếu đủ 2 phần tử thì loại phần tử đầu (cũ nhất)
                        if (compareSet.size() >= MAX_COMPARE) {
                            Integer first = compareSet.iterator().next();
                            compareSet.remove(first);
                        }
                        compareSet.add(id);
                    }
                }
                session.setAttribute("compareList", compareSet);
                // quay lại trang trước
                resp.sendRedirect(req.getHeader("Referer") != null ? req.getHeader("Referer") : req.getContextPath() + "/");
                return;
            }
            case "remove": {
                if (pidStr != null) {
                    int id = Integer.parseInt(pidStr);
                    compareSet.remove(id);
                }
                session.setAttribute("compareList", compareSet);
                resp.sendRedirect(req.getHeader("Referer") != null ? req.getHeader("Referer") : req.getContextPath() + "/");
                return;
            }
            case "clear": {
                compareSet.clear();
                session.setAttribute("compareList", compareSet);
                resp.sendRedirect(req.getHeader("Referer") != null ? req.getHeader("Referer") : req.getContextPath() + "/");
                return;
            }
            case "view": {
                // Lấy danh sách Product theo các ID hiện có
                List<Integer> ids = new ArrayList<>(compareSet);
                List<Product> products = ids.isEmpty()
                        ? Collections.emptyList()
                        : productDAO.getByIds(ids);
                req.setAttribute("compareProducts", products);
                req.getRequestDispatcher("/client/compare-result.jsp").forward(req, resp);
                return;
            }
            default: {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Unsupported action");
            }
        }
    }
}
