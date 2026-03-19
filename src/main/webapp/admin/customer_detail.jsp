<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Chi tiết đơn hàng</title>
        <link rel="stylesheet" href="<%= request.getContextPath() %>/admin/styles/main.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    </head>
    <body>

        <%@ include file="includes/sidebar.jsp" %>

        <div class="main">
            <h2>Thông tin khách hàng</h2>
            <table>
                <thead>
                    <tr>
                        <th>Tên khách hàng</th>
                        <th>Email</th>
                        <th>Số điện thoại</th>
                        <th>Ngày tạo</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>${users.getName()}</td>
                        <td>${users.getEmail()}</td>
                        <td>${users.getPhone()}</td>
                        <td><fmt:formatDate value="${users.getCreatedAt()}" pattern="yyyy-MM-dd"/></td>
                    </tr>
                </tbody>
            </table>
            <a href="${pageContext.request.contextPath}/admin/customer" class="btn">← Quay lại danh sách</a>
        </div>

    </body>
</html>
