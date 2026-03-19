<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Chỉnh sửa đơn hàng</title>
        <link rel="stylesheet" href="<%= request.getContextPath() %>/admin/styles/main.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    </head>
    <body>
        <%@ include file="includes/sidebar.jsp" %>

        <div class="main">
            <h1><i class="fa-solid fa-pen"></i> Chỉnh sửa đơn hàng #${order.id}</h1>

            <form action="${pageContext.request.contextPath}/admin/order?action=update" method="post">
                <input type="hidden" name="id" value="${order.id}">

                <div class="form-group">
                    <label><i class="fa-regular fa-calendar"></i> Ngày đặt:</label>
                    <input type="text" 
                           value="<fmt:formatDate value='${order.dateOrder}' pattern='yyyy-MM-dd' />" 
                           disabled>
                </div>

                <div class="form-group">
                    <label><i class="fa-solid fa-location-dot"></i> Địa chỉ giao hàng:</label>
                    <input type="text" name="shippingAddress" 
                           value="${order.shippingAddress}" required>
                </div>

                <div class="form-group">
                    <label><i class="fa-solid fa-credit-card"></i> Phương thức thanh toán:</label>
                    <input type="text" name="paymentMethod" 
                           value="${order.paymentMethod}" required>
                </div>

                <div class="form-group">
                    <label><i class="fa-solid fa-spinner"></i> Trạng thái:</label>
                    <select name="status">
                        <option value="0" ${order.status == 0 ? 'selected' : ''}>Chờ xác nhận</option>
                        <option value="1" ${order.status == 1 ? 'selected' : ''}>Đang vận chuyển</option>
                        <option value="2" ${order.status == 2 ? 'selected' : ''}>Đang giao hàng</option>
                        <option value="3" ${order.status == 3 ? 'selected' : ''}>Hoàn thành</option>
                        <option value="4" ${order.status == 4 ? 'selected' : ''}>Đã hủy</option>
                    </select>
                </div>

                <div style="margin-top:20px;">
                    <button type="submit" class="btn btn-success">
                        <i class="fa-solid fa-save"></i> Lưu thay đổi
                    </button>
                    <a href="${pageContext.request.contextPath}/admin/order" class="btn">
                        <i class="fa-solid fa-arrow-left"></i> Quay lại
                    </a>
                </div>
            </form>
        </div>
    </body>
</html>
