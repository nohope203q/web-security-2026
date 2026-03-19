<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Chi tiết đơn hàng</title>
        <link rel="stylesheet" href="<%= request.getContextPath() %>/admin/styles/main.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    </head>
    <body>

        <%@ include file="includes/sidebar.jsp" %>

        <div class="main">

            <h2>Thông tin thông báo</h2>
            <table>
                <thead>
                    <tr>
                        <th>Tiêu đề</th>
                        <th>Nội dung</th>
                        <th>Trạng thái</th>
                        <th>Ngày bắt đầu</th>
                        <th>Ngày kết thúc</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>${announ.getTitle()}</td>
                        <td>${announ.getContent()}</td>
                        <td>${announ.getStatus()}</td>
                        <td><fmt:formatDate value="${announ.getStartDate()}" pattern="yyyy-MM-dd"/></td>
                        <td><fmt:formatDate value="${announ.getEndDate()}" pattern="yyyy-MM-dd"/></td>
                    </tr>
                </tbody>
            </table>
            <a href="${pageContext.request.contextPath}/admin/announcements" class="btn">← Quay lại danh sách</a>
        </div>

    </body>
</html>
