<%@page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Admin Dashboard</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <link rel="stylesheet" href="<%= request.getContextPath() %>/admin/styles/main.css">
    </head>
    <body>

        <%@ include file="includes/sidebar.jsp" %>

        <div class="main">
            <h1>Trang quản trị</h1>
            <p>Chọn chức năng ở menu bên trái để bắt đầu quản lý.</p>
        </div>
    </body>
</html>