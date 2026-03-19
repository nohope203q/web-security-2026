<%@ page contentType="text/html; charset=UTF-8" %>
<%
    String currentPage_sidebar = request.getRequestURI();
    String pageName = currentPage_sidebar.substring(currentPage_sidebar.lastIndexOf("/") + 1); // lấy phần sau dấu /
%>

<div class="sidebar">
    <h2><a href="<%= request.getContextPath() %>/admin/admin.jsp" class="admin-title">
            <i class="fa-solid fa-screwdriver-wrench"></i> Admin Panel
        </a></h2>
    <ul>
        <li><a href="product" class="<%= pageName.equals("product.jsp") ? "active" : "" %>">
                <i class="fa-solid fa-box"></i> Quản lý sản phẩm
            </a></li>

        <li><a href="order" class="<%= currentPage_sidebar.contains("order") ? "active" : "" %>">
                <i class="fa-solid fa-receipt"></i> Quản lý đơn hàng
            </a></li>

        <li><a href="category" class="<%= currentPage_sidebar.contains("category") ? "active" : "" %>">
                <i class="fa-solid fa-layer-group"></i> Quản lý danh mục
            </a></li>

        <li><a href="customer" class="<%= currentPage_sidebar.contains("customer") ? "active" : "" %>">
                <i class="fa-solid fa-users"></i> Quản lý khách hàng
            </a></li>

        <li><a href="review" class="<%= currentPage_sidebar.contains("review") ? "active" : "" %>">
                <i class="fa-solid fa-comments"></i> Quản lý bình luận
            </a></li>

        <li><a href="coupons" class="<%= currentPage_sidebar.contains("coupons") ? "active" : "" %>">
                <i class="fa-solid fa-ticket"></i> Mã giảm giá
            </a></li>

        <li><a href="statistic.jsp" class="<%= currentPage_sidebar.contains("statistic.jsp") ? "active" : "" %>">
                <i class="fa-solid fa-chart-line"></i> Thống kê
            </a></li>

        <li><a href="announcements" class="<%= currentPage_sidebar.contains("announcements") ? "active" : "" %>">
                <i class="fa-solid fa-bell"></i> Thông báo
            </a></li>

        <li>
            <a href="<%= request.getContextPath() %>/client/logout" class="logout-link">
                <i class="fa-solid fa-right-from-bracket"></i> Đăng xuất
            </a>
        </li>
    </ul>
</div>
