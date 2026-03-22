<%@ page contentType="text/html; charset=UTF-8" %>
<%
    String currentPage_sidebar = request.getRequestURI();
    String pageName = currentPage_sidebar.substring(currentPage_sidebar.lastIndexOf("/") + 1);
    String ctx = request.getContextPath();
%>
<div class="sidebar">
    <h2><a href="<%= ctx %>/admin" class="admin-title">
            <i class="fa-solid fa-screwdriver-wrench"></i> Admin Panel
        </a></h2>
    <ul>
        <li><a href="<%= ctx %>/admin/product" class="<%= currentPage_sidebar.contains("/admin/product") ? "active" : "" %>">
                <i class="fa-solid fa-box"></i> Quản lý sản phẩm
            </a></li>
        <li><a href="<%= ctx %>/admin/order" class="<%= currentPage_sidebar.contains("/admin/order") ? "active" : "" %>">
                <i class="fa-solid fa-receipt"></i> Quản lý đơn hàng
            </a></li>
        <li><a href="<%= ctx %>/admin/category" class="<%= currentPage_sidebar.contains("/admin/category") ? "active" : "" %>">
                <i class="fa-solid fa-layer-group"></i> Quản lý danh mục
            </a></li>
        <li><a href="<%= ctx %>/admin/customer" class="<%= currentPage_sidebar.contains("/admin/customer") ? "active" : "" %>">
                <i class="fa-solid fa-users"></i> Quản lý khách hàng
            </a></li>
        <li><a href="<%= ctx %>/admin/review" class="<%= currentPage_sidebar.contains("/admin/review") ? "active" : "" %>">
                <i class="fa-solid fa-comments"></i> Quản lý bình luận
            </a></li>
        <li><a href="<%= ctx %>/admin/coupon" class="<%= currentPage_sidebar.contains("/admin/coupon") ? "active" : "" %>">
                <i class="fa-solid fa-ticket"></i> Mã giảm giá
            </a></li>
        <li><a href="<%= ctx %>/admin/statistic" class="<%= currentPage_sidebar.contains("/admin/statistic") ? "active" : "" %>">
                <i class="fa-solid fa-chart-line"></i> Thống kê
            </a></li>
        <li><a href="<%= ctx %>/admin/announcements" class="<%= currentPage_sidebar.contains("/admin/announcements") ? "active" : "" %>">
                <i class="fa-solid fa-bell"></i> Thông báo
            </a></li>
        <li>
            <a href="<%= ctx %>/client/logout" class="logout-link">
                <i class="fa-solid fa-right-from-bracket"></i> Đăng xuất
            </a>
        </li>
    </ul>
</div>