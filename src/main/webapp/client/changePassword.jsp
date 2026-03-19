<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Đổi mật khẩu</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/client/css/style-2.css">
    </head>
    <body>
        <%-- Đổi class thành "container" để đồng bộ --%>
        <div class="container">
            <h2>Đổi mật khẩu</h2>

            <%-- Hiển thị thông báo ở trên cùng để dễ thấy hơn --%>
            <c:if test="${not empty error}">
                <p class="error">${error}</p>
            </c:if>
            <c:if test="${not empty message}">
                <p class="success">${message}</p>
            </c:if>

            <form action="${pageContext.request.contextPath}/client/changePassword" method="post">
                <%-- Bọc mỗi cặp label/input trong một div.form-group --%>
                <div class="form-group">
                    <label for="oldPassword">Mật khẩu hiện tại:</label>
                    <input type="password" id="oldPassword" name="oldPassword" required>
                </div>

                <div class="form-group">
                    <label for="newPassword">Mật khẩu mới:</label>
                    <input type="password" id="newPassword" name="newPassword" required>
                </div>

                <div class="form-group">
                    <label for="confirmPassword">Xác nhận mật khẩu:</label>
                    <input type="password" id="confirmPassword" name="confirmPassword" required>
                </div>

                <%-- Nhóm các nút hành động lại --%>
                <div class="form-actions">
                    <button type="submit" class="btn-primary">Lưu thay đổi</button>
                    <a href="${pageContext.request.contextPath}/client/profile" class="btn-secondary">Hủy</a>
                </div>
            </form>
        </div>
    </body>
</html>