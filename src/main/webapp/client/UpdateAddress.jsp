<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Cập nhật địa chỉ</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/client/css/style-2.css">
    </head>
    <body>

        <div class="form-container">
            <h2 class="form-title">Cập nhật địa chỉ</h2>
            <p class="form-subtitle">Vui lòng điền thông tin địa chỉ của bạn.</p>

            <form action="${pageContext.request.contextPath}/client/updateAddress" method="post">
                <div class="form-group">
                    <label for="street">Địa chỉ nhà</label>
                    <input type="text" id="street" name="street" value="${account.address.street}" placeholder="Ví dụ: 123 Nguyễn Văn Cừ, Phường 4" required>
                </div>

                <div class="form-group">
                    <label for="city">Thành phố / Tỉnh</label>
                    <input type="text" id="city" name="city" value="${account.address.city}" placeholder="Ví dụ: TP. Hồ Chí Minh" required>
                </div>

                <div class="form-group">
                    <label for="postalCode">Mã bưu chính (Mã vùng)</label>
                    <input type="text" id="postalCode" name="postalCode" value="${account.address.postalCode}" placeholder="Ví dụ: 70000" required>
                </div>

                <button type="submit" class="submit-btn">Lưu thay đổi</button>
            </form>
        </div>

    </body>
</html>