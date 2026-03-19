<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>${empty coupon.id ? 'Thêm' : 'Sửa'} mã giảm giá</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <link rel="stylesheet" href="<%= request.getContextPath() %>/admin/styles/main.css">
        <style>
            /* Rút gọn khoảng cách cho form-card */
            .form-card {
                gap: 10px;
                padding: 30px 40px;
            }
            .form-card label {
                display: block;
                margin-bottom: 4px;
            }
            .form-card input, .form-card select {
                margin-bottom: 8px;
            }
        </style>
    </head>
    <body>
        <%@ include file="includes/sidebar.jsp" %>
        <div class="main">
            <h2>${empty coupon.id ? 'Thêm' : 'Sửa'} mã giảm giá</h2>

            <c:if test="${not empty errors}">
                <ul style="color:#c0392b; margin:10px 0 18px; padding-left:18px;">
                    <c:forEach var="e" items="${errors}"><li>${e}</li></c:forEach>
                    </ul>
            </c:if>

            <form class="form-card" method="post" action="<c:url value='/admin/coupons'/>">
                <c:if test="${not empty coupon.id}">
                    <input type="hidden" name="id" value="${coupon.id}">
                </c:if>

                <label>Mã:</label>
                <input type="text" name="code" required value="${coupon.code}" placeholder="SUPERSALE2025">

                <label>Loại:</label>
                <select name="type">
                    <option value="PERCENT" ${coupon.type=='PERCENT'?'selected':''}>Phần trăm (%)</option>
                    <option value="FIXED" ${coupon.type=='FIXED'?'selected':''}>Số tiền (VND)</option>
                </select>

                <label>Giá trị:</label>
                <input type="number" step="0.01" name="value" required value="${coupon.value}">

                <label>Đơn tối thiểu:</label>
                <input type="number" step="0.01" name="minOrder" value="${coupon.minOrder}">

                <label>Giảm tối đa (áp dụng cho %):</label>
                <input type="number" step="0.01" name="maxDiscount" value="${coupon.maxDiscount}">

                <label>Giới hạn lượt dùng (để trống = không giới hạn):</label>
                <input type="number" name="usageLimit" value="${coupon.usageLimit}">

                <label>Ngày bắt đầu:</label>
                <input type="date" name="startDate" required value="${coupon.startDate}">

                <label>Ngày kết thúc:</label>
                <input type="date" name="endDate" required value="${coupon.endDate}">

                <div class="form-actions">
                    <button type="submit" class="btn btn-primary">Lưu</button>
                    <a class="btn" href="<c:url value='/admin/coupons'/>">Hủy</a>
                </div>
            </form>
        </div>
    </body>
</html>
