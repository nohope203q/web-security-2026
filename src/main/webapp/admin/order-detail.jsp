<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết đơn hàng</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/admin/styles/main.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        body { font-family: 'Segoe UI', sans-serif; background-color: #f0f2f5; margin: 0; display: flex; }
        .main { flex-grow: 1; padding: 2.5rem; }
        .order-container { display: grid; grid-template-columns: 1fr 350px; gap: 25px; }
        .card { background: #fff; padding: 20px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); margin-bottom: 25px; }
        table { width: 100%; border-collapse: collapse; }
        th, td { padding: 15px; text-align: left; border-bottom: 1px solid #eee; }
        th { background-color: #f8f9fa; color: #555; text-transform: uppercase; font-size: 0.85rem; }
        .total-section { text-align: right; margin-top: 20px; font-size: 1.5rem; color: #d9534f; }
        .status-select { padding: 10px; border-radius: 5px; border: 1px solid #ccc; width: 100%; margin-top: 10px; }
        .btn { display: inline-block; padding: 10px 20px; border-radius: 5px; text-decoration: none; font-weight: 500; cursor: pointer; border: none; }
        .btn-secondary { background: #6c757d; color: #fff; }
        .btn-primary { background: #007bff; color: #fff; width: 100%; margin-top: 10px; }
    </style>
</head>
<body>

    <jsp:include page="includes/sidebar.jsp" />

    <div class="main">
        <h1>Chi tiết đơn hàng #<c:out value="${order.id}"/></h1>

        <div class="order-container">
            <div class="left-col">
                <div class="card">
                    <h2>Danh sách sản phẩm</h2>
                    <table>
                        <thead>
                            <tr>
                                <th>Sản phẩm</th>
                                <th>Số lượng</th>
                                <th>Giá</th>
                                <th>Thành tiền</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:set var="total" value="0" />
                            <c:forEach var="item" items="${order.orderItems}">
                                <tr>
                                    <td><strong><c:out value="${item.product.name}"/></strong></td>
                                    <td>${item.quantity}</td>
                                    <td><fmt:formatNumber value="${item.product.price}" type="currency" currencySymbol="₫"/></td>
                                    <td><fmt:formatNumber value="${item.product.price * item.quantity}" type="currency" currencySymbol="₫"/></td>
                                </tr>
                                <c:set var="total" value="${total + (item.product.price * item.quantity)}" />
                            </c:forEach>
                        </tbody>
                    </table>
                    <div class="total-section">
                        <strong>Tổng cộng: <fmt:formatNumber value="${total}" type="currency" currencySymbol="₫"/></strong>
                    </div>
                </div>
            </div>

            <div class="right-col">
                <div class="card">
                    <h3><i class="fa-solid fa-circle-info"></i> Thông tin chung</h3>
                    <p>Khách hàng: <strong><c:out value="${order.user.name}"/></strong></p>
                    <p>Địa chỉ: <c:out value="${order.shippingAddress}"/></p>
                    <p>Thanh toán: <c:out value="${order.paymentMethod}"/></p>
                    <p>Ngày đặt: <fmt:formatDate value="${order.dateOrder}" pattern="dd/MM/yyyy HH:mm"/></p>
                </div>

                <div class="card">
                    <h3><i class="fa-solid fa-truck"></i> Trạng thái đơn hàng</h3>
                    <form action="${pageContext.request.contextPath}/admin/order" method="post">
                        <input type="hidden" name="_csrf" value="${csrfToken}">
                        <input type="hidden" name="action" value="updateStatus">
                        <input type="hidden" name="orderId" value="${order.id}">
                        
                        <select name="status" class="status-select">
                            <option value="PENDING" ${order.status == 'PENDING' ? 'selected' : ''}>Chờ xử lý</option>
                            <option value="SHIPPING" ${order.status == 'SHIPPING' ? 'selected' : ''}>Đang giao hàng</option>
                            <option value="DELIVERED" ${order.status == 'DELIVERED' ? 'selected' : ''}>Đã giao hàng</option>
                            <option value="CANCELLED" ${order.status == 'CANCELLED' ? 'selected' : ''}>Đã hủy</option>
                        </select>
                        <button type="submit" class="btn btn-primary">Cập nhật trạng thái</button>
                    </form>
                </div>
            </div>
        </div>

        <a href="${pageContext.request.contextPath}/admin/order" class="btn btn-secondary">
            <i class="fa-solid fa-arrow-left"></i> Quay lại danh sách
        </a>
    </div>

</body>
</html>