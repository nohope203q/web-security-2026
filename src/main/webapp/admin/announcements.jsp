<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý thông báo khuyến mãi</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/admin/styles/main.css">
    <style>
        body { font-family: 'Segoe UI', sans-serif; background-color: #f0f2f5; margin: 0; display: flex; }
        .main { flex-grow: 1; padding: 2.5rem; }
        h2 { color: #1a2a4b; margin-bottom: 20px; }
        
        .action-bar { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; }
        
        table { width: 100%; border-collapse: collapse; background: #fff; border-radius: 10px; overflow: hidden; box-shadow: 0 4px 12px rgba(0,0,0,0.08); }
        th, td { padding: 15px; text-align: left; border-bottom: 1px solid #eee; }
        th { background-color: #f8f9fa; color: #555; text-transform: uppercase; font-size: 0.85rem; }
        
        .status-badge { padding: 5px 10px; border-radius: 20px; font-size: 0.8rem; font-weight: bold; text-transform: capitalize; }
        .status-active { background: #dcfce7; color: #166534; }
        .status-expired { background: #fee2e2; color: #991b1b; }
        .status-draft { background: #f3f4f6; color: #374151; }
        .status-scheduled { background: #fef9c3; color: #854d0e; }

        .btn-action { 
            display: inline-flex; align-items: center; justify-content: center; 
            width: 34px; height: 34px; color: white; border-radius: 8px; 
            text-decoration: none; transition: 0.2s; margin-right: 4px;
            border: none; cursor: pointer;
        }
        .btn-view { background-color: #3b82f6; }
        .btn-edit { background-color: #10b981; }
        .btn-delete { background-color: #ef4444; }
        .btn-action:hover { transform: translateY(-2px); opacity: 0.9; }

        .btn-primary { 
            background-color: #2563eb; color: white; padding: 10px 20px; 
            border-radius: 8px; text-decoration: none; font-weight: 500;
        }
    </style>
</head>
<body>
    <jsp:include page="includes/sidebar.jsp" />

    <div class="main">
        <h2>Danh sách thông báo khuyến mãi</h2>
        
        <div class="action-bar">
            <a class="btn-primary" href="${pageContext.request.contextPath}/admin/announcements?action=addForm">
                <i class="fa-solid fa-plus"></i> Thêm thông báo
            </a>
        </div>

        <table>
            <thead>
                <tr>
                    <th style="width: 40%;">Tiêu đề</th>
                    <th>Thời gian hiệu lực</th>
                    <th>Trạng thái</th>
                    <th>Thao tác</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty announcements}">
                        <c:forEach var="a" items="${announcements}">
                            <tr>
                                <td><strong><c:out value="${a.title}"/></strong></td>
                                <td>
                                    <small class="text-muted">
                                        <fmt:formatDate value="${a.startDate}" pattern="dd/MM/yyyy"/> 
                                        <i class="fa-solid fa-arrow-right" style="font-size: 0.7rem; margin: 0 5px;"></i>
                                        <fmt:formatDate value="${a.endDate}" pattern="dd/MM/yyyy"/>
                                    </small>
                                </td>
                                <td>
                                    <span class="status-badge status-${a.status}">
                                        <c:out value="${a.status}"/>
                                    </span>
                                </td>
                                <td>
                                    <div style="display: flex;">
                                        <a href="${pageContext.request.contextPath}/admin/announcements?action=view&id=${a.id}" 
                                           class="btn-action btn-view" title="Xem chi tiết">
                                            <i class="fa-solid fa-eye"></i>
                                        </a>
                                        <a href="${pageContext.request.contextPath}/admin/announcements?action=editForm&id=${a.id}" 
                                           class="btn-action btn-edit" title="Chỉnh sửa">
                                            <i class="fa-solid fa-pen"></i>
                                        </a>
                                        <form action="${pageContext.request.contextPath}/admin/announcements" method="post" style="margin: 0;" onsubmit="return confirm('Xác nhận xóa thông báo này?')">
                                            <input type="hidden" name="_csrf" value="${sessionScope.csrfToken}">
                                            <input type="hidden" name="action" value="delete">
                                            <input type="hidden" name="id" value="${a.id}">
                                            <button type="submit" class="btn-action btn-delete" title="Xóa">
                                                <i class="fa-solid fa-trash"></i>
                                            </button>
                                        </form>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="4" style="text-align: center; padding: 40px; color: #888;">Chưa có thông báo nào được tạo.</td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>
</body>
</html>