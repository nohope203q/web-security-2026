<%-- File: homepage.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%-- Include the header --%>
<%@ include file="header/header.jsp" %>
<style>
    @keyframes scrollLeft {
        0% {
            transform: translateX(0);
        }
        100% {
            transform: translateX(-50%);
        } /* chỉ cần nửa vì đã nhân đôi nội dung */
    }

    .announcement-item {
        min-width: 280px;
    }

    /* Dừng khi hover */
    .announcement-wrapper:hover {
        animation-play-state: paused;
    }

    /* Gradient hai bên cho đẹp mắt */
    .fade-left, .fade-right {
        position: absolute;
        top: 0;
        width: 60px;
        height: 100%;
        z-index: 5;
        pointer-events: none;
    }
    .fade-left {
        left: 0;
        background: linear-gradient(to right, #ffecb3 70%, transparent);
    }
    .fade-right {
        right: 0;
        background: linear-gradient(to left, #ffecb3 70%, transparent);
    }
</style>
<main>


    <c:if test="${not empty listAno}">
        <div class="container mt-3">
            <div class="shadow rounded p-3" 
                 style="background-color: #ffecb3; overflow: hidden; position: relative; white-space: nowrap;">

                <div class="announcement-wrapper" style="display: inline-block; animation: scrollLeft 30s linear infinite;">
                    <c:forEach items="${listAno}" var="announcement">
                        <div class="announcement-item d-inline-block mx-5 align-middle">
                            <h6 class="fw-bold text-danger d-inline-block mb-0 me-2">
                                <i class="fas fa-tag me-1"></i>${announcement.title}
                            </h6>
                            <span class="text-dark small">${announcement.content}</span>
                        </div>
                    </c:forEach>

                    <!-- Lặp lại để tạo hiệu ứng liên tục -->
                    <c:forEach items="${listAno}" var="announcement">
                        <div class="announcement-item d-inline-block mx-5 align-middle">
                            <h6 class="fw-bold text-danger d-inline-block mb-0 me-2">
                                <i class="fas fa-tag me-1"></i>${announcement.title}
                            </h6>
                            <span class="text-dark small">${announcement.content}</span>
                        </div>
                    </c:forEach>
                </div>

                <!-- Hiệu ứng mờ hai bên -->
                <div class="fade-left"></div>
                <div class="fade-right"></div>
            </div>
        </div>


    </c:if>


    <div class="container">
        <nav class="navbar navbar-expand-lg navbar-dark mt-3 mb-5 shadow p-2" style="background-color: #607D8B">
            <div class="container-fluid">
                <a class="navbar-brand" href="#"></a>
                <button class="navbar-toggler" type="button" data-mdb-toggle="collapse" data-mdb-target="#navbarSupportedContent2" aria-controls="navbarSupportedContent2" aria-expanded="false" aria-label="Toggle navigation">
                    <i class="fas fa-bars"></i>
                </button>

            </div>
        </nav>

        <section>
            <div class="text-center">
                <div class="row">
                    <c:forEach var="i" items="${listP}">
                        <div class="col-lg-3 col-md-6 mb-4">
                            <div class="card h-100">
                                <div class="bg-image hover-zoom ripple" data-mdb-ripple-color="light">
                                    <img src="${i.image}" class="w-100" style="height: 200px; object-fit: cover;" alt="${i.name}" />
                                    <a href="detail?pid=${i.id}">
                                        <div class="mask">
                                            <div class="d-flex justify-content-start align-items-end h-100">
                                                <h5><span class="badge bg-danger ms-2">NEW</span></h5>
                                            </div>
                                        </div>
                                        <div class="hover-overlay">
                                            <div class="mask" style="background-color: rgba(251, 251, 251, 0.15);"></div>
                                        </div>
                                    </a>
                                </div>

                                <div class="card-body d-flex flex-column">
                                    <a href="detail?pid=${i.id}" class="text-reset">
                                        <h5 class="card-title mb-2">${i.name}</h5>
                                    </a>
                                    <p class="text-muted small">${i.brand}</p>

                                    <h6 class="mb-3 mt-auto price"><fmt:formatNumber value="${i.price}" type="currency" currencySymbol="₫"/></h6>

                                    <div class="d-flex justify-content-between">

                                        <form action="cart" method="post" class="flex-grow-1 me-2">
                                            <input type="hidden" name="action" value="add">
                                            <input type="hidden" name="productId" value="${i.id}">

                                            <button type="submit" class="btn btn-outline-primary btn-sm w-100" style="white-space: nowrap;">
                                                <i class="fas fa-cart-plus me-1"></i> Thêm vào giỏ
                                            </button>
                                        </form>

                                        <a href="${pageContext.request.contextPath}/client/buy-now?pid=${i.id}" class="btn btn-primary btn-sm flex-grow-1">
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
                    <c:if test="${totalPages > 1}">
                        <nav aria-label="Page navigation" class="d-flex justify-content-center mt-5">
                            <ul class="pagination shadow-sm">

                                <%-- Nút Previous (Lùi) --%>
                                <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                    <a class="page-link" href="${pageContext.request.contextPath}/?page=${currentPage - 1}&txt=${fn:escapeXml(param.txt)}&category=${param.category}&brand=${fn:escapeXml(param.brand)}&minPrice=${param.minPrice}&maxPrice=${param.maxPrice}" aria-label="Previous">
                                        <span aria-hidden="true">&laquo;</span>
                                    </a>
                                </li>

                                <%-- Các nút số trang --%>
                                <c:forEach begin="1" end="${totalPages}" var="pageNumber">
                                    <li class="page-item ${pageNumber == currentPage ? 'active' : ''}">
                                        <a class="page-link" href="${pageContext.request.contextPath}/?page=${pageNumber}&txt=${fn:escapeXml(param.txt)}&category=${param.category}&brand=${fn:escapeXml(param.brand)}&minPrice=${param.minPrice}&maxPrice=${param.maxPrice}">${pageNumber}</a>
                                    </li>
                                </c:forEach>

                                <%-- Nút Next (Tiến) --%>
                                <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                    <a class="page-link" href="${pageContext.request.contextPath}/?page=${currentPage + 1}&txt=${fn:escapeXml(param.txt)}&category=${param.category}&brand=${fn:escapeXml(param.brand)}&minPrice=${param.minPrice}&maxPrice=${param.maxPrice}" aria-label="Next">
                                        <span aria-hidden="true">&raquo;</span>
                                    </a>
                                </li>

                            </ul>
                        </nav>
                    </c:if>
                </div>
            </div>
        </section>

    </div>
</main>

<%@ include file="/client/components/compare-bar.jsp" %>
<%-- Include the footer --%>
<%@ include file="footer/footer.jsp" %>