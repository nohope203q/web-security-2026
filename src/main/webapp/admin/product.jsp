<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Quản lý sản phẩm</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/admin/styles/main.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    </head>
    <body>
        <%@ include file="includes/sidebar.jsp" %>

        <!-- Main -->
        <div class="main">
            <h1>Quản lý sản phẩm</h1>

            <!-- Thanh công cụ -->
            <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:20px;">
                <!-- Nút thêm -->
                <a href="${pageContext.request.contextPath}/admin/product?action=edit" class="btn btn-primary">
                    <i class="fa-solid fa-plus"></i> Thêm sản phẩm
                </a>

                <!-- Form tìm kiếm -->
                <form action="${pageContext.request.contextPath}/admin/product" method="get" style="display:flex; align-items:center; gap:8px;">
                    <input type="text" name="keyword" placeholder="Tìm kiếm sản phẩm..." 
                           value="${param.keyword}" 
                           style="padding:8px 12px; border:1px solid #ccc; border-radius:6px; width:220px;">
                    <button type="submit" class="btn btn-primary">
                        <i class="fa-solid fa-magnifying-glass"></i> Tìm
                    </button>
                </form>
            </div>

            <!-- Bảng sản phẩm -->
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Tên</th>
                        <th>Thương hiệu</th>
                        <th>Danh mục</th>
                        <th>Giá (VNĐ)</th>
                        <th>Số lượng</th>
                        <th>Màu</th>
                        <th>Ảnh</th>
                        <th>Đã bán</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="p" items="${products}">
                        <tr>
                            <td>${p.id}</td>
                            <td>${p.name}</td>
                            <td>${p.brand}</td>
                            <td>${p.category.name}</td>
                            <td><fmt:formatNumber value="${p.price}" type="currency" currencySymbol="₫"/></td>
                            <td>${p.quantity}</td>
                            <td>${p.color}</td>
                            <td>
                                <c:if test="${not empty p.image}">
                                    <img src="${p.image}" width="60" height="60" style="object-fit:cover;border-radius:8px;">
                                </c:if>
                            </td>
                            <td>${p.sold}</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/admin/product?action=edit&id=${p.id}" class="btn btn-primary">
                                    <i class="fa-solid fa-pen"></i> Sửa
                                </a>
                                <a href="${pageContext.request.contextPath}/admin/product?action=delete&id=${p.id}" 
                                   class="btn btn-danger" 
                                   onclick="return confirm('Xóa sản phẩm này?')">
                                    <i class="fa-solid fa-trash"></i> Xóa
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </body>
</html>
