<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý sản phẩm</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/admin/styles/main.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        body { font-family: 'Segoe UI', sans-serif; background-color: #f0f2f5; margin: 0; display: flex; }
        .main { flex-grow: 1; padding: 2.5rem; }
        h1 { color: #1a2a4b; border-bottom: 2px solid #e0e0e0; padding-bottom: 0.5rem; margin-bottom: 2rem; }
        .action-bar { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; background: #fff; padding: 15px; border-radius: 8px; box-shadow: 0 2px 5px rgba(0,0,0,0.05); }
        .search-box { display: flex; align-items: center; gap: 8px; }
        .search-box input { padding: 8px 12px; border: 1px solid #ccc; border-radius: 6px; width: 250px; }
        table { width: 100%; border-collapse: collapse; background: #fff; border-radius: 8px; overflow: hidden; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        th, td { padding: 12px 15px; text-align: left; border-bottom: 1px solid #eee; }
        th { background-color: #f8f9fa; color: #555; text-transform: uppercase; font-size: 0.85rem; }
        tr:hover { background-color: #f9f9f9; }
        .btn { padding: 8px 16px; border-radius: 6px; text-decoration: none; color: #fff; font-size: 0.9rem; border: none; cursor: pointer; display: inline-flex; align-items: center; gap: 5px; }
        .btn-primary { background-color: #007bff; }
        .btn-danger { background-color: #dc3545; }
        .product-img { object-fit: cover; border-radius: 4px; border: 1px solid #ddd; }
    </style>
</head>
<body>
    <jsp:include page="includes/sidebar.jsp" />

    <div class="main">
        <h1>Quản lý sản phẩm</h1>

        <div class="action-bar">
            <a href="${pageContext.request.contextPath}/admin/product?action=edit" class="btn btn-primary">
                <i class="fa-solid fa-plus"></i> Thêm sản phẩm
            </a>

            <form action="${pageContext.request.contextPath}/admin/product" method="get" class="search-box">
                <input type="text" name="keyword" placeholder="Tìm tên, thương hiệu..." value="<c:out value='${param.keyword}'/>">
                <button type="submit" class="btn btn-primary">
                    <i class="fa-solid fa-magnifying-glass"></i> Tìm
                </button>
            </form>
        </div>

        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Ảnh</th>
                    <th>Tên sản phẩm</th>
                    <th>Thương hiệu</th>
                    <th>Danh mục</th>
                    <th>Giá</th>
                    <th>Kho</th>
                    <th>Đã bán</th>
                    <th>Hành động</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty products}">
                        <c:forEach var="p" items="${products}">
                            <tr>
                                <td>${p.id}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty p.image}">
                                            <img src="<c:out value='${p.image}'/>" width="50" height="50" class="product-img">
                                        </c:when>
                                        <c:otherwise>
                                            <i class="fa-solid fa-image text-muted" style="font-size: 40px; color: #ccc;"></i>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <strong><c:out value="${p.name}"/></strong>
                                    <br><small style="color: #888;">Màu: <c:out value="${p.color}"/></small>
                                </td>
                                <td><c:out value="${p.brand}"/></td>
                                <td><c:out value="${p.category.name}"/></td>
                                <td style="color: #d9534f; font-weight: bold;">
                                    <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="₫"/>
                                </td>
                                <td>${p.quantity}</td>
                                <td>${p.sold}</td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/admin/product?action=edit&id=${p.id}" class="btn btn-primary" style="padding: 5px 10px;">
                                        <i class="fa-solid fa-pen"></i>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/admin/product?action=delete&id=${p.id}&_csrf=${csrfToken}" 
                                       class="btn btn-danger" style="padding: 5px 10px;"
                                       onclick="return confirm('Xác nhận xóa sản phẩm: ${p.name}?')">
                                        <i class="fa-solid fa-trash"></i>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="9" style="text-align: center; padding: 50px; color: #888;">Không có sản phẩm nào phù hợp.</td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>
</body>
</html>