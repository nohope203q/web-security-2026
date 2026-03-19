<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Quản lý danh mục</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/admin/styles/main.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <style>
            /* General Body and Main Container Styles */
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #f0f2f5;
                margin: 0;
                display: flex;
            }

            .main {
                flex-grow: 1;
                padding: 2.5rem;
                background-color: #f0f2f5;
                min-height: 100vh;
            }

            /* Heading Styles */
            h1 {
                color: #1a2a4b;
                border-bottom: 2px solid #e0e0e0;
                padding-bottom: 0.5rem;
                margin-bottom: 2rem;
                font-size: 2rem;
            }

            h3 {
                color: #334e68;
                margin-top: 0;
                margin-bottom: 1.5rem;
                display: flex;
                align-items: center;
                gap: 10px;
                font-weight: 600;
            }

            /* Form Container Styles */
            .form-container {
                background-color: #fff;
                padding: 2.5rem;
                border-radius: 12px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
                margin-bottom: 2.5rem;
            }

            .form-container form {
                display: flex;
                align-items: center;
                gap: 15px;
                flex-wrap: wrap;
            }

            .form-container input[type="text"] {
                flex: 1;
                min-width: 250px;
                padding: 0.8rem 1rem;
                border: 1px solid #d1d9e6;
                border-radius: 8px;
                font-size: 1rem;
                transition: border-color 0.3s, box-shadow 0.3s;
            }

            .form-container input[type="text"]:focus {
                outline: none;
                border-color: #007bff;
                box-shadow: 0 0 0 3px rgba(0, 123, 255, 0.25);
            }

            /* Button Styles */
            .btn {
                display: inline-flex;
                align-items: center;
                padding: 0.8rem 1.5rem;
                border: none;
                border-radius: 8px;
                font-size: 1rem;
                cursor: pointer;
                text-decoration: none;
                transition: background-color 0.3s, transform 0.2s, box-shadow 0.3s;
                color: #fff;
                font-weight: 500;
                white-space: nowrap;
            }

            .btn i {
                margin-right: 8px;
            }

            .btn:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
            }

            .btn-primary {
                background-color: #007bff;
            }

            .btn-primary:hover {
                background-color: #0056b3;
            }

            .btn-danger {
                background-color: #dc3545;
            }

            .btn-danger:hover {
                background-color: #c82333;
            }

            .btn-secondary {
                background-color: #6c757d;
                color: #fff;
            }

            .btn-secondary:hover {
                background-color: #5a6268;
            }

            /* --- NEW --- Button Info Style */
            .btn-info {
                background-color: #17a2b8;
            }

            .btn-info:hover {
                background-color: #138496;
            }

            /* Table Styles */
            table {
                width: 100%;
                border-collapse: separate;
                border-spacing: 0;
                background-color: #fff;
                border-radius: 12px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
                overflow: hidden;
            }

            th, td {
                padding: 1.2rem 1.5rem;
                text-align: left;
                border-bottom: 1px solid #e0e0e0;
            }

            td .btn {
                margin-right: 5px; /* Add some space between buttons */
            }

            th {
                background-color: #f8f9fa;
                font-weight: bold;
                color: #555;
                text-transform: uppercase;
            }

            tr:last-child td {
                border-bottom: none;
            }

            tr:hover {
                background-color: #f5f5f5;
            }

            /* Error/Info Message Styles */
            .error-message {
                color: #dc3545;
                background-color: #f8d7da;
                border: 1px solid #f5c6cb;
                padding: 1rem;
                border-radius: 6px;
                margin-bottom: 1.5rem;
                text-align: center;
                font-weight: 500;
            }

            /* --- NEW --- Info Message for no products */
            .info-message {
                color: #0c5460;
                background-color: #d1ecf1;
                border: 1px solid #bee5eb;
                padding: 1rem;
                border-radius: 6px;
                margin-top: 1.5rem;
            }
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
                            <input type="text" name="categoryName" value="${categoryToEdit.name}" required placeholder="Nhập tên danh mục">
                            <button type="submit" class="btn btn-primary">Cập nhật</button>
                            <a href="${pageContext.request.contextPath}/admin/category" class="btn btn-secondary">Hủy</a>
                        </form>
                    </c:when>
                    <c:otherwise>
                        <h3><i class="fa-solid fa-plus"></i> Thêm danh mục mới</h3>
                        <form action="${pageContext.request.contextPath}/admin/category" method="post">
                            <input type="hidden" name="action" value="add">
                            <input type="text" name="categoryName" required placeholder="Nhập tên danh mục">
                            <button type="submit" class="btn btn-primary">Thêm</button>
                        </form>
                    </c:otherwise>
                </c:choose>
            </div>

            <c:if test="${not empty sessionScope.errorMessage}">
                <p class="error-message">${sessionScope.errorMessage}</p>
                <c:remove var="errorMessage" scope="session"/>
            </c:if>

            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Tên</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="c" items="${categories}">
                        <tr>
                            <td>${c.id}</td>
                            <td>${c.name}</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/admin/category?action=viewDetails&id=${c.id}" class="btn btn-info">
                                    <i class="fa-solid fa-list"></i> Xem chi tiết
                                </a>
                                <a href="${pageContext.request.contextPath}/admin/category?action=edit&id=${c.id}" class="btn btn-primary">
                                    <i class="fa-solid fa-pen"></i> Sửa
                                </a>
                                <a href="${pageContext.request.contextPath}/admin/category?action=delete&id=${c.id}" 
                                   class="btn btn-danger" 
                                   onclick="return confirm('Bạn có chắc chắn muốn xóa danh mục này? Việc này không thể hoàn tác.')">
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
                    <h3><i class="fa-solid fa-list-ul"></i> Sản phẩm trong danh mục: ${selectedCategory.name}</h3>

                    <c:choose>
                        <c:when test="${not empty productsOfCategory}">
                            <table>
                                <thead>
                                    <tr>
                                        <th>ID Sản phẩm</th>
                                        <th>Tên sản phẩm</th>
                                        <th>Giá</th>
                                        <th>Mô tả</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="p" items="${productsOfCategory}">
                                        <tr>
                                            <td>${p.id}</td>
                                            <td>${p.name}</td>
                                            <td>${p.price}</td>
                                            <td>${p.description}</td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </c:when>
                        <c:otherwise>
                            <p class="info-message">Không có sản phẩm nào trong danh mục này.</p>
                        </c:otherwise>
                    </c:choose>
                </div>
            </c:if>

        </div>

    </body>
</html>