<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Hồ sơ khách hàng</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/client/css/style-2.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    </head>
    <body>
        <div class="profile-container">

            <%-- ======== CỘT BÊN TRÁI (SIDEBAR) ======== --%>
            <div class="profile-sidebar">
                <div class="profile-header">
                    <img src="https://img.pikbest.com/illustration/20250214/anime-kitten--22meow-22-font-white--26-black-fur-pink-tiny-paws-vibrant-yellow-bg_11525404.jpg!w700wp" alt="Avatar" class="profile-avatar">
                    <h2>${account.name}</h2>
                    <p class="user-email"><i class="fa-solid fa-envelope"></i> ${account.email}</p>
                    <a href="${pageContext.request.contextPath}/client/logout" class="logout-link">
                        <i class="fa-solid fa-right-from-bracket"></i> Đăng xuất
                    </a>
                </div>

                <%-- Các nút hành động được chuyển vào sidebar --%>
                <div class="profile-actions">
                    <form action="${pageContext.request.contextPath}/" method="get">
                        <button type="submit" class="btn btn-info">
                            <i class="fa-solid fa-house"></i> Quay về trang chủ
                        </button>
                    </form>
                    <form action="${pageContext.request.contextPath}/client/changeProfile.jsp" method="get">
                        <button type="submit" class="btn btn-primary">
                            <i class="fa-solid fa-user-gear"></i> Cập nhật hồ sơ
                        </button>
                    </form>
                    <form action="${pageContext.request.contextPath}/client/changePassword.jsp" method="get">
                        <button type="submit" class="btn btn-secondary">
                            <i class="fa-solid fa-lock"></i> Đổi mật khẩu
                        </button>
                    </form>
                </div>
            </div>

            <%-- ======== CỘT BÊN PHẢI (NỘI DUNG CHÍNH) ======== --%>
            <div class="profile-content">
                <div class="profile-body">
                    <div class="info-section">
                        <h3><i class="fa-solid fa-user"></i> Thông tin cá nhân</h3>
                        <p><span class="label">Tên:</span> <span class="value">${account.name}</span></p>
                        <p><span class="label">Số điện thoại:</span> <span class="value">${account.phone}</span></p>
                        <p><span class="label">Trạng thái:</span> 
                            <span class="status ${account.status == 1 ? 'status-active' : 'status-inactive'}">
                                ${account.status == 1 ? 'Active' : 'Inactive'}
                            </span>
                        </p>
                    </div>

                    <div class="info-section">
                        <h3><i class="fa-solid fa-location-dot"></i> Địa chỉ giao hàng</h3>
                        <c:choose>
                            <c:when test="${account.address != null}">
                                <div class="address-line">
                                    ${account.address.street}, ${account.address.city}, ${account.address.postalCode}
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="address-line muted">Chưa có địa chỉ.</div>
                            </c:otherwise>
                        </c:choose>
                        <a href="${pageContext.request.contextPath}/client/updateAddress" class="btn btn-update-address">
                            <i class="fa-solid fa-pen-to-square"></i> Cập nhật địa chỉ
                        </a>
                    </div>
                </div>
            </div>

        </div>
    </body>
</html>
