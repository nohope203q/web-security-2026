<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý danh mục</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/admin/styles/main.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        body { font-family: 'Segoe UI', sans-serif; background-color: #f0f2f5; margin: 0; display: flex; }
        .main { flex-grow: 1; padding: 2.5rem; min-height: 100vh; }
        h1 { color: #1a2a4b; border-bottom: 2px solid #e0e0e0; padding-bottom: 0.5rem; margin-bottom: 2rem; font-size: 2rem; }
        h3 { color: #334e68; margin-bottom: 1.5rem; display: flex; align-items: center; gap: 10px; font-weight: 600; }
        .form-container { background-color: #fff; padding: 2rem; border-radius: 12px; box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08); margin-bottom: 2.5rem; }
        .form-container form { display: flex; align-items: center; gap: 15px; flex-wrap: wrap; }
        .form-container input[type="text"] { flex: 1; min-width: 250px; padding: 0.8rem 1rem; border: 1px solid #d1d9e6; border-radius: 8px; font-size: 1rem; }
        .btn { display: inline-flex; align-items: center; padding: 0.8rem 1.5rem; border: none; border-radius: 8px; font-size: 1rem; cursor: pointer; text-decoration: none; color: #fff; font-weight: 500; transition: 0.3s; }
        .btn i { margin-right: 8px; }
        .btn-primary { background-color: #007bff; }
        .btn-danger { background-color: #dc3545; }
        .btn-secondary { background-color: #6c757d; }
        .btn-info { background-color: #17a2b8; }
        .btn:hover { transform: translateY(-2px); box-shadow: 0 4px 8px rgba(0,0,0,0.1); }
        table { width: 100%; border-collapse: separate; border-spacing: 0; background-color: #fff; border-radius: 12px; box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08); overflow: hidden; }
        th, td { padding: 1.2rem 1.5rem; text-align: left; border-bottom: 1px solid #e0e0e0; }
        th { background-color: #f8f9fa; color: #555; text-transform: uppercase; font-size: 0.85rem; }
        .error-message { color: #dc3545; background-color: #f8d7da; padding: 1rem; border-radius: 6px; margin-bottom: 1.5rem; text-align: center; }
        .info-message { color: #0c5460; background-color: #d1ecf1; padding: 1rem; border-radius: 6px; margin-top: 1.5rem; }
    </style>
</head>
<body>
    <jsp:include page="includes/sidebar.jsp" />

    <div class="main">
        <h1>Quản lý danh mục</h1>

        <div class="form-container">
            <c:choose>
                <c:when test="${not empty categoryToEdit}">
                    <h3><i class="fa-solid fa-pen"></i> Sửa danh mục</h3>
                    <form action="${pageContext.request.contextPath}/admin/category" method="post">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="categoryId" value="${categoryToEdit.id}">
                        <input type="hidden" name="_csrf" value="${csrfToken}">
                        <input type="text" name="categoryName" value="<c:out value='${categoryToEdit.name}'/>" required>
                        <button type="submit" class="btn btn-primary">Cập nhật</button>
                        <a href="${pageContext.request.contextPath}/admin/category" class="btn btn-secondary">Hủy</a>
                    </form>
                </c:when>
                <c:otherwise>
                    <h3><i class="fa-solid fa-plus"></i> Thêm danh mục mới</h3>
                    <form action="${pageContext.request.contextPath}/admin/category" method="post">
                        <input type="hidden" name="action" value="add">
                        <input type="hidden" name="_csrf" value="${csrfToken}">
                        <input type="text" name="categoryName" required placeholder="Nhập tên danh mục">
                        <button type="submit" class="btn btn-primary">Thêm</button>
                    </form>
                </c:otherwise>
            </c:choose>
        </div>

        <c:if test="${not empty sessionScope.errorMessage}">
            <p class="error-message"><c:out value="${sessionScope.errorMessage}"/></p>
            <c:remove var="errorMessage" scope="session"/>
        </c:if>

        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Tên danh mục</th>
                    <th>Hành động</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="c" items="${categories}">
                    <tr>
                        <td>${c.id}</td>
                        <td><strong><c:out value="${c.name}"/></strong></td>
                        <td>
                            <a href="${pageContext.request.contextPath}/admin/category?action=viewDetails&id=${c.id}" class="btn btn-info" style="padding: 5px 10px;">
                                <i class="fa-solid fa-list"></i> Chi tiết
                            </a>
                            <a href="${pageContext.request.contextPath}/admin/category?action=edit&id=${c.id}" class="btn btn-primary" style="padding: 5px 10px;">
                                <i class="fa-solid fa-pen"></i> Sửa
                            </a>
                            <a href="${pageContext.request.contextPath}/admin/category?action=delete&id=${c.id}&_csrf=${csrfToken}" 
                               class="btn btn-danger" style="padding: 5px 10px;"
                               onclick="return confirm('Xác nhận xóa danh mục này?')">
                                <i class="fa-solid fa-trash"></i> Xóa
                            </a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <c:if test="${not empty selectedCategory}">
            <hr style="margin: 3rem 0; border: 1px solid #e0e0e0;">
            <div class="product-list-container">
                <h3><i class="fa-solid fa-list-ul"></i> Sản phẩm thuộc: <c:out value="${selectedCategory.name}"/></h3>
                <c:choose>
                    <c:when test="${not empty productsOfCategory}">
                        <table>
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Tên sản phẩm</th>
                                    <th>Giá</th>
                                    <th>Mô tả</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="p" items="${productsOfCategory}">
                                    <tr>
                                        <td>${p.id}</td>
                                        <td><strong><c:out value="${p.name}"/></strong></td>
                                        <td><fmt:formatNumber value="${p.price}" type="currency" currencySymbol="₫"/></td>
                                        <td><c:out value="${p.description}"/></td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:when>
                    <c:otherwise>
                        <p class="info-message">Danh mục này hiện chưa có sản phẩm nào.</p>
                    </c:otherwise>
                </c:choose>
            </div>
        </c:if>
    </div>
</body>
</html>