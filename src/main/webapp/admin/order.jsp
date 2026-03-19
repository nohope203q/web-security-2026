<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Quản lý đơn hàng</title>
        <link rel="stylesheet" href="<%= request.getContextPath()%>/admin/styles/main.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    </head>
    <body>
        <%@ include file="includes/sidebar.jsp" %>

        <div class="main">
            <h1><i class="fa-solid fa-receipt"></i> Quản lý đơn hàng</h1>
            <p>Danh sách các đơn hàng của khách hàng, có thể xem chi tiết, chỉnh sửa hoặc xóa.</p>

            <table>
                <thead>
                    <tr>
                        <th>Mã đơn hàng</th>
                        <th>Khách hàng</th>
                        <th>Ngày đặt</th>
                        <th>Tổng tiền</th>
                        <th>Trạng thái</th>
                        <th>Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="o" items="${orders}">
                        <tr>
                            <td>#${o.id}</td>
                            <td>${o.user.name}</td>
                            <td><fmt:formatDate value="${o.dateOrder}" pattern="yyyy-MM-dd" /></td>

                            <td>
                                <c:set var="total" value="0" />
                                <c:forEach var="item" items="${o.orderItems}">
                                    <c:set var="total" value="${o.getFinalAmount()}" />
                                </c:forEach>
                                <fmt:formatNumber value="${total}" type="currency" currencySymbol="₫"/>
                            </td>

                            <td>
                                <c:choose>
                                    <c:when test="${o.status == 0}">
                                        <span class="status pending">Chờ xác nhận</span>
                                    </c:when>
                                    <c:when test="${o.status == 1}">
                                        <span class="status success">Đang vận chuyển</span>
                                    </c:when>
                                    <c:when test="${o.status == 2}">
                                        <span class="status success">Đang giao hàng</span>
                                    </c:when>
                                    <c:when test="${o.status == 3}">
                                        <span class="status success">Hoàn thành</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="status cancelled">Đã hủy</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>

                            <td>
                                <a href="${pageContext.request.contextPath}/admin/order?action=detail&id=${o.id}" class="btn btn-primary">
                                    <i class="fa-solid fa-eye"></i> Xem
                                </a>
                                <a href="${pageContext.request.contextPath}/admin/order?action=edit&id=${o.id}" class="btn btn-primary">
                                    <i class="fa-solid fa-pen"></i> Sửa
                                </a>
                                <a href="${pageContext.request.contextPath}/admin/order?action=delete&id=${o.id}" 
                                   class="btn btn-danger" 
                                   onclick="return confirm('Xóa đơn hàng này?')">
                                    <i class="fa-solid fa-trash"></i> Xóa
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </body>
</html>
