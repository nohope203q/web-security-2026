<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý Bình luận</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/admin/styles/main.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        body { font-family: 'Segoe UI', sans-serif; background-color: #f0f2f5; margin: 0; display: flex; }
        .main { flex-grow: 1; padding: 2.5rem; }
        h1 { color: #1a2a4b; border-bottom: 2px solid #e0e0e0; padding-bottom: 0.5rem; margin-bottom: 2rem; font-size: 2rem; }
        .filter-container { background-color: #fff; padding: 2rem; border-radius: 12px; box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08); margin-bottom: 2.5rem; display: flex; align-items: center; gap: 15px; flex-wrap: wrap; }
        .filter-container select { padding: 0.8rem 1rem; border: 1px solid #d1d9e6; border-radius: 8px; font-size: 1rem; flex-grow: 1; min-width: 250px; }
        .btn { display: inline-flex; align-items: center; padding: 0.8rem 1.5rem; border: none; border-radius: 8px; font-size: 1rem; cursor: pointer; text-decoration: none; transition: all 0.3s; color: #fff; font-weight: 500; white-space: nowrap; }
        .btn i { margin-right: 8px; }
        .btn-primary { background-color: #007bff; }
        .btn-danger { background-color: #dc3545; }
        .btn-warning { background-color: #ffc107; color: #212529; }
        .btn-secondary { background-color: #6c757d; }
        table { width: 100%; border-collapse: separate; border-spacing: 0; background-color: #fff; border-radius: 12px; box-shadow: 0 4px 12px rgba(0,0,0,0.08); overflow: hidden; }
        th, td { padding: 1.2rem 1.5rem; text-align: left; border-bottom: 1px solid #e0e0e0; }
        th { background-color: #f8f9fa; font-weight: bold; color: #555; text-transform: uppercase; }
        tr:hover { background-color: #f5f5f5; }
        .rating { color: #ffc107; }
        .status-verified { color: #28a745; font-weight: bold; }
        .status-unverified { color: #6c757d; font-weight: bold; }
        .no-reviews { text-align: center; padding: 3rem; font-size: 1.2rem; color: #6c757d; }
        .comment-cell { max-width: 350px; word-wrap: break-word; }
    </style>
</head>
<body>
    <jsp:include page="includes/sidebar.jsp" />

    <div class="main">
        <h1>
            <c:choose>
                <c:when test="${viewMode == 'profane'}">
                    <i class="fa-solid fa-triangle-exclamation"></i> Bình luận Chứa Từ ngữ Khiếm nhã
                </c:when>
                <c:otherwise>
                    <i class="fa-solid fa-comments"></i> Quản lý Bình luận
                </c:otherwise>
            </c:choose>
        </h1>

        <div class="filter-container">
            <form action="${pageContext.request.contextPath}/admin/review" method="get" style="display: flex; flex-grow: 1; gap: 15px;">
                <c:if test="${viewMode == 'profane'}">
                    <input type="hidden" name="action" value="view_profane">
                </c:if>
                <select name="productId" onchange="this.form.submit()">
                    <option value="">-- Lọc theo tất cả sản phẩm --</option>
                    <c:forEach var="p" items="${products}">
                        <option value="${p.id}" ${p.id == selectedProductId ? 'selected' : ''}><c:out value="${p.name}"/></option>
                    </c:forEach>
                </select>
            </form>

            <c:choose>
                <c:when test="${viewMode == 'profane'}">
                    <a href="${pageContext.request.contextPath}/admin/review" class="btn btn-secondary">
                        <i class="fa-solid fa-eye"></i> Xem bình luận thường
                    </a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/admin/review?action=view_profane" class="btn btn-warning">
                        <i class="fa-solid fa-eye-slash"></i> Xem bình luận khiếm nhã
                    </a>
                </c:otherwise>
            </c:choose>
        </div>

        <table>
            <thead>
                <tr>
                    <th>Người dùng</th>
                    <th>Sản phẩm</th>
                    <th>Đánh giá</th>
                    <th>Trạng thái</th>
                    <th>Nội dung</th>
                    <th>Ngày tạo</th>
                    <th>Hành động</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty reviews}">
                        <c:forEach var="r" items="${reviews}">
                            <tr>
                                <td><strong><c:out value="${r.user.name}"/></strong></td>
                                <td><c:out value="${r.product.name}"/></td>
                                <td class="rating">${r.rating} <i class="fa-solid fa-star"></i></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${r.verified}"><span class="status-verified">Đã mua hàng</span></c:when>
                                        <c:otherwise><span class="status-unverified">Chưa mua hàng</span></c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="comment-cell"><c:out value="${r.comment}"/></td>
                                <td><fmt:formatDate value="${r.createdAt}" pattern="HH:mm, dd/MM/yyyy" /></td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/admin/review?action=delete&id=${r.id}&_csrf=${csrfToken}"
                                       class="btn btn-danger"
                                       onclick="return confirm('Xác nhận xóa bình luận này?')">
                                        <i class="fa-solid fa-trash"></i> Xóa
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="7" class="no-reviews">Không tìm thấy bình luận nào.</td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>
</body>
</html>