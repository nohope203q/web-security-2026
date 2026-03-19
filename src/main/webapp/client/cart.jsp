<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Giỏ hàng</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/client/css/style-1.css">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet"/>
    </head>
    <body>
        <div class="page-wrapper">
            <aside class="sidebar">
                <div>
                    <div class="logo"></i> TechStore</div>
                    <nav>
                        <a href="${pageContext.request.contextPath}/home"></i> Trang chủ</a>
                        <a href="${pageContext.request.contextPath}/client/order-tracking.jsp"></i>Đơn hàng</a>
                        <a href="${pageContext.request.contextPath}/client/profile.jsp"></i> Tài khoản</a>
                    </nav>
                </div>
                <div class="sidebar-footer">
                    © 2025 TechStore
                </div>
            </aside>
            <main class="main-content">
                <div class="container">

                    <div class="cart-view">
                        <h1>Giỏ hàng của bạn</h1>

                        <c:choose>
                            <%-- SỬA: Dùng biến requestScope "cartItems" để kiểm tra --%>
                            <c:when test="${empty cartItems}">
                                <div class="cart-empty-msg">
                                    <i class="fas fa-shopping-cart fa-4x text-muted mb-3"></i>
                                    <h4>Giỏ hàng của bạn đang trống</h4>
                                    <h4>Hãy khám phá các sản phẩm tuyệt vời của chúng tôi!</h4><br>
                                    <a href="${pageContext.request.contextPath}/home" class="btn btn-primary mt-3">Bắt đầu mua sắm</a>
                                </div>
                            </c:when>

                            <c:otherwise>
                                <div class="cart-layout">

                                    <%-- CỘT TRÁI: DANH SÁCH SẢN PHẨM --%>
                                    <div class="cart-items-list">
                                        <div class="cart-header">
                                            <div class="header-product">Sản phẩm</div>
                                            <div class="header-quantity">Số lượng</div>
                                            <div class="header-price">Đơn giá</div>
                                            <div class="header-total">Thành tiền</div>
                                        </div>

                                        <%-- SỬA: Lặp qua biến requestScope "cartItems" --%>
                                        <c:forEach var="item" items="${cartItems}">
                                            <div class="cart-item">
                                                <div class="item-product">
                                                    <img src="${item.product.image}" alt="${item.product.name}">
                                                    <div class="item-details">
                                                        <h5 class="product-name">${item.product.name}</h5>
                                                        <%-- SỬA: Dùng contextPath cho form action --%>
                                                        <form action="${pageContext.request.contextPath}/cart" method="post" class="remove-form">
                                                            <input type="hidden" name="action" value="remove">
                                                            <input type="hidden" name="productId" value="${item.product.id}">
                                                            <button type="submit" class="btn-remove">
                                                                <i class="fas fa-trash-alt"></i> Xóa
                                                            </button>
                                                        </form>
                                                    </div>
                                                </div>
                                                <div class="item-quantity">
                                                    <%-- SỬA: Dùng contextPath cho form action --%>
                                                    <form action="${pageContext.request.contextPath}/cart" method="post">
                                                        <input type="hidden" name="action" value="update">
                                                        <input type="hidden" name="productId" value="${item.product.id}">
                                                        <input type="number" name="quantity" value="${item.quantity}" min="1" class="quantity-input" onchange="this.form.submit()">
                                                    </form>
                                                </div>
                                                <div class="item-price">
                                                    <fmt:formatNumber value="${item.product.price}" type="currency" currencySymbol="đ" minFractionDigits="0" />
                                                </div>
                                                <div class="item-total">
                                                    <fmt:formatNumber value="${item.total}" type="currency" currencySymbol="đ" minFractionDigits="0" />
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>

                                    <%-- CỘT PHẢI: TÓM TẮT ĐƠN HÀNG --%>
                                    <div class="cart-summary-panel">
                                        <div class="cart-summary">
                                            <h4>Tóm tắt đơn hàng</h4>
                                            <div class="summary-row">
                                                <span>Tạm tính</span>
                                                <%-- Các biến này giờ đã có dữ liệu từ servlet --%>
                                                <span><fmt:formatNumber value="${subtotal}" type="currency" currencySymbol="đ" minFractionDigits="0" /></span>
                                            </div>
                                           
                                            <hr>
                                            <div class="summary-row total">
                                                <span>Tổng cộng</span>
                                                <span><fmt:formatNumber value="${total}" type="currency" currencySymbol="đ" minFractionDigits="0" /></span>
                                            </div>
                                        </div>
                                        <div class="cart-actions">
                                            <%-- SỬA: Dùng contextPath cho các đường link --%>
                                            <a href="${pageContext.request.contextPath}/client/checkout.jsp" class="btn btn-primary btn-block">Tiến hành thanh toán</a>
                                            <a href="${pageContext.request.contextPath}/home" class="btn btn-secondary btn-block">Tiếp tục mua sắm</a>
                                        </div>
                                    </div>

                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </main>
        </div>
    </body>
</html>