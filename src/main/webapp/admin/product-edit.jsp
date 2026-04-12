<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>
        <c:choose>
            <c:when test="${empty product.id}">Thêm sản phẩm mới</c:when>
            <c:otherwise>Chỉnh sửa sản phẩm #${product.id}</c:otherwise>
        </c:choose>
    </title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/admin/styles/main.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        body { font-family: 'Segoe UI', sans-serif; background-color: #f0f2f5; margin: 0; display: flex; }
        .main { flex-grow: 1; padding: 2.5rem; }
        .form-card { background: #fff; padding: 2.5rem; border-radius: 12px; box-shadow: 0 4px 12px rgba(0,0,0,0.1); max-width: 800px; margin: 0 auto; }
        h1 { color: #1a2a4b; margin-bottom: 2rem; border-bottom: 2px solid #eee; padding-bottom: 10px; }
        .form-group { margin-bottom: 1.5rem; }
        .form-group label { display: block; margin-bottom: 8px; font-weight: 600; color: #444; }
        .form-group input, .form-group textarea, .form-group select { 
            width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 8px; font-size: 1rem; box-sizing: border-box;
        }
        .btn { padding: 12px 25px; border-radius: 8px; text-decoration: none; font-weight: 500; cursor: pointer; border: none; display: inline-flex; align-items: center; gap: 8px; transition: 0.3s; }
        .btn-primary { background-color: #007bff; color: white; }
        .btn-success { background-color: #28a745; color: white; }
        .btn-secondary { background-color: #6c757d; color: white; }
        .btn:hover { opacity: 0.9; transform: translateY(-1px); }
        .preview-img { margin-top: 10px; object-fit: cover; border-radius: 8px; border: 1px solid #ddd; }
    </style>
</head>
<body>
    <jsp:include page="includes/sidebar.jsp" />

    <div class="main">
        <div class="form-card">
            <h1>       
                <c:choose>
                    <c:when test="${empty product.id}">
                        <i class="fa-solid fa-plus"></i> Thêm sản phẩm mới
                    </c:when>
                    <c:otherwise>
                        <i class="fa-solid fa-pen"></i> Chỉnh sửa sản phẩm #<c:out value="${product.id}"/>
                    </c:otherwise>
                </c:choose>
            </h1>

            <form action="${pageContext.request.contextPath}/admin/product" method="post">
                <input type="hidden" name="_csrf" value="${csrfToken}">
                <input type="hidden" name="action" value="${empty product.id ? 'add' : 'update'}" />
                
                <c:if test="${not empty product.id}">
                    <input type="hidden" name="id" value="${product.id}" />
                </c:if>

                <div class="form-group">
                    <label><i class="fa-solid fa-box"></i> Tên sản phẩm:</label>
                    <input type="text" name="name" value="<c:out value='${product.name}'/>" required />
                </div>

                <div class="form-group">
                    <label><i class="fa-solid fa-align-left"></i> Mô tả:</label>
                    <textarea name="description" rows="3"><c:out value="${product.description}"/></textarea>
                </div>

                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px;">
                    <div class="form-group">
                        <label><i class="fa-solid fa-industry"></i> Thương hiệu:</label>
                        <input type="text" name="brand" value="<c:out value='${product.brand}'/>" />
                    </div>

                    <div class="form-group">
                        <label><i class="fa-solid fa-layer-group"></i> Danh mục:</label>
                        <select name="categoryId" required>
                            <c:forEach var="c" items="${categories}">
                                <option value="${c.id}" ${product.category != null && c.id == product.category.id ? 'selected' : ''}>
                                    <c:out value="${c.name}"/>
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                </div>

                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px;">
                    <div class="form-group">
                        <label><i class="fa-solid fa-palette"></i> Màu sắc:</label>
                        <input type="text" name="color" value="<c:out value='${product.color}'/>" />
                    </div>
                    <div class="form-group">
                        <label><i class="fa-solid fa-dollar-sign"></i> Giá (VNĐ):</label>
                        <input type="number" step="0.01" name="price" value="${product.price != null ? product.price : 0}" required />
                    </div>
                </div>

                <div class="form-group">
                    <label><i class="fa-solid fa-image"></i> Ảnh sản phẩm (URL):</label>
                    <input type="text" name="image" value="<c:out value='${product.image}'/>" placeholder="Ví dụ: /images/san-pham-1.jpg" />
                    <c:if test="${not empty product.image}">
                        <img src="<c:out value='${product.image}'/>" width="120" height="120" class="preview-img">
                    </c:if>
                </div>

                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px;">
                    <div class="form-group">
                        <label><i class="fa-solid fa-cubes"></i> Số lượng kho:</label>
                        <input type="number" name="quantity" value="${product.quantity != null ? product.quantity : 0}" required />
                    </div>
                    <div class="form-group">
                        <label><i class="fa-solid fa-cart-shopping"></i> Đã bán:</label>
                        <input type="number" name="sold" value="${product.sold != null ? product.sold : 0}" />
                    </div>
                </div>

                <div class="btn-group" style="margin-top: 20px; display: flex; gap: 10px;">
                    <c:choose>
                        <c:when test="${empty product.id}">
                            <button type="submit" class="btn btn-primary">
                                <i class="fa-solid fa-plus"></i> Thêm sản phẩm
                            </button>
                        </c:when>
                        <c:otherwise>
                            <button type="submit" class="btn btn-success">
                                <i class="fa-solid fa-save"></i> Lưu thay đổi
                            </button>
                        </c:otherwise>
                    </c:choose>

                    <a href="${pageContext.request.contextPath}/admin/product" class="btn btn-secondary">
                        <i class="fa-solid fa-arrow-left"></i> Quay lại
                    </a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>