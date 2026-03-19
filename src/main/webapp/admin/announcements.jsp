<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Quản lý thông báo khuyến mãi</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <link rel="stylesheet" href="<c:url value='/admin/styles/main.css'/>">
        <style>
            .add-btn {
                padding: 10px 20px;
                background-color: #28a745;
                color: white;
                text-decoration: none;
                border-radius: 5px;
                font-size: 16px;
                display: inline-block;
                margin-bottom: 20px;
            }

            .add-btn:hover {
                background-color: #218838;
            }
            .btn-action {
                display: inline-flex;
                align-items: center;
                justify-content: center;
                width: 38px;
                height: 38px;

                background-color: #10b981;
                color: white;

                border: none;
                border-radius: 8px;

                text-decoration: none;
                cursor: pointer;

                transition: all 0.2s ease-in-out;
            }

            .btn-action:hover {
                background-color: #059669;
                transform: translateY(-2px);
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }

            .btn-action i {
                font-size: 16px;
            }
        </style>
    </head>
    <body>
        <%@ include file="includes/sidebar.jsp" %>
        <div class="main">
            <h2>Danh sách thông báo khuyến mãi</h2>
            <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:20px;">
                <a class="btn btn-primary" href="${pageContext.request.contextPath}/admin/announcements?action=addForm">+ Thêm thông báo</a>
            </div>
            <table>
                <thead>
                    <tr>
                        <th>Tiêu đề</th>
                        <th>Thời gian</th>
                        <th>Trạng thái</th>
                        <th>Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="a" items="${announcements}">
                        <tr>
                            <td>${a.getTitle()}</td>
                            <td><fmt:formatDate value="${a.startDate}" pattern="yyyy-MM-dd"/> → <fmt:formatDate value="${a.endDate}" pattern="yyyy-MM-dd"/></td>
                            <td>${a.getStatus()}</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/admin/announcements?action=view&amp;id=${a.getId()}" class="btn-action" title="Xem chi tiết">
                                    <i class="fa-solid fa-eye"></i>
                                </a>
                                <a href="${pageContext.request.contextPath}/admin/announcements?action=editForm&amp;id=${a.getId()}" class="btn-action" title="Chỉnh sửa">
                                    <i class="fa-solid fa-pen"></i>
                                </a>
                                <a href="${pageContext.request.contextPath}/admin/announcements?action=delete&amp;id=${a.getId()}" class="btn-action" title="Xóa"
                                   onclick="return confirm('Bạn có chắc chắn muốn xóa thong bao nay không?');">
                                    <i class="fa-solid fa-trash"></i>
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </body>
</html>
