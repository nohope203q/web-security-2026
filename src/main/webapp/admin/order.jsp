<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý đơn hàng</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/admin/styles/main.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        body { font-family: 'Segoe UI', sans-serif; background-color: #f0f2f5; margin: 0; display: flex; }
        .main { flex-grow: 1; padding: 2.5rem; }
        h1 { color: #1a2a4b; margin-bottom: 0.5rem; }
        .description { color: #666; margin-bottom: 2rem; }
        table { width: 100%; border-collapse: separate; border-spacing: 0; background: #fff; border-radius: 12px; overflow: hidden; box-shadow: 0 4px 12px rgba(0,0,0,0.08); }
        th, td { padding: 1.2rem; text-align: left; border-bottom: 1px solid #eee; }
        th { background: #f8f9fa; color: #555; text-transform: uppercase; font-size: 0.85rem; font-weight: bold; }
        tr:hover { background-color: #f9f9f9; }
        .status { padding: 6px 12px; border-radius: 20px; font-size: 12px; font-weight: bold; display: inline-block; }
        .status.pending { background: #fff4e5; color: #ff9800; }
        .status.success { background: #e7f7ed; color: #28a745; }
        .status.cancelled { background: #ffebee; color: #f44336; }
        .btn { padding: 8px 12px; border-radius: 6px; text-decoration: none; font-size: 13px; display: inline-flex; align-items: center; gap: 5px; transition: 0.2s; margin-right: 4px; border: none; cursor: pointer; color: white; }
        .btn-primary { background: #007bff; }
        .btn-danger { background: #dc3545; }
        .btn:hover { opacity: 0.85; transform: translateY(-1px); }
    </style>
</head>
<body>
    <jsp:include page="includes/sidebar.jsp" />

    <div class="main">
        <h1><i class="fa-solid fa-receipt"></i> Quản lý đơn hàng</h1>
        <p class="description">Danh sách các đơn hàng của khách hàng, có thể xem chi tiết, chỉnh sửa hoặc xóa.</p>

        <table>
            <thead>
                <tr>
                    <th>Mã đơn</th>
                    <th>Khách hàng</th>
                    <th>Ngày đặt</th>
                    <th>Tổng tiền</th>
                    <th>Trạng thái</th>
                    <th>Thao tác</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty orders}">
                        <c:forEach var="o" items="${orders}">
                            <tr>
                                <td><strong>#${o.id}</strong></td>
                                <td><strong><c:out value="${o.user.name}"/></strong></td>
                                <td><fmt:formatDate value="${o.dateOrder}" pattern="dd/MM/yyyy" /></td>
                                <td style="color: #d9534f; font-weight: bold;">
                                    <fmt:formatNumber value="${o.getFinalAmount()}" type="currency" currencySymbol="₫"/>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${o.status == 0}"><span class="status pending">Chờ xác nhận</span></c:when>
                                        <c:when test="${o.status == 1}"><span class="status success">Đang vận chuyển</span></c:when>
                                        <c:when test="${o.status == 2}"><span class="status success">Đang giao hàng</span></c:when>
                                        <c:when test="${o.status == 3}"><span class="status success">Hoàn thành</span></c:when>
                                        <c:otherwise><span class="status cancelled">Đã hủy</span></c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/admin/order?action=detail&id=${o.id}" class="btn btn-primary" title="Xem">
                                        <i class="fa-solid fa-eye"></i>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/admin/order?action=edit&id=${o.id}" class="btn btn-primary" title="Sửa">
                                        <i class="fa-solid fa-pen"></i>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/admin/order?action=delete&id=${o.id}&_csrf=${csrfToken}" 
                                       class="btn btn-danger" 
                                       title="Xóa"
                                       onclick="return confirm('Xác nhận xóa đơn hàng #${o.id}?')">
                                        <i class="fa-solid fa-trash"></i>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="6" style="text-align: center; padding: 40px; color: #888;">Không có đơn hàng nào.</td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>
</body>
</html>