<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
    <head>
        <title>Cập nhật hồ sơ</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/client/css/style-2.css">
    </head>
    <body>
        <div class="container">
            <h2>Cập nhật thông tin cá nhân</h2>

            <form action="${pageContext.request.contextPath}/client/ChangeProfileServlet" method="post">
                <div class="form-group">
                    <label for="name">Họ và tên:</label>
                    <input type="text" id="name" name="name" value="${account.name}" required>
                </div>

                <div class="form-group">
                    <label for="phone">Số điện thoại:</label>
                    <input type="text" id="phone" name="phone" value="${account.phone}" required>
                </div>

                <div class="form-group">
                    <label for="email">Email:</label>
                    <input type="email" id="email" name="email" value="${account.email}" required>
                    <p style="font-size: 13px; color: gray;">Nếu bạn đổi email, hệ thống sẽ gửi mã OTP xác nhận địa chỉ mới.</p>
                </div>

                <div class="form-actions">
                    <button type="submit" class="btn-primary">Lưu thay đổi</button>
                    <a href="${pageContext.request.contextPath}/client/profile" class="btn-secondary">Hủy</a>
                </div>
            </form>

            <c:if test="${not empty error}">
                <p class="error">${error}</p>
            </c:if>
            <c:if test="${not empty message}">
                <p class="success">${message}</p>
            </c:if>
        </div>
    </body>
</html>
