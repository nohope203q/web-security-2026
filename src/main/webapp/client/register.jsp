<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <title>Tạo tài khoản | PC SHOP</title>
        <meta charset="UTF-8">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/client/css/style-2.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    </head>
    <body>
        <div class="container">
            <h2 class="form-title">Tạo Tài Khoản</h2>

            <%-- Sử dụng các class error/success đã có --%>
            <c:if test="${not empty error}">
                <p class="error">${error}</p>
            </c:if>
            <c:if test="${not empty message}">
                <p class="success">${message}</p>
            </c:if>

            <form action="${pageContext.request.contextPath}/client/register" method="post">
                <div class="form-group">
                    <label for="name"><i class="fas fa-user"></i> Họ và tên</label>
                    <input type="text" id="name" name="name" placeholder="Nhập họ và tên của bạn" required>
                </div>

                <div class="form-group">
                    <label for="email"><i class="fas fa-envelope"></i> Email</label>
                    <input type="email" id="email" name="email" placeholder="Nhập địa chỉ email" required>
                </div>

                <div class="form-group">
                    <label for="phone"><i class="fas fa-phone"></i> Số điện thoại</label>
                    <input type="text" id="phone" name="phone" placeholder="Nhập số điện thoại" required>
                </div>

                <div class="form-group">
                    <label for="password"><i class="fas fa-lock"></i> Mật khẩu</label>
                    <input type="password" id="password" name="password" placeholder="Tạo mật khẩu của bạn" required>
                </div>

                <div class="form-group">
                    <label for="confirmPassword"><i class="fas fa-lock"></i> Xác nhận mật khẩu</label>
                    <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Tạo mật khẩu của bạn" required>
                </div>                


                <button type="submit" class="btn-primary btn-full">Đăng Ký</button>
            </form>

            <div class="form-footer">
                <p>Đã có tài khoản? <a href="${pageContext.request.contextPath}/client/login.jsp" class="link">Đăng nhập ngay</a></p>
            </div>
        </div>
    </body>
</html>