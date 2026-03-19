<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html><html lang="vi"><head>
        <meta charset="UTF-8"><title>Quản lý mã giảm giá</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <link rel="stylesheet" href="<%= request.getContextPath() %>/admin/styles/main.css">
        <style>
            .table{
                width:100%;
                border-collapse:collapse;
                background:#fff;
                border-radius:8px
            }
            th,td{
                padding:12px;
                border-bottom:1px solid #eee
            }
            th{
                background:#28a745;
                color:#fff;
                text-align:left
            }
            .badge{
                padding:4px 8px;
                border-radius:12px;
                font-size:12px
            }
            .badge.active{
                background:#e7f7ed;
                color:#28a745
            }
            .badge.scheduled{
                background:#fff4d6;
                color:#b58900
            }
            .badge.expired{
                background:#ffe6e6;
                color:#c0392b
            }
            .badge.disabled{
                background:#eee;
                color:#666
            }
            .add-btn {
                padding: 10px 20px;
                background-color: #28a745;
                color: white;
                text-decoration: none;
                border-radius: 5px;
                font-size: 16px;
                display: inline-block;
                margin-bottom: 20px;
            }

            .add-btn:hover {
                background-color: #218838;
            }
            .btn-action {
                display: inline-flex;  /* Giúp căn giữa icon */
                align-items: center;
                justify-content: center;
                width: 38px;          /* Chiều rộng cố định */
                height: 38px;         /* Chiều cao cố định */

                background-color: #10b981; /* Màu xanh lá cây bạn muốn */
                color: white;              /* Màu icon là màu trắng */

                border: none;              /* Bỏ viền */
                border-radius: 8px;        /* Bo tròn góc */

                text-decoration: none;     /* Bỏ gạch chân (quan trọng cho thẻ <a>) */
                cursor: pointer;

                /* Hiệu ứng chuyển động mượt mà */
                transition: all 0.2s ease-in-out;
            }
            .btn-action:hover {
                background-color: #059669; /* Đổi màu xanh đậm hơn */
                transform: translateY(-2px); /* Nút nhích lên một chút */
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }

            /* Tăng kích thước icon bên trong nút */
            .btn-action i {
                font-size: 16px;
            }
        </style></head><body>
        <%@ include file="includes/sidebar.jsp" %>
        <div class="main">
            <h2>Danh sách mã giảm giá</h2>
            <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:20px;">
                <a class="btn btn-primary" href="${pageContext.request.contextPath}/admin/coupons?action=addForm"><i class="fa-solid fa-plus"></i>  Thêm mã</a>
            </div>
            <table class="table">
                <thead><tr>
                        <th>Mã</th><th>Loại</th><th>Giá trị</th><th>ĐK tối thiểu</th>
                        <th>Giới hạn</th><th>Đã dùng</th><th>Thời gian</th><th>Trạng thái</th><th>Thao tác</th>
                    </tr></thead>
                <tbody>
                    <c:forEach var="c" items="${coupons}">
                        <tr>
                            <td><b>${c.code}</b></td>
                            <td>${c.type}</td>
                            <td><c:choose>
                                    <c:when test="${c.type=='PERCENT'}">${c.value}% <c:if test="${c.maxDiscount!=null}">(tối đa ${c.maxDiscount})</c:if></c:when>
                                    <c:otherwise>${c.value}</c:otherwise>
                                </c:choose></td>
                            <td>${c.minOrder}</td>
                            <td><c:out value="${c.usageLimit==null ? '∞' : c.usageLimit}"/></td>
                            <td>${c.usedCount}</td>
                            <td>${c.startDate} → ${c.endDate}</td>
                            <td><span class="badge ${c.status}">${c.status}</span></td>
                            <td>
                                <a href="${pageContext.request.contextPath}/admin/coupons?action=editForm&id=${c.id}" class="btn-action" title="Chỉnh sửa"><i class="fa-solid fa-pen"></i>️</a>
                                <a href="${pageContext.request.contextPath}/admin/coupons?action=delete&id=${c.id}" class="btn-action" title="Xóa" onclick="return confirm('Xóa mã này?')"><i class="fa-solid fa-trash"></i></a>
                                <a href="${pageContext.request.contextPath}/admin/coupons?action=toggle&id=${c.id}" class="btn-action">${c.status=='disabled'?'Bật':'Tắt'}</a>
                            </td>
                        </tr>
                    </c:forEach>  
                </tbody>
            </table>
        </div>
    </body></html>
