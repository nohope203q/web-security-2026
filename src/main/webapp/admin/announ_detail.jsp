<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết thông báo</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/admin/styles/main.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        body { font-family: 'Segoe UI', sans-serif; background-color: #f0f2f5; margin: 0; display: flex; }
        .main { flex-grow: 1; padding: 2.5rem; }
        h2 { color: #1a2a4b; margin-bottom: 1.5rem; display: flex; align-items: center; gap: 10px; }
        table { width: 100%; border-collapse: collapse; background: #fff; border-radius: 8px; overflow: hidden; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        th, td { padding: 15px; text-align: left; border-bottom: 1px solid #eee; }
        th { background-color: #f8f9fa; color: #555; text-transform: uppercase; font-size: 0.9rem; }
        .status-active { color: #10b981; font-weight: bold; }
        .btn { display: inline-flex; align-items: center; gap: 8px; padding: 10px 20px; background: #6c757d; color: #fff; text-decoration: none; border-radius: 5px; margin-top: 20px; transition: 0.3s; }
        .btn:hover { background: #5a6268; }
    </style>
</head>
<body>

    <jsp:include page="includes/sidebar.jsp" />

    <div class="main">
        <h2><i class="fa-solid fa-circle-info"></i> Chi tiết thông báo</h2>
        
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
                    <td><strong><c:out value="${announ.title}"/></strong></td>
                    <td><c:out value="${announ.content}"/></td>
                    <td>
                        <span class="status-active"><c:out value="${announ.status}"/></span>
                    </td>
                    <td><fmt:formatDate value="${announ.startDate}" pattern="dd/MM/yyyy"/></td>
                    <td><fmt:formatDate value="${announ.endDate}" pattern="dd/MM/yyyy"/></td>
                </tr>
            </tbody>
        </table>

        <a href="${pageContext.request.contextPath}/admin/announcements" class="btn">
            <i class="fa-solid fa-arrow-left"></i> Quay lại danh sách
        </a>
    </div>

</body>
</html>