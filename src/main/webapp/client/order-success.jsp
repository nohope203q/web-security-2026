<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Đặt hàng thành công</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/client/css/style-1.css">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet"/>
    </head>
    <body>

        <div class="container">
            <div class="success-container">
                <div class="success-icon">
                    <i class="fas fa-check"></i>
                </div>
                <h1>Đặt hàng thành công! 🎉</h1>
                <p>Cảm ơn bạn đã mua hàng. Chúng tôi sẽ xử lý đơn hàng của bạn sớm nhất có thể.</p>

                <c:if test="${not empty sessionScope.latestOrder}">
                    <div class="order-details">
                        <h3>Thông tin đơn hàng</h3>
                        <p><strong>Mã đơn hàng:</strong> #${sessionScope.latestOrder.id}</p>

                        <%-- THÊM DÒNG NÀY ĐỂ HIỂN THỊ MÃ HÓA ĐƠN --%>
                        <p><strong>Mã hoá đơn:</strong> INV-${sessionScope.latestInvoice.id}</p>

                        <p><strong>Địa chỉ giao hàng:</strong> ${sessionScope.latestOrder.shippingAddress}</p>
                        <p><strong>Phương thức thanh toán:</strong> ${sessionScope.latestOrder.paymentMethod}</p>
                    </div>
                </c:if>

                <a href="${pageContext.request.contextPath}/home" class="btn btn-primary">Tiếp tục mua sắm</a>
                <a href="${pageContext.request.contextPath}/client/order-tracking.jsp" class="btn btn-secondary">Xem đơn hàng</a>

                <%-- (Nâng cao) Bạn có thể thêm nút tải hóa đơn ở đây trong tương lai --%>
                <%-- <a href="${pageContext.request.contextPath}/client/download-invoice?id=${sessionScope.latestInvoice.id}" class="btn btn-info">Tải hoá đơn PDF</a> --%>
            </div>
        </div>
    </body>
</html>