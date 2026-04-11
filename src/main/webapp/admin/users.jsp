<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý người dùng</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/admin/styles/main.css">
    <style>
        body { font-family: 'Segoe UI', sans-serif; background-color: #f0f2f5; margin: 0; display: flex; }
        .main { flex-grow: 1; padding: 2.5rem; }
        .page-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 25px; background: #fff; padding: 15px 20px; border-radius: 10px; box-shadow: 0 2px 5px rgba(0,0,0,0.05); }
        h2 { margin: 0; color: #1a2a4b; }
        .search-form { display: flex; align-items: center; }
        #searchInput { padding: 10px 15px; border-radius: 20px 0 0 20px; border: 1px solid #ddd; border-right: none; width: 300px; font-size: 14px; }
        .search-button { padding: 10px 20px; border: 1px solid #10b981; background-color: #10b981; color: white; border-radius: 0 20px 20px 0; cursor: pointer; transition: 0.3s; }
        .search-button:hover { background-color: #059669; }
        table { width: 100%; border-collapse: collapse; background: #fff; border-radius: 10px; overflow: hidden; box-shadow: 0 4px 12px rgba(0,0,0,0.08); }
        th, td { padding: 15px; text-align: left; border-bottom: 1px solid #eee; }
        th { background-color: #f8f9fa; color: #555; text-transform: uppercase; font-size: 0.85rem; }
        .btn-action { display: inline-flex; align-items: center; justify-content: center; width: 35px; height: 35px; color: white; border-radius: 8px; text-decoration: none; transition: 0.2s; margin-right: 5px; }
        .btn-view { background-color: #3b82f6; }
        .btn-delete { background-color: #ef4444; }
        .btn-action:hover { transform: translateY(-2px); opacity: 0.9; }
    </style>
</head>
<body>
    <jsp:include page="includes/sidebar.jsp" />

    <div class="main">
        <div class="page-header">
            <h2>Danh sách khách hàng</h2>
            <form action="${pageContext.request.contextPath}/admin/customer" method="get" class="search-form">
                <input type="hidden" name="action" value="search">
                <input type="text" id="searchInput" name="searchTerm" placeholder="Tên, username hoặc email..." value="<c:out value='${searchTerm}'/>">
                <button type="submit" class="search-button"><i class="fa-solid fa-search"></i> Tìm kiếm</button>
            </form>
        </div>

        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Họ và tên</th>
                    <th>Email</th>
                    <th>Số điện thoại</th>
                    <th>Thao tác</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty users}">
                        <c:forEach var="u" items="${users}">
                            <tr>
                                <td>${u.id}</td>
                                <td><strong><c:out value="${u.name}"/></strong></td>
                                <td><c:out value="${u.email}"/></td>
                                <td><c:out value="${u.phone}"/></td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/admin/customer?action=viewCustomer&id=${u.id}" 
                                       class="btn-action btn-view" title="Xem chi tiết">
                                        <i class="fa-solid fa-eye"></i>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/admin/customer?action=deleteCustomer&id=${u.id}" 
                                       class="btn-action btn-delete" title="Xóa"
                                       onclick="return confirm('Xác nhận xóa người dùng: ${fn:escapeXml(u.name)}?')">
                                        <i class="fa-solid fa-trash"></i>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="5" style="text-align: center; padding: 40px; color: #888;">Không tìm thấy người dùng nào.</td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>
</body>
</html>