<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>Xác nhận Email mới</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/client/css/style-2.css">
    </head>
    <body>
        <div class="container">
            <h2>Xác nhận Email mới</h2>
            <p>Chúng tôi đã gửi mã OTP đến email của bạn. Vui lòng nhập mã để hoàn tất cập nhật hồ sơ.</p>

            <form action="${pageContext.request.contextPath}/client/VerifyEmailChangeServlet" method="post">
                <div class="form-group">
                    <label for="otp">Mã OTP:</label>
                    <input type="text" id="otp" name="otp" required>
                </div>

                <button type="submit" class="btn-primary">Xác nhận</button>
            </form>

            <c:if test="${not empty error}">
                <p class="error">${error}</p>
            </c:if>
        </div>
    </body>
</html>
