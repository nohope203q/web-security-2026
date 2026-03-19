<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <title>Đăng nhập | PC SHOP</title>
        <meta charset="UTF-8">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/client/css/style-2.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    </head>
    <body>
        <div class="container">
            <h2 class="form-title">Đăng Nhập</h2>

            <c:if test="${not empty error}">
                <%-- Sử dụng class "error" đã có trong file css của bạn --%>
                <p class="error">${error}</p>
            </c:if>

            <form action="${pageContext.request.contextPath}/client/login" method="post">
                <%-- Nhóm email --%>
                <div class="form-group">
                    <label for="email"><i class="fas fa-envelope"></i> Email</label>
                    <input type="email" id="email" name="email" required placeholder="Nhập địa chỉ email của bạn">
                </div>

                <%-- Nhóm mật khẩu --%>
                <div class="form-group">
                    <label for="password"><i class="fas fa-lock"></i> Mật khẩu</label>
                    <input type="password" id="password" name="password" required placeholder="Nhập mật khẩu">
                </div>

                <%-- Nút đăng nhập --%>
                <button type="submit" class="btn-primary btn-full">Đăng Nhập</button>
            </form>

            <div class="form-footer">
                <a href="${pageContext.request.contextPath}/client/forgotPassword.jsp" class="link">Quên mật khẩu?</a>
                <p>Chưa có tài khoản? <a href="${pageContext.request.contextPath}/client/register.jsp" class="link">Đăng ký ngay</a></p>
            </div>
        </div>
    </body>
</html>