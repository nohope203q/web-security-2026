<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="cpath" value="${pageContext.request.contextPath}" />

<c:if test="${not empty sessionScope.compareList}">
    <div style="
         position: fixed; left: 0; right: 0; bottom: 0; z-index: 1050;
         background: #fff; border-top: 1px solid #e5e7eb; padding: 10px 16px;">
        <div class="container d-flex align-items-center justify-content-between gap-2">
            <div class="d-flex align-items-center flex-wrap gap-2">
                <strong>Đang chọn so sánh:</strong>
                <c:forEach var="pid" items="${sessionScope.compareList}">
                    <a class="badge bg-light text-dark border"
                       href="${cpath}/compare?action=remove&productId=${pid}">
                        #${pid} &times;
                    </a>
                </c:forEach>
            </div>

            <div class="d-flex gap-2">
                <a class="btn btn-outline-secondary btn-sm"
                   href="${cpath}/compare?action=clear">Xoá hết</a>
                <a class="btn btn-success btn-sm"
                   href="${cpath}/compare?action=view">So sánh ngay</a>
            </div>
        </div>
    </div>
</c:if>
