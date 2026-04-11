<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chỉnh sửa đơn hàng</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/admin/styles/main.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        body { font-family: 'Segoe UI', sans-serif; background-color: #f0f2f5; margin: 0; display: flex; }
        .main { flex-grow: 1; padding: 2.5rem; }
        .form-card { background: #fff; padding: 2rem; border-radius: 12px; box-shadow: 0 4px 12px rgba(0,0,0,0.1); max-width: 700px; margin: 0 auto; }
        .form-group { margin-bottom: 1.5rem; }
        .form-group label { display: block; margin-bottom: 8px; font-weight: 600; color: #444; }
        .form-group input, .form-group select { width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 8px; font-size: 1rem; box-sizing: border-box; }
        .form-group input:disabled { background-color: #f8f9fa; color: #6c757d; cursor: not-allowed; }
        .btn-group { display: flex; gap: 10px; margin-top: 2rem; }
        .btn { padding: 12px 25px; border-radius: 8px; text-decoration: none; font-weight: 500; cursor: pointer; border: none; display: inline-flex; align-items: center; gap: 8px; transition: 0.3s; }
        .btn-success { background-color: #28a745; color: white; }
        .btn-secondary { background-color: #6c757d; color: white; }
        .btn:hover { opacity: 0.9; transform: translateY(-1px); }
    </style>
</head>
<body>
    <jsp:include page="includes/sidebar.jsp" />

    <div class="main">
        <div class="form-card">
            <h1><i class="fa-solid fa-pen-to-square"></i> Chỉnh sửa đơn hàng #<c:out value="${order.id}"/></h1>

            <form action="${pageContext.request.contextPath}/admin/order?action=update" method="post">
                <input type="hidden" name="_csrf" value="${csrfToken}">
                <input type="hidden" name="id" value="${order.id}">

                <div class="form-group">
                    <label><i class="fa-regular fa-calendar"></i> Ngày đặt:</label>
                    <input type="text" value="<fmt:formatDate value='${order.dateOrder}' pattern='dd/MM/yyyy HH:mm' />" disabled>
                </div>

                <div class="form-group">
                    <label><i class="fa-solid fa-location-dot"></i> Địa chỉ giao hàng:</label>
                    <input type="text" name="shippingAddress" value="<c:out value='${order.shippingAddress}'/>" required>
                </div>

                <div class="form-group">
                    <label><i class="fa-solid fa-credit-card"></i> Phương thức thanh toán:</label>
                    <input type="text" name="paymentMethod" value="<c:out value='${order.paymentMethod}'/>" required>
                </div>

                <div class="form-group">
                    <label><i class="fa-solid fa-spinner"></i> Trạng thái đơn hàng:</label>
                    <select name="status">
                        <option value="0" ${order.status == 0 ? 'selected' : ''}>Chờ xác nhận</option>
                        <option value="1" ${order.status == 1 ? 'selected' : ''}>Đang vận chuyển</option>
                        <option value="2" ${order.status == 2 ? 'selected' : ''}>Đang giao hàng</option>
                        <option value="3" ${order.status == 3 ? 'selected' : ''}>Hoàn thành</option>
                        <option value="4" ${order.status == 4 ? 'selected' : ''}>Đã hủy</option>
                    </select>
                </div>

                <div class="btn-group">
                    <button type="submit" class="btn btn-success">
                        <i class="fa-solid fa-save"></i> Lưu thay đổi
                    </button>
                    <a href="${pageContext.request.contextPath}/admin/order" class="btn btn-secondary">
                        <i class="fa-solid fa-arrow-left"></i> Quay lại
                    </a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>