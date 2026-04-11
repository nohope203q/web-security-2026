<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>
        <c:choose>
            <c:when test="${empty coupon.id}">Thêm mã giảm giá</c:when>
            <c:otherwise>Sửa mã giảm giá</c:otherwise>
        </c:choose>
    </title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/admin/styles/main.css">
    <style>
        body { font-family: 'Segoe UI', sans-serif; background-color: #f0f2f5; margin: 0; display: flex; }
        .main { flex-grow: 1; padding: 2.5rem; }
        .form-card { 
            background: #fff; padding: 30px 40px; border-radius: 12px; 
            box-shadow: 0 4px 12px rgba(0,0,0,0.1); max-width: 600px; margin: 0 auto; 
        }
        .form-card label { display: block; margin-bottom: 6px; font-weight: 600; color: #444; }
        .form-card input, .form-card select { 
            width: 100%; padding: 10px; margin-bottom: 15px; 
            border: 1px solid #ddd; border-radius: 8px; box-sizing: border-box; 
        }
        .error-list { color: #c0392b; background: #fdf2f2; border-left: 4px solid #c0392b; padding: 10px 20px; margin-bottom: 20px; list-style: none; border-radius: 4px; }
        .form-actions { display: flex; gap: 10px; margin-top: 10px; }
        .btn { padding: 10px 25px; border-radius: 8px; text-decoration: none; cursor: pointer; border: none; font-weight: 500; }
        .btn-primary { background: #2563eb; color: #fff; }
        .btn-secondary { background: #e5e7eb; color: #374151; }
    </style>
</head>
<body>
    <jsp:include page="includes/sidebar.jsp" />
    
    <div class="main">
        <div class="form-card">
            <h2>
                <i class="fa-solid fa-ticket"></i> 
                <c:out value="${empty coupon.id ? 'Thêm' : 'Sửa'}"/> mã giảm giá
            </h2>

            <c:if test="${not empty errors}">
                <ul class="error-list">
                    <c:forEach var="e" items="${errors}">
                        <li><i class="fa-solid fa-triangle-exclamation"></i> <c:out value="${e}"/></li>
                    </c:forEach>
                </ul>
            </c:if>

            <form method="post" action="${pageContext.request.contextPath}/admin/coupons">
                <input type="hidden" name="_csrf" value="${csrfToken}">
                
                <c:if test="${not empty coupon.id}">
                    <input type="hidden" name="id" value="${coupon.id}">
                </c:if>

                <label>Mã coupon:</label>
                <input type="text" name="code" required value="<c:out value='${coupon.code}'/>" placeholder="Ví dụ: SUPERSALE2025">

                <label>Loại giảm giá:</label>
                <select name="type">
                    <option value="PERCENT" ${coupon.type == 'PERCENT' ? 'selected' : ''}>Phần trăm (%)</option>
                    <option value="FIXED" ${coupon.type == 'FIXED' ? 'selected' : ''}>Số tiền cố định (VND)</option>
                </select>

                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 15px;">
                    <div>
                        <label>Giá trị giảm:</label>
                        <input type="number" step="0.01" name="value" required value="${coupon.value}">
                    </div>
                    <div>
                        <label>Đơn tối thiểu:</label>
                        <input type="number" step="0.01" name="minOrder" value="${coupon.minOrder}">
                    </div>
                </div>

                <label>Giảm tối đa (chỉ áp dụng cho loại %):</label>
                <input type="number" step="0.01" name="maxDiscount" value="${coupon.maxDiscount}">

                <label>Giới hạn lượt dùng (để trống nếu không giới hạn):</label>
                <input type="number" name="usageLimit" value="${coupon.usageLimit}">

                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 15px;">
                    <div>
                        <label>Ngày bắt đầu:</label>
                        <input type="date" name="startDate" required value="${coupon.startDate}">
                    </div>
                    <div>
                        <label>Ngày kết thúc:</label>
                        <input type="date" name="endDate" required value="${coupon.endDate}">
                    </div>
                </div>

                <div class="form-actions">
                    <button type="submit" class="btn btn-primary"><i class="fa-solid fa-floppy-disk"></i> Lưu mã</button>
                    <a class="btn btn-secondary" href="${pageContext.request.contextPath}/admin/coupons">Hủy</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>