+<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Theo dõi đơn hàng</title>
        <!--  <link rel="stylesheet" href="style.css">-->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/client/css/style-1.css">
    </head>
    <body>
        <div class="page-wrapper">
            <aside class="sidebar">
                <div>
                    <div class="logo"><i class="fas fa-store"></i> TechStore</div>
                    <nav>
                        <a href="${pageContext.request.contextPath}/home"><i class="fas fa-home"></i> Trang chủ</a>
                        <a href="${pageContext.request.contextPath}/cart" class="fas fa-box"><i class="fas fa-shopping-cart"></i> Giỏ hàng</a>
                        <a href="${pageContext.request.contextPath}/client/profile.jsp"><i class="fas fa-user"></i> Tài khoản</a>
                    </nav>
                </div>
                <div class="sidebar-footer">
                    © 2025 MyShop
                </div>
            </aside>

            <main class="main-content">
                <div class="container">

                    <!-- Tabs -->
                    <div class="tabs">
                        <a href="order-tracking?status=all" class="${activeTab=='all'?'active':''}">Tất cả</a>
                        <a href="order-tracking?status=0" class="${activeTab=='0'?'active':''}">Chờ xác nhận</a>
                        <a href="order-tracking?status=1" class="${activeTab=='1'?'active':''}">Vận chuyển</a>
                        <a href="order-tracking?status=2" class="${activeTab=='2'?'active':''}">Chờ giao hàng</a>
                        <a href="order-tracking?status=3" class="${activeTab=='3'?'active':''}">Hoàn thành</a>
                        <a href="order-tracking?status=4" class="${activeTab=='4'?'active':''}">Đã hủy</a>
                    </div>

                    <!-- Search -->
                    <form method="get" action="order-tracking" class="search-box">
                        <input type="hidden" name="status" value="${activeTab}">
                        <input type="text" name="keyword" placeholder="Tìm theo tên sản phẩm, địa chỉ, hoặc ID đơn hàng..."
                               value="${param.keyword}">
                    </form>

                    <!-- Danh sách đơn hàng -->
                    <c:choose>
                        <c:when test="${empty orders}">
                            <div class="empty-box">
                                <img src="https://cdn-icons-png.flaticon.com/512/4076/4076500.png" alt="empty">
                                <p>Chưa có đơn hàng phù hợp</p>
                            </div>
                        </c:when>

                        <c:otherwise>
                            <c:forEach var="order" items="${orders}">
                                <div class="order-card">

                                    <!-- Header -->
                                    <div class="order-header">
                                        <span class="status">
                                            <c:choose>
                                                <c:when test="${order.status==0}">Chờ xác nhận</c:when>
                                                <c:when test="${order.status==1}">Vận chuyển</c:when>
                                                <c:when test="${order.status==2}">Chờ giao hàng</c:when>
                                                <c:when test="${order.status==3}">Hoàn thành</c:when>
                                                <c:when test="${order.status==4}">Đã hủy</c:when>
                                                <c:otherwise>Không xác định</c:otherwise>
                                            </c:choose>
                                        </span>
                                    </div>

                                    <!-- Lặp qua từng sản phẩm trong đơn -->
                                    <c:forEach var="item" items="${order.orderItems}">
                                        <div class="order-body">

                                            <!-- Ảnh sản phẩm -->
                                            <c:choose>
                                                <c:when test="${not empty item.product.image}">
                                                    <img src="${item.product.image}" 
                                                         alt="${item.product.name}" 
                                                         style="width:100px;height:100px;object-fit:cover;border-radius:6px;">
                                                </c:when>
                                                <c:otherwise>
                                                    <img src="images/no-image.png" 
                                                         alt="no image" 
                                                         style="width:100px;height:100px;object-fit:cover;border-radius:6px;">
                                                </c:otherwise>
                                            </c:choose>

                                            <!-- Thông tin sản phẩm -->
                                            <div class="order-info">
                                                <h3>${item.product.name}</h3>
                                                <p><strong>Thương hiệu:</strong> ${item.product.brand}</p>
                                                <p><strong>Màu:</strong> ${item.product.color}</p>
                                                <p><strong>Giá:</strong> <fmt:formatNumber value="${item.product.price}" type="currency" currencySymbol="₫"/></p>

                                                <p><strong>Số lượng:</strong> ${item.quantity}</p>
                                            </div>
                                        </div>
                                    </c:forEach>

                                    <!-- Footer -->
                                    <div class="order-footer">
                                        <div class="footer-left">
                                            <p><strong>Địa chỉ:</strong> ${order.shippingAddress}</p>
                                            <p><strong>Thanh toán:</strong> ${order.paymentMethod}</p>
                                            <p><strong>Ngày đặt:</strong> ${order.dateOrder}</p>
                                        </div>
                                        <div class="footer-right">
                                            <div class="order-total">
                                                <strong>Tổng cộng:</strong> <fmt:formatNumber value="${order.getFinalAmount()}" type="currency" currencySymbol="₫"/>
                                            </div>
                                            <div class="order-actions">
                              <!--                <button href="${pageContext.request.contextPath}/home" class="btn-primary">Mua lại</button>-->
                                                <a href="${pageContext.request.contextPath}/home" class="btn-primary">Mua lại</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>

                </div>
            </main>
        </div>
    </body>
</html>
