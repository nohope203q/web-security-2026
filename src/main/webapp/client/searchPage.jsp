<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="header/header-search.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Search Results - Cua hang PC</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
        <style>
            body {
                padding-top: 50px;
                background-color: #f8f9fa;
            }
            .search-header {
                background: linear-gradient(135deg, #1e88e5 0%, #0d47a1 100%);
                color: white;
                padding: 2rem 0;
                margin-bottom: 2rem;
            }
            .filter-sidebar {
                background: white;
                border-radius: 10px;
                padding: 1.5rem;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            }
            .product-card {
                transition: all 0.3s ease;
                border: none;
                border-radius: 12px;
                overflow: hidden;
            }
            .product-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 10px 25px rgba(0,0,0,0.15);
            }
            .product-card .card-title {
                overflow: hidden;
                display: -webkit-box;
                -webkit-line-clamp: 2;
                -webkit-box-orient: vertical;
                min-height: 3rem;
                line-height: 1.5rem;
            }
            .search-box {
                max-width: 500px;
                margin: 0 auto;
            }
            .keyword-badge {
                background: #0040FF;
                color: #1976d2;
                border: 1px solid #bbdefb;
            }
        </style>
    </head>
    <body>

        <div class="search-header">
            <div class="container text-center">
                <h1 class="display-5 fw-bold">Search Results</h1>
                <c:if test="${not empty searchKeyword}">
                </c:if>
            </div>
        </div>

        <div class="container">
            <div class="row">
                <div class="col-lg-3 mb-4">
                    <div class="filter-sidebar">
                        <h5 class="fw-bold mb-3"><i class="fas fa-filter me-2"></i>Filters</h5>

                        <form action="${pageContext.request.contextPath}/client/search" method="get">
                            <c:if test="${not empty searchKeyword}">
                              <input type="hidden" name="txt" value="${fn:escapeXml(searchKeyword)}">
                            </c:if>

                            <div class="mb-3">
                                <label class="form-label fw-bold">Category</label>
                                <select name="category" class="form-select">
                                    <option value="">All Categories</option>
                                    <c:forEach var="cat" items="${listCC}">
                                        <option value="${cat.id}" ${param.category == cat.id ? 'selected' : ''}>
                                            ${cat.name}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="mb-3">
                                <label class="form-label fw-bold">Brand</label>
                                <select name="brand" class="form-select">
                                    <option value="">All Brands</option>
                                    <c:forEach var="brandItem" items="${brands}">
                                        <option value="${brandItem}" ${param.brand == brandItem ? 'selected' : ''}>
                                            ${brandItem}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="mb-3">
                                <label class="form-label fw-bold">Price Range</label>
                                <div class="row g-2">
                                    <div class="col-6">
                                        <input type="number" name="minPrice" value="${param.minPrice}" 
                                               class="form-control" placeholder="Min" min="0">
                                    </div>
                                    <div class="col-6">
                                        <input type="number" name="maxPrice" value="${param.maxPrice}" 
                                               class="form-control" placeholder="Max" min="0">
                                    </div>
                                </div>
                            </div>

                            <div class="d-grid gap-2">
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-filter me-1"></i> Apply Filters
                                </button>

                                <c:choose>
                                    <c:when test="${not empty searchKeyword}">
                                      <a href="${pageContext.request.contextPath}/client/search?txt=${fn:escapeXml(searchKeyword)}" class="btn btn-outline-secondary"> Clear Filters </a>
                                    </c:when>
                                    <c:otherwise>
                                      <a href="/client/search?txt=${fn:escapeXml(searchKeyword)}">
                                           class="btn btn-outline-secondary">
                                            Clear Filters
                                        </a>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </form>
                    </div>
                </div>

                <div class="col-lg-9">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <div>
                            <h5 class="text-primary">
                                <c:choose>
                                    <c:when test="${not empty param.category or not empty param.brand}">
                                        <i class="fas fa-filter me-2"></i>Filtered: 
                                    </c:when>

                                </c:choose>


                            </h5>

                            <c:if test="${not empty param.category or not empty param.brand or not empty param.minPrice or not empty param.maxPrice}">
                                <div class="mt-2">
                                    <small class="text-muted">Active filters:</small>
                                    <c:if test="${not empty param.category}">
                                        <span class="badge bg-info ms-2">
                                            Category: 
                                            <c:forEach var="cat" items="${listCC}">
                                                <c:if test="${cat.id == param.category}">${cat.name}</c:if>
                                            </c:forEach>
                                        </span>
                                    </c:if>
                                    <c:if test="${not empty param.brand}">
                              <span class="badge bg-info ms-2">Brand: ${fn:escapeXml(param.brand)}<input type="text" name="txt" value="${fn:escapeXml(searchKeyword)}" class="form-control">
                                    </c:if>
                                    <c:if test="${not empty param.minPrice}">
                                        <span class="badge bg-warning ms-2">Min: <fmt:formatNumber value="${param.minPrice}"/> VND</span>
                                    </c:if>
                                    <c:if test="${not empty param.maxPrice}">
                                        <span class="badge bg-warning ms-2">Max: <fmt:formatNumber value="${param.maxPrice}"/> VND</span>
                                    </c:if>
                                </div>
                            </c:if>
                        </div>
                    </div>

                    <c:choose>
                        <c:when test="${not empty listP}">
                            <div class="row">
                                <c:forEach var="i" items="${listP}">
                                    <div class="col-lg-4 col-md-6 mb-4">
                                        <div class="card h-100 product-card">
                                            <div class="bg-image hover-zoom">
                                                <img src="${fn:escapeXml(i.image)}" class="w-100" style="height: 200px; object-fit: cover;" alt="${fn:escapeXml(i.name)}" />
                                                <a href="${pageContext.request.contextPath}/detail?pid=${i.id}">
                                                    <div class="mask">
                                                        <div class="d-flex justify-content-start align-items-end h-100">
                                                            <h5><span class="badge bg-danger ms-2">NEW</span></h5>
                                                        </div>
                                                    </div>
                                                </a>
                                            </div>

                                            <div class="card-body d-flex flex-column">
                                                <a href="${pageContext.request.contextPath}/detail?pid=${i.id}" class="text-reset">
                                                    <h5 class="card-title mb-2">${fn:escapeXml(i.name)}</h5>
                                                </a>
                                                <p class="text-muted small">
                                                    <i class="fas fa-tag me-1"></i>${fn:escapeXml(i.brand)}
                                                </p>

                                                <h6 class="mb-3 mt-auto price text-danger fw-bold">
                                                    <fmt:formatNumber value="${i.price}" type="number"/> VND
                                                </h6>

                                        <div class="d-flex justify-content-between">

  <form action="${pageContext.request.contextPath}/cart" method="post" class="flex-grow-1 me-2">
    <input type="hidden" name="action" value="add">
    <input type="hidden" name="productId" value="${i.id}">
    </form>

        <!-- CSRF TOKEN -->
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

        <button type="submit" class="btn btn-outline-primary btn-sm w-100">
            <i class="fas fa-cart-plus me-1"></i> Thêm vào giỏ
        </button>
    </form>
    <a href="${pageContext.request.contextPath}/buyNow?pid=${i.id}" 
       class="btn btn-primary btn-sm flex-grow-1">
        Mua ngay
    </a>
</div>
                                                <div class="mt-2">
                                                    <a href="${pageContext.request.contextPath}/compare?action=add&productId=${i.id}" 
                                                       class="btn btn-outline-success btn-sm w-100">
                                                        So sánh
                                                    </a>
                                                </div>             
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="text-center py-5">
                                <i class="fas fa-search fa-3x mb-3 text-muted"></i>
                                <h4>No products found</h4>
                                <p>Try adjusting your search or filters</p>
                                <a href="${pageContext.request.contextPath}/client/search" class="btn btn-primary">Search Again</a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                    <c:if test="${totalPages > 1}">
                        <nav aria-label="Page navigation" class="d-flex justify-content-center mt-5">
                            <ul class="pagination shadow-sm">

                                <%-- Nút Previous (Lùi) --%>
                                <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                    <a class="page-link" href="${pageContext.request.contextPath}/client/search?page=${currentPage - 1}&txt=${fn:escapeXml(param.txt)}&category=${param.category}&brand=${fn:escapeXml(param.brand)}&minPrice=${param.minPrice}&maxPrice=${param.maxPrice}" aria-label="Previous">
                                        <span aria-hidden="true">&laquo;</span>
                                    </a>
                                </li>

                                <%-- Các nút số trang --%>
                                <c:forEach begin="1" end="${totalPages}" var="pageNumber">
                                    <li class="page-item ${pageNumber == currentPage ? 'active' : ''}">
                                        <a class="page-link" href="${pageContext.request.contextPath}/client/search?page=${pageNumber}&txt=${fn:escapeXml(param.txt)}&category=${param.category}&brand=${fn:escapeXml(param.brand)}&minPrice=${param.minPrice}&maxPrice=${param.maxPrice}">${pageNumber}</a>
                                    </li>
                                </c:forEach>

                                <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                    <a class="page-link" href="${pageContext.request.contextPath}/client/search?page=${currentPage + 1}&txt=${fn:escapeXml(param.txt)}&category=${param.category}&brand=${fn:escapeXml(param.brand)}&minPrice=${param.minPrice}&maxPrice=${param.maxPrice}" aria-label="Next">
                                        <span aria-hidden="true">&raquo;</span>
                                    </a>
                                </li>

                            </ul>
                        </nav>
                    </c:if>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>

        <script>
            document.querySelector('select[name="category"]')?.addEventListener('change', function () {
                this.form.submit();
            });

            document.querySelector('select[name="brand"]')?.addEventListener('change', function () {
                this.form.submit();
            });
        </script>
    </body>
</html>
<%@ include file="/client/components/compare-bar.jsp" %>
<%@ include file="footer/footer.jsp" %>