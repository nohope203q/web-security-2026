<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="cpath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>So sánh sản phẩm</title>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/7.3.0/mdb.min.css" rel="stylesheet" />
        <style>
            .cmp-table td, .cmp-table th {
                vertical-align: top;
            }
            .img-fit {
                max-width: 100%;
                border-radius: 12px;
            }
            .price {
                font-weight: 700;
            }
            .muted {
                color: #6b7280;
            }
        </style>
    </head>
    <body class="container my-4">

        <div class="d-flex justify-content-between align-items-center mb-3">
            <h3 class="mb-0">So sánh sản phẩm</h3>
            <div class="d-flex gap-2">
                <a href="${cpath}/compare?action=clear" class="btn btn-outline-secondary btn-sm">Xoá danh sách</a>
                <a href="${cpath}/" class="btn btn-primary btn-sm">Tiếp tục chọn</a>
            </div>
        </div>

        <c:choose>
            <c:when test="${empty compareProducts}">
                <div class="alert alert-info">Bạn chưa chọn sản phẩm nào để so sánh.</div>
            </c:when>
            <c:otherwise>
                <table class="table table-bordered align-middle cmp-table">
                    <thead>
                        <tr>
                            <th style="width: 20%;">Thuộc tính</th>
                                <c:forEach items="${compareProducts}" var="p">
                                <th style="width:${100 / (fn:length(compareProducts)+1)}%;">
                                    <div class="text-center">
                                        <div class="mb-2">
                                            <img class="img-fit"
                                                 src="${p.image}"
                                                 alt="${p.name}"/>
                                        </div>
                                        <div class="fw-bold">${p.name}</div>
                                        <div class="muted">${p.brand}</div>
                                        <div class="price mt-1">
                                            <h6 class="mb-3 mt-auto price"><fmt:formatNumber value="${p.price}" type="currency" currencySymbol="₫"/></h6>
                                        </div>
                                        <div class="mt-2">
                                            <a class="btn btn-outline-danger btn-sm"
                                               href="${pageContext.request.contextPath}/compare?action=remove&productId=${p.id}">

                                                Bỏ khỏi so sánh

                                            </a>
                                        </div>
                                    </div>
                                </th>
                            </c:forEach>
                            <c:if test="${fn:length(compareProducts) == 1}">
                                <th class="text-center text-muted">
                                    + Chọn thêm 1 sản phẩm trên trang chủ để so sánh
                                </th>
                            </c:if>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <th>Hãng</th>
                            <c:forEach items="${compareProducts}" var="p"><td>${p.brand}</td></c:forEach>
                            <c:if test="${fn:length(compareProducts) == 1}"><td class="text-muted">—</td></c:if>
                            </tr>
                            <tr>
                                <th>Màu sắc</th>
                            <c:forEach items="${compareProducts}" var="p"><td>${p.color != null ? p.color : '-'}</td></c:forEach>
                            <c:if test="${fn:length(compareProducts) == 1}"><td class="text-muted">—</td></c:if>
                            </tr>
                            <tr>
                                <th>Giá</th>
                            <c:forEach items="${compareProducts}" var="p"><td><c:out value="${p.price}" /> VND</td></c:forEach>
                            <c:if test="${fn:length(compareProducts) == 1}"><td class="text-muted">—</td></c:if>
                            </tr>
                            <tr>
                                <th>Mô tả</th>
                            <c:forEach items="${compareProducts}" var="p"><td>${p.description}</td></c:forEach>
                            <c:if test="${fn:length(compareProducts) == 1}"><td class="text-muted">—</td></c:if>
                            </tr>
                        </tbody>
                    </table>
            </c:otherwise>
        </c:choose>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/7.3.0/mdb.min.js"></script>
    </body>
</html>
