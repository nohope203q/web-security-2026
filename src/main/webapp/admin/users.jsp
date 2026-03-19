<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Quản lý người dùng</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <link rel="stylesheet" href="<%= request.getContextPath()%>/admin/styles/main.css">
        <style>
            .page-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 20px;
            }
            .search-container {
                position: relative;
            }
            .search-form {
                display: flex;
                align-items: center;
            }
            #searchInput {
                padding: 8px 15px;
                border-radius: 20px 0 0 20px;
                border: 1px solid #ccc;
                border-right: none;
                font-size: 14px;
                width: 300px;
            }
            #searchInput:focus {
                outline: none;
                border-color: #28a745;
            }
            .search-button {
                padding: 8px 15px;
                border: 1px solid #28a745;
                background-color: #28a745;
                color: white;
                border-radius: 0 20px 20px 0;
                cursor: pointer;
            }
            .search-button:hover {
                background-color: #218838;
            }
            .btn-action {
                display: inline-flex;
                align-items: center;
                justify-content: center;
                width: 38px;
                height: 38px;

                background-color: #10b981;
                color: white;

                border: none;
                border-radius: 8px;

                text-decoration: none;
                cursor: pointer;

                transition: all 0.2s ease-in-out;
            }

            .btn-action:hover {
                background-color: #059669;
                transform: translateY(-2px);
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }

            .btn-action i {
                font-size: 16px;
            }
            .add-btn {
                padding: 10px 20px;
                background-color: #28a745;
                color: white;
                text-decoration: none;
                border-radius: 5px;
                font-size: 16px;
                display: inline-block;
                margin-bottom: 20px;
            }

            .add-btn:hover {
                background-color: #218838;
            }
        </style>
    </head>
    <body>
        <%@ include file="includes/sidebar.jsp" %>
        <div class="main">
            <h2>Danh sách khách hàng</h2>
            <div class="page-header">
                <div class="search-container">
                    <form action="${pageContext.request.contextPath}/admin/customer" method="get">
                        <input type="text" id="searchInput" name="searchTerm" placeholder="Tìm kiếm theo tên, username, email..." value="${searchTerm}">
                        <button type="submit" class="search-button"><i class="fa-solid fa-search"></i></button>
                        <input type="hidden" name="action" value="search">
                    </form>

                </div>
            </div>

            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Tên người dùng</th>
                        <!--                    <th>Username</th>-->
                        <th>Email</th>
                        <th>Số điện thoại</th>
                        <th>Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
                    <c:forEach var="u" items="${users}">
                        <tr>
                            <td>${u.getId()}</td>
                            <td>${u.getName()}</td>
                            <td>${u.getEmail()}</td>
                            <td>${u.getPhone()}</td>
                            <td class="actions">
                                <a href="${pageContext.request.contextPath}/admin/customer?action=viewCustomer&amp;id=${u.getId()}" class="btn-action" title="Xem chi tiết">
                                    <i class="fa-solid fa-eye"></i>
                                </a>

                                <a href="${pageContext.request.contextPath}/admin/customer?action=deleteCustomer&amp;id=${u.getId()}" class="btn-action" title="Xóa"
                                   onclick="return confirm('Bạn có chắc chắn muốn xóa người dùng \'${fn:escapeXml(u.getName())}\' không?');">
                                    <i class="fa-solid fa-trash"></i>
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty users}">
                        <tr>
                            <td colspan="6" style="text-align: center;">Không tìm thấy người dùng nào.</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </body>
</html>