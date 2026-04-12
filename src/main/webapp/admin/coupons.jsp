<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Quản lý mã giảm giá</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/admin/styles/main.css">
        <style>
            body {
                font-family: 'Segoe UI', sans-serif;
                background-color: #f0f2f5;
                margin: 0;
                display: flex;
            }
            .main {
                flex-grow: 1;
                padding: 2.5rem;
            }
            h2 {
                color: #1a2a4b;
                margin-bottom: 20px;
            }
            .table {
                width: 100%;
                border-collapse: separate;
                border-spacing: 0;
                background: #fff;
                border-radius: 12px;
                overflow: hidden;
                box-shadow: 0 4px 12px rgba(0,0,0,0.08);
            }
            th, td {
                padding: 15px;
                text-align: left;
                border-bottom: 1px solid #eee;
            }
            th {
                background: #28a745;
                color: #fff;
                text-transform: uppercase;
                font-size: 0.85rem;
            }
            .badge {
                padding: 5px 10px;
                border-radius: 20px;
                font-size: 12px;
                font-weight: bold;
            }
            .badge.active {
                background: #e7f7ed;
                color: #28a745;
            }
            .badge.scheduled {
                background: #fff4d6;
                color: #b58900;
            }
            .badge.expired {
                background: #ffe6e6;
                color: #c0392b;
            }
            .badge.disabled {
                background: #eee;
                color: #666;
            }
            .btn-action {
                display: inline-flex;
                align-items: center;
                justify-content: center;
                width: 34px;
                height: 34px;
                color: white;
                border-radius: 8px;
                text-decoration: none;
                transition: 0.2s;
                margin-right: 4px;
                border: none;
                cursor: pointer;
            }
            .btn-edit {
                background-color: #10b981;
            }
            .btn-delete {
                background-color: #ef4444;
            }
            .btn-toggle {
                background-color: #3b82f6;
                width: auto;
                padding: 0 10px;
                font-size: 12px;
            }
            .btn-action:hover {
                transform: translateY(-2px);
                opacity: 0.9;
            }
            .btn-primary {
                background-color: #28a745;
                color: white;
                padding: 10px 20px;
                border-radius: 8px;
                text-decoration: none;
                font-weight: 500;
                display: inline-block;
            }
        </style>
    </head>
    <body>
        <jsp:include page="includes/sidebar.jsp" />
        <div class="main">
            <h2>Danh sách mã giảm giá</h2>
            <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:20px;">
                <a class="btn-primary" href="${pageContext.request.contextPath}/admin/coupons?action=addForm">
                    <i class="fa-solid fa-plus"></i> Thêm mã mới
                </a>
            </div>
            <table class="table">
                <thead>
                    <tr>
                        <th>Mã</th>
                        <th>Loại</th>
                        <th>Giá trị</th>
                        <th>ĐK tối thiểu</th>
                        <th>Giới hạn</th>
                        <th>Đã dùng</th>
                        <th>Thời gian</th>
                        <th>Trạng thái</th>
                        <th>Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="c" items="${coupons}">
                        <tr>
                            <td><b><c:out value="${c.code}"/></b></td>
                            <td><c:out value="${c.type}"/></td>
                            <td>
                                <c:choose>
                                    <c:when test="${c.type == 'PERCENT'}">
                                        <fmt:formatNumber value="${c.value}" pattern="#,###"/>% 
                                        <c:if test="${not empty c.maxDiscount}">
                                            <br><small>(Tối đa: <fmt:formatNumber value="${c.maxDiscount}" type="currency" currencySymbol="₫"/>)</small>
                                        </c:if>
                                    </c:when>
                                    <c:otherwise>
                                        <fmt:formatNumber value="${c.value}" type="currency" currencySymbol="₫"/>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td><fmt:formatNumber value="${c.minOrder}" type="currency" currencySymbol="₫"/></td>
                            <td><c:out value="${empty c.usageLimit ? '∞' : c.usageLimit}"/></td>
                            <td><c:out value="${c.usedCount}"/></td>
                            <td>
                                <small>
                                    <c:out value="${fn:replace(c.startDate, '-', '/')}"/> 
                                </small>
                            </td>
                            <td><span class="badge ${c.status}"><c:out value="${c.status}"/></span></td>
                            <td>
                                <a href="${pageContext.request.contextPath}/admin/coupons?action=editForm&id=${c.id}" class="btn-action btn-edit" title="Sửa">
                                    <i class="fa-solid fa-pen"></i>
                                </a>
                                <a href="${pageContext.request.contextPath}/admin/coupons?action=delete&id=${c.id}&_csrf=${csrfToken}" 
                                   class="btn-action btn-delete" title="Xóa" 
                                   onclick="return confirm('Xác nhận xóa mã giảm giá này?')">
                                    <i class="fa-solid fa-trash"></i>
                                </a>
                                <a href="${pageContext.request.contextPath}/admin/coupons?action=toggle&id=${c.id}&_csrf=${csrfToken}" 
                                   class="btn-action btn-toggle">
                                    <c:out value="${c.status == 'disabled' ? 'Bật' : 'Tắt'}"/>
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </body>
</html>