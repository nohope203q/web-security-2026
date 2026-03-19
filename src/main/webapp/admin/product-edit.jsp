<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
        <link rel="stylesheet" href="<%= request.getContextPath() %>/admin/styles/main.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    </head>
    <body>
        <%@ include file="includes/sidebar.jsp" %>

        <div class="main">
            <h1>       
                <c:choose>
                    <c:when test="${empty product.id}">
                        <i class="fa-solid fa-plus"></i> Thêm sản phẩm mới
                    </c:when>
                    <c:otherwise>
                        <i class="fa-solid fa-pen"></i> Chỉnh sửa sản phẩm #${product.id}
                    </c:otherwise>
                </c:choose>
            </h1>

            <form action="${pageContext.request.contextPath}/admin/product" method="post" class="form-card">
                <!-- Ẩn action và id -->
                <input type="hidden" name="action" value="${empty product.id ? 'add' : 'update'}" />
                <c:if test="${not empty product.id}">
                    <input type="hidden" name="id" value="${product.id}" />
                </c:if>


                <div class="form-group">
                    <label><i class="fa-solid fa-box"></i> Tên sản phẩm:</label>
                    <input type="text" name="name" value="${product.name}" required />
                </div>

                <div class="form-group">
                    <label><i class="fa-solid fa-align-left"></i> Mô tả:</label>
                    <textarea name="description" rows="3">${product.description}</textarea>
                </div>

                <div class="form-group">
                    <label><i class="fa-solid fa-industry"></i> Thương hiệu:</label>
                    <input type="text" name="brand" value="${product.brand}" />
                </div>

                <div class="form-group">
                    <label><i class="fa-solid fa-layer-group"></i> Danh mục:</label>
                    <select name="categoryId" required>
                        <c:forEach var="c" items="${categories}">
                            <option value="${c.id}" ${product.category != null && c.id == product.category.id ? 'selected' : ''}>${c.name}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="form-group">
                    <label><i class="fa-solid fa-palette"></i> Màu:</label>
                    <input type="text" name="color" value="${product.color}" />
                </div>

                <div class="form-group">
                    <label><i class="fa-solid fa-image"></i> Ảnh (URL):</label>
                    <input type="text" name="image" value="${product.image}" placeholder="/images/sp1.jpg" />
                    <c:if test="${product.image != null}">
                        <img src="${product.image}" width="120" height="120" style="margin-top:10px;object-fit:cover;border-radius:8px;">
                    </c:if>
                </div>

                <div class="form-group">
                    <label><i class="fa-solid fa-dollar-sign"></i> Giá (VNĐ):</label>
                    <input type="number" step="0.01" name="price" value="<c:out value='${product.price}' default= '0'/>" required />
                </div>

                <div class="form-group">
                    <label><i class="fa-solid fa-cubes"></i> Số lượng:</label>
                    <input type="number" name="quantity" value="${product.quantity}" required />
                </div>

                <div class="form-group">
                    <label><i class="fa-solid fa-cart-shopping"></i> Đã bán:</label>
                    <input type="number" name="sold" value="${product.sold}" />
                </div>

                <div style="margin-top: 20px;">
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

                    <a href="${pageContext.request.contextPath}/admin/product" class="btn">
                        <i class="fa-solid fa-arrow-left"></i> Quay lại
                    </a>
                </div>
            </form>
        </div>
    </body>
</html>
