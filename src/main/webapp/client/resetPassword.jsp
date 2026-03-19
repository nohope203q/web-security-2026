<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Đặt lại mật khẩu</title>
        <link rel="stylesheet" href="assets/css/style.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body class="bg-light">

        <div class="container mt-5">
            <div class="card shadow-lg mx-auto" style="max-width: 420px;">
                <div class="card-body">
                    <h4 class="text-center mb-4">🔒 Đặt lại mật khẩu</h4>
                    <form action="resetPassword" method="post">
                        <div class="mb-3">
                            <label for="newPassword" class="form-label">Mật khẩu mới</label>
                            <input type="password" class="form-control" id="newPassword" name="newPassword" required>
                        </div>
                        <div class="mb-3">
                            <label for="confirmPassword" class="form-label">Xác nhận mật khẩu</label>
                            <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
                        </div>
                        <button type="submit" class="btn btn-primary w-100">Đặt lại</button>
                    </form>
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger mt-3">${error}</div>
                    </c:if>
                    <c:if test="${not empty message}">
                        <div class="alert alert-success mt-3">${message}</div>
                    </c:if>
                    <div class="text-center mt-3">
                        <a href="login.jsp">← Quay lại đăng nhập</a>
                    </div>
                </div>
            </div>
        </div>

    </body>
</html>
