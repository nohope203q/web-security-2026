<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
    <link rel="stylesheet" href="<c:url value='/admin/styles/main.css'/>">
    <style>
        body { font-family: 'Segoe UI', sans-serif; background-color: #f0f2f5; margin: 0; display: flex; }
        .main { flex-grow: 1; padding: 2.5rem; }
        .form-card { background: #fff; padding: 2rem; border-radius: 12px; box-shadow: 0 4px 12px rgba(0,0,0,0.1); max-width: 800px; margin: 0 auto; }
        h2 { color: #1a2a4b; margin-bottom: 2rem; border-bottom: 2px solid #eee; padding-bottom: 10px; }
        label { display: block; margin-bottom: 8px; font-weight: 600; color: #444; }
        input[type="text"], input[type="date"], textarea, select {
            width: 100%; padding: 12px; margin-bottom: 20px; border: 1px solid #ddd; border-radius: 8px; box-sizing: border-box; font-size: 1rem;
        }
        textarea { resize: vertical; }
        .error-msg { background: #fee2e2; color: #dc2626; padding: 12px; border-radius: 8px; margin-bottom: 20px; border-left: 4px solid #dc2626; }
        .form-actions { display: flex; gap: 15px; margin-top: 10px; }
        .btn { padding: 12px 25px; border-radius: 8px; text-decoration: none; font-weight: 500; cursor: pointer; border: none; font-size: 1rem; transition: 0.3s; }
        .btn-primary { background-color: #2563eb; color: white; }
        .btn-primary:hover { background-color: #1d4ed8; }
        .btn-secondary { background-color: #e5e7eb; color: #374151; }
        .btn-secondary:hover { background-color: #d1d5db; }
    </style>
</head>
<body>
    <jsp:include page="includes/sidebar.jsp" />

    <div class="main">
        <div class="form-card">
            <h2>
                <i class="fa-solid fa-bullhorn"></i>
                <c:choose>
                    <c:when test="${not empty announcements}">Cập nhật thông báo</c:when>
                    <c:otherwise>Tạo thông báo khuyến mãi</c:otherwise>
                </c:choose>
            </h2>

            <form action="${pageContext.request.contextPath}/admin/announcements" method="post">
                <input type="hidden" name="_csrf" value="${sessionScope.csrfToken}">
                <c:choose>
                    <c:when test="${not empty announcements}">
                        <input type="hidden" name="id" value="${announcements.id}">
                        <input type="hidden" name="action" value="update">
                    </c:when>
                    <c:otherwise>
                        <input type="hidden" name="action" value="insert">
                    </c:otherwise>
                </c:choose>

                <label>Tiêu đề</label>
                <input type="text" name="title" required value="<c:out value='${announcements.title}'/>" placeholder="Nhập tiêu đề thông báo...">

                <label>Nội dung</label>
                <textarea name="content" rows="5" required placeholder="Nhập nội dung chi tiết..."><c:out value="${announcements.content}"/></textarea>

                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px;">
                    <div>
                        <label>Ngày bắt đầu</label>
                        <input type="date" name="startDate" required value="${announcements.startDate}">
                    </div>
                    <div>
                        <label>Ngày kết thúc</label>
                        <input type="date" name="endDate" required value="${announcements.endDate}">
                    </div>
                </div>

                <c:if test="${not empty error}">
                    <div class="error-msg">
                        <i class="fa-solid fa-circle-exclamation"></i> <c:out value="${error}"/>
                    </div>
                </c:if>

                <c:if test="${not empty announcements}">
                    <label>Trạng thái</label>
                    <select name="status">
                        <option value="active"    ${announcements.status == 'active'    ? 'selected' : ''}>Đang chạy</option>
                        <option value="scheduled" ${announcements.status == 'scheduled' ? 'selected' : ''}>Lên lịch</option>
                        <option value="expired"   ${announcements.status == 'expired'   ? 'selected' : ''}>Hết hạn</option>
                        <option value="draft"     ${announcements.status == 'draft'     ? 'selected' : ''}>Nháp</option>
                    </select>
                </c:if>

                <div class="form-actions">
                    <button type="submit" class="btn btn-primary">
                        <i class="fa-solid fa-floppy-disk"></i>
                        <c:choose>
                            <c:when test="${not empty announcements}"> Cập nhật</c:when>
                            <c:otherwise> Lưu thông báo</c:otherwise>
                        </c:choose>
                    </button>
                    <a class="btn btn-secondary" href="<c:url value='/admin/announcements'/>">Hủy bỏ</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>