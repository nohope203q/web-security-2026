<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<%-- Tính toán lại tổng tiền để đảm bảo dữ liệu luôn đúng --%>
<c:set var="cart" value="${sessionScope.cart}" />
<c:set var="subtotal" value="0" />
<c:forEach var="item" items="${cart}">
    <c:set var="subtotal" value="${subtotal + item.product.price * item.quantity}" />
</c:forEach>
<c:set var="discountAmount" value="${empty sessionScope.discountAmount ? 0 : sessionScope.discountAmount}" />
<c:set var="finalTotal" value="${subtotal - discountAmount}" />


<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Thanh toán</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"/>
    </head>
    <body>

        <div class="container mt-5 mb-5">
            <div class="row">
                <%-- Cột bên trái: Thông tin giao hàng --%>
                <div class="col-md-7">
                    <h3>Thông tin thanh toán</h3>
                    <hr>
                    <form action="${pageContext.request.contextPath}/client/order" method="POST" id="orderForm">

                        <div class="mb-3">
                            <label class="form-label">Người nhận</label>
                            <input type="text" class="form-control" value="${sessionScope.account.name}" readonly>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Email</label>
                            <input type="email" class="form-control" value="${sessionScope.account.email}" readonly>
                        </div>

                        <%-- ================================================= --%>
                        <%-- === PHẦN SỬA ĐỔI: LỰA CHỌN ĐỊA CHỈ GIAO HÀNG === --%>
                        <%-- ================================================= --%>
                        <div class="mb-3">
                            <label class="form-label">Địa chỉ giao hàng</label>

                            <%-- Lựa chọn 1: Dùng địa chỉ mặc định --%>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="addressOption" id="defaultAddress" value="default" checked onchange="toggleNewAddress()">
                                <label class="form-check-label" for="defaultAddress">
                                    Sử dụng địa chỉ mặc định: <strong>${sessionScope.account.address}</strong>
                                </label>
                            </div>

                            <%-- Lựa chọn 2: Dùng địa chỉ mới --%>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="addressOption" id="newAddressRadio" value="new" onchange="toggleNewAddress()">
                                <label class="form-check-label" for="newAddressRadio">
                                    Giao hàng đến địa chỉ khác
                                </label>
                            </div>

                            <%-- Ô nhập địa chỉ mới (mặc định sẽ bị ẩn) --%>
                            <div id="newAddressContainer" class="mt-2" style="display: none;">
                                <input type="text" class="form-control" id="newAddress" name="newAddress" placeholder="Nhập địa chỉ mới chi tiết">
                            </div>
                        </div>
                        <%-- ================= KẾT THÚC PHẦN SỬA ĐỔI ================= --%>

                        <%-- Các phương thức thanh toán --%>
                        <div class="mb-3">
                            <label class="form-label">Phương thức thanh toán</label>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="paymentMethod" id="cod" value="COD" checked>
                                <label class="form-check-label" for="cod">
                                    Thanh toán khi nhận hàng (COD)
                                </label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="paymentMethod" id="vnpay" value="VNPAY">
                                <label class="form-check-label" for="vnpay">
                                    Thanh toán qua VNPAY
                                </label>
                            </div>
                        </div>
                    </form>
                </div>

                <%-- Cột bên phải: Tóm tắt đơn hàng & Coupon --%>
                <div class="col-md-5">
                    <div class="card shadow-sm">
                        <div class="card-body">
                            <h4 class="card-title mb-4">Đơn hàng của bạn</h4>
                            <hr>

                            <%-- Form áp dụng Coupon --%>
                            <form action="${pageContext.request.contextPath}/client/apply-coupon" method="POST" class="mb-3">
                                <label class="form-label">Mã giảm giá</label>
                                <div class="input-group">
                                    <input type="text" class="form-control" name="couponCode" placeholder="Nhập mã..." value="${sessionScope.appliedCoupon.code}">
                                    <button class="btn btn-outline-secondary" type="submit">Áp dụng</button>
                                </div>
                            </form>

                            <%-- Hiển thị thông báo coupon --%>
                            <c:if test="${not empty sessionScope.couponMessage}">
                                <div class="alert ${sessionScope.couponStatus == 'success' ? 'alert-success' : 'alert-danger'} small p-2" role="alert">
                                    ${sessionScope.couponMessage}
                                </div>
                                <% session.removeAttribute("couponMessage"); session.removeAttribute("couponStatus"); %>
                            </c:if>

                            <hr>

                            <%-- Chi tiết tổng tiền --%>
                            <ul class="list-group list-group-flush">
                                <li class="list-group-item d-flex justify-content-between">
                                    <span>Tạm tính:</span>
                                    <span><fmt:formatNumber value="${subtotal}" type="number"/> VND</span>
                                </li>
                                <c:if test="${not empty sessionScope.appliedCoupon}">
                                    <li class="list-group-item d-flex justify-content-between text-success">
                                        <span>Giảm giá (${sessionScope.appliedCoupon.code}):</span>
                                        <span>- <fmt:formatNumber value="${discountAmount}" type="number"/> VND</span>
                                    </li>
                                </c:if>
                                <li class="list-group-item d-flex justify-content-between fw-bold fs-5">
                                    <span>Thành tiền:</span>
                                    <span class="text-danger"><fmt:formatNumber value="${finalTotal}" type="number"/> VND</span>
                                </li>
                            </ul>

                            <%-- Nút Đặt Hàng (liên kết với form bên trái) --%>
                            <button type="submit" form="orderForm" class="btn btn-primary w-100 mt-4">
                                <i class="fas fa-shopping-cart me-2"></i> ĐẶT HÀNG
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script>
            // Hàm JavaScript để ẩn/hiện ô nhập địa chỉ mới
            function toggleNewAddress() {
                var newAddressContainer = document.getElementById('newAddressContainer');
                var newAddressRadio = document.getElementById('newAddressRadio');
                var newAddressInput = document.getElementById('newAddress');

                if (newAddressRadio.checked) {
                    newAddressContainer.style.display = 'block'; // Hiện ra
                    newAddressInput.setAttribute('required', 'required'); // Bắt buộc nhập
                } else {
                    newAddressContainer.style.display = 'none'; // Ẩn đi
                    newAddressInput.removeAttribute('required'); // Không bắt buộc nhập
                    newAddressInput.value = ''; // Xóa giá trị cũ nếu có
                }
            }
        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>