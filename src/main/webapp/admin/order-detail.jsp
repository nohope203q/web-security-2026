<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Chi tiết đơn hàng</title>
        <link rel="stylesheet" href="<%= request.getContextPath()%>/admin/styles/main.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    </head>
    <body>

        <%@ include file="includes/sidebar.jsp" %>

        <div class="main">
            <h1>Chi tiết đơn hàng #${order.id}</h1>
            <p>Khách hàng: <strong>${order.user.name}</strong></p>
            <p>Địa chỉ giao hàng: ${order.shippingAddress}</p>
            <p>Phương thức thanh toán: ${order.paymentMethod}</p>
            <p>Ngày đặt: <fmt:formatDate value="${order.dateOrder}" pattern="yyyy-MM-dd"/></p>

            <h2>Danh sách sản phẩm</h2>
            <table>
                <thead>
                    <tr>
                        <th>Tên sản phẩm</th>
                        <th>Số lượng</th>
                        <th>Giá</th>
                        <th>Thành tiền</th>
                    </tr>
                </thead>
                <tbody>
                    <c:set var="total" value="0" />
                    <c:forEach var="item" items="${order.orderItems}">
                        <tr>
                            <td>${item.product.name}</td>
                            <td>${item.quantity}</td>
                            <td><fmt:formatNumber value="${item.product.price}" type="currency" currencySymbol="₫"/></td>
                            <td><fmt:formatNumber value="${item.product.price * item.quantity}" type="currency" currencySymbol="₫"/></td>
                        </tr>
                        <c:set var="total" value="${total + (item.product.price * item.quantity)}" />
                    </c:forEach>
                </tbody>
            </table>

            <h3>Tổng cộng: <fmt:formatNumber value="${total}" type="currency" currencySymbol="₫"/></h3>

            <a href="${pageContext.request.contextPath}/admin/order" class="btn">← Quay lại danh sách</a>
        </div>

    </body>
</html>
