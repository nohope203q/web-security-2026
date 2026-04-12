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
        <div class="container">
            <h2>Đổi mật khẩu</h2>

            <c:if test="${not empty error}">
                <p class="error"><c:out value="${error}"/></p>
            </c:if>
            <c:if test="${not empty message}">
                <p class="success"><c:out value="${message}"/></p>
            </c:if>

            <form action="${pageContext.request.contextPath}/client/changePassword" method="post">
                <input type="hidden" name="_csrf" value="${sessionScope.csrfToken}">
                
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

                <div class="form-actions">
                    <button type="submit" class="btn-primary">Lưu thay đổi</button>
                    <a href="${pageContext.request.contextPath}/client/profile" class="btn-secondary">Hủy</a>
                </div>
            </form>
        </div>
    </body>
</html>