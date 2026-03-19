<%@page contentType="text/html; charset=UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Tài khoản Admin</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <link rel="stylesheet" href="<%= request.getContextPath() %>/admin/styles/main.css">
    </head>
    <body>

        <%@ include file="includes/sidebar.jsp" %>

        <div class="main-content">
            <h2>Thông tin tài khoản Admin</h2>

            <c:if test="${not empty message}">
                <p class="success">${message}</p>
            </c:if>

            <form method="post" action="account">
                <div class="form-group">
                    <label>Tên:</label>
                    <input type="text" name="name" value="${admin.name}" required>
                </div>

                <div class="form-group">
                    <label>Email:</label>
                    <input type="email" name="email" value="${admin.email}" readonly>
                </div>

                <div class="form-group">
                    <label>Số điện thoại:</label>
                    <input type="text" name="phone" value="${admin.phone}">
                </div>

                <div class="form-group">
                    <label>Mật khẩu mới (nếu muốn đổi):</label>
                    <input type="password" name="password">
                </div>

                <button type="submit">Cập nhật</button>
            </form>
        </div>

    </body>
</html>
