<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>
            <c:choose>
                <c:when test="${not empty announcements}">Cập nhật thông báo</c:when>
                <c:otherwise>Thêm thông báo khuyến mãi</c:otherwise>
            </c:choose>
        </title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <link rel="stylesheet" href="<c:url value='/admin/styles/main.css?v=3'/>">
    </head>
    <body>
        <%@ include file="includes/sidebar.jsp" %>

        <div class="main">
            <h2>
                <c:choose>
                    <c:when test="${not empty announcements}">Cập nhật thông báo</c:when>
                    <c:otherwise>Tạo thông báo khuyến mãi</c:otherwise>
                </c:choose>
            </h2>

            <!-- Dùng form-card để “ăn” style có sẵn -->
            <form class="form-card" action="${pageContext.request.contextPath}/admin/announcements" method="post">
                <!-- Edit -->
                <c:if test="${not empty announcements}">
                    <input type="hidden" name="id" value="${announcements.getId()}">
                    <input type="hidden" name="action" value="update">
                </c:if>
                <!-- Add -->
                <c:if test="${empty announcements}">
                    <input type="hidden" name="action" value="insert">
                </c:if>

                <label>Tiêu đề</label>
                <input type="text" name="title" required value="${announcements.getTitle()}">

                <label>Nội dung</label>
                <textarea name="content" rows="5" required>${announcements.getContent()}</textarea>

                <label>Ngày bắt đầu</label>
                <input type="date" name="startDate" required value="${announcements.getStartDate()}">

                <label>Ngày kết thúc</label>
                <input type="date" name="endDate" required value="${announcements.getEndDate()}">

                <c:if test="${not empty error}">
                    <div style="background:#ffe6e6;color:#b00020;padding:10px;border-radius:6px;margin:10px 0;">
                        ${error}
                    </div>
                </c:if>

                <c:if test="${not empty announcements}">
                    <label>Trạng thái</label>
                    <select name="status">
                        <option value="active"    ${announcements.getStatus() == 'active'    ? 'selected' : ''}>Đang chạy</option>
                        <option value="scheduled" ${announcements.getStatus() == 'scheduled' ? 'selected' : ''}>Lên lịch</option>
                        <option value="expired"   ${announcements.getStatus() == 'expired'   ? 'selected' : ''}>Hết hạn</option>
                        <option value="draft"     ${announcements.getStatus() == 'draft'     ? 'selected' : ''}>Nháp</option>
                    </select>
                </c:if>

                <div class="form-actions">
                    <button type="submit" class="btn btn-primary">
                        <c:choose>
                            <c:when test="${not empty announcements}">Cập nhật</c:when>
                            <c:otherwise>Lưu</c:otherwise>
                        </c:choose>
                    </button>
                    <a class="btn" href="<c:url value='/admin/announcements'/>">Hủy</a>
                </div>
            </form>
        </div>
    </body>
</html>
