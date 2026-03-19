<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Xác minh OTP</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
            <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .card {
            border: none;
            border-radius: 15px;
        }
        .card-body {
            padding: 40px;
        }
        .card h4 {
            font-weight: 600;
            color: #333;
        }
        input[type="email"] {
            width: 100%;
            padding: 10px;
            border: 1.5px solid #ced4da;
            border-radius: 8px;
            transition: all 0.3s ease;
        }
        input[type="email"]:focus {
            border-color: #6f42c1;
            box-shadow: 0 0 5px rgba(111, 66, 193, 0.4);
            outline: none;
        }
    button[type="submit"] {
        width: 100%;
        background-color: #0d6efd; /* xanh dương chuẩn Bootstrap */
        color: white;
        font-weight: 500;
        border: none;
        border-radius: 8px;
        padding: 10px;
        transition: all 0.3s ease;
    }

    button[type="submit"]:hover {
        background-color: #0b5ed7; /* màu xanh hover đậm hơn */
        transform: scale(1.02);
    }

    button[type="submit"]:active {
        background-color: #0a58ca; /* màu khi bấm giữ */
        transform: scale(0.98);
    }
        .alert {
            border-radius: 8px;
        }
        a {
            color: #6f42c1;
            text-decoration: none;
            transition: color 0.2s;
        }
        a:hover {
            color: #8e44ad;
            text-decoration: underline;
        }
    </style>
    </head>
    <body class="bg-light">

        <div class="container mt-5">
            <div class="card shadow-lg mx-auto" style="max-width: 420px;">
                <div class="card-body">
                    <h4 class="text-center mb-4">Xác minh OTP</h4>
                    <form action="verifyOtp" method="post">
                        <div class="mb-3">
                            <label for="otp" class="form-label">Nhập mã OTP</label>
                            <input type="text" class="form-control" id="otp" name="otp" maxlength="6" placeholder="6 chữ số OTP" required>
                        </div>
                        <button type="submit" class="btn btn-success w-100">Xác nhận</button>
                    </form>
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger mt-3">${error}</div>
                    </c:if>
                    <div class="text-center mt-3">
                        <a href="forgotPassword.jsp">← Gửi lại OTP</a>
                    </div>
                </div>
            </div>
        </div>

    </body>
</html>
