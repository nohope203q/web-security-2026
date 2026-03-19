<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Thống kê theo ngày</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <link rel="stylesheet" href="<c:url value='/admin/styles/main.css'/>">
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <style>
            .filters{
                display:flex;
                gap:10px;
                align-items:center;
                margin-bottom:16px
            }
            .filters select,.filters input{
                padding:6px 8px
            }
        </style>
    </head>
    <body>
        <%@ include file="includes/sidebar.jsp" %>
        <div class="main">
            <h2>Thống kê theo ngày</h2>

            <div class="filters">
                <select id="preset">
                    <option value="this_month">Tháng này</option>
                    <option value="last_month">Tháng trước</option>
                    <option value="this_week">Tuần này</option>
                    <option value="last_week">Tuần trước</option>
                    <option value="today">Hôm nay</option>
                    <option value="yesterday">Hôm qua</option>
                    <option value="">Tùy chọn…</option>
                </select>
                <input type="date" id="from">
                <span>→</span>
                <input type="date" id="to">
                <button class="btn btn-primary" id="apply">Áp dụng</button>
            </div>

            <div class="card-box" style="display:flex;gap:20px;margin-bottom:20px;">
                <div class="card">Tổng doanh thu<br><b id="totalRev">0 ₫</b></div>
            </div>

            <canvas id="rev"  height="120"></canvas>
            <canvas id="ord"  height="120"></canvas>
            <canvas id="usr"  height="120"></canvas>
        </div>

        <script>
            // Endpoint đúng với Servlet của bạn
            const api = '<c:url value="/admin/statistic"/>';

            // Khởi tạo 3 chart + title
            const revChart = new Chart(document.getElementById('rev'), {
                type: 'line',
                data: {labels: [], datasets: [{label: 'Doanh thu', data: [], borderColor: '#28a745', fill: false}]},
                options: {responsive: true, plugins: {title: {display: true, text: ''}}}
            });
            const ordChart = new Chart(document.getElementById('ord'), {
                type: 'line',
                data: {labels: [], datasets: [{label: 'Đơn hàng', data: [], borderColor: '#007bff', fill: false}]},
                options: {responsive: true, plugins: {title: {display: true, text: ''}}}
            });
            const usrChart = new Chart(document.getElementById('usr'), {
                type: 'line',
                data: {labels: [], datasets: [{label: 'Người đăng ký', data: [], borderColor: '#ffc107', fill: false}]},
                options: {responsive: true, plugins: {title: {display: true, text: ''}}}
            });

            /* ===== Helpers: tạo nhãn ngày theo LOCAL (không dùng UTC) ===== */
            function ymdLocal(dt) {
                var y = dt.getFullYear();
                var m = String(dt.getMonth() + 1).padStart(2, '0');
                var d = String(dt.getDate()).padStart(2, '0');
                return y + '-' + m + '-' + d;
            }
            function daysRangeLocal(fromStr, toStr) {
                var out = [];
                var d = new Date(fromStr + 'T00:00:00');
                var to = new Date(toStr + 'T00:00:00');
                while (d <= to) {
                    out.push(ymdLocal(d));
                    d.setDate(d.getDate() + 1);
                }
                return out;
            }
            function toMapObj(arr) {
                var m = new Map();
                (arr || []).forEach(function (x) {
                    m.set(x.date, x.value || 0);
                });
                return m;
            }

            async function load(params) {
                // Gọi API
                var url = api + '?' + new URLSearchParams(params);
                var res = await fetch(url);
                var data = await res.json();
                // console.log('STATS:', data);

                // Dữ liệu trả về dạng [{date:'yyyy-MM-dd', value:Number}]
                var rev = data.revenueByDay || [];
                var ord = data.ordersByDay || [];
                var usr = data.newUsersByDay || [];

                // Nhãn ngày liên tục theo local
                var labels = daysRangeLocal(data.from, data.to);

                // Map ngày -> giá trị để fill 0 cho ngày trống
                var revMap = toMapObj(rev);
                var ordMap = toMapObj(ord);
                var usrMap = toMapObj(usr);

                // Cập nhật datasets & labels
                revChart.data.labels = labels;
                revChart.data.datasets[0].data = labels.map(function (d) {
                    return revMap.get(d) || 0;
                });

                ordChart.data.labels = labels;
                ordChart.data.datasets[0].data = labels.map(function (d) {
                    return ordMap.get(d) || 0;
                });

                usrChart.data.labels = labels;
                usrChart.data.datasets[0].data = labels.map(function (d) {
                    return usrMap.get(d) || 0;
                });

                // Tính tổng theo khoảng ngày (không dùng optional chaining)
                var totals = (data && data.totals) ? data.totals : {};
                var totalRev = (typeof totals.revenue === 'number') ? totals.revenue : Number(totals.revenue) || 0;
                var totalOrd = parseInt(totals.orders, 10) || 0;
                var totalUsr = parseInt(totals.users, 10) || 0;

                // Cập nhật ô "Tổng doanh thu"
                document.getElementById('totalRev').textContent = totalRev.toLocaleString('vi-VN') + ' ₫';

                // Tiêu đề mỗi chart hiển thị tổng theo filter
                revChart.options.plugins.title.text = 'Doanh thu • ' + totalRev.toLocaleString('vi-VN') + ' ₫';
                ordChart.options.plugins.title.text = 'Đơn hàng • ' + totalOrd;
                usrChart.options.plugins.title.text = 'Người đăng ký • ' + totalUsr;

                // (tuỳ chọn) cấu hình trục Y
                revChart.options.scales = {y: {beginAtZero: true}};
                ordChart.options.scales = {y: {beginAtZero: true, ticks: {precision: 0}}};
                usrChart.options.scales = {y: {beginAtZero: true, ticks: {precision: 0}}};

                // Vẽ lại
                revChart.update();
                ordChart.update();
                usrChart.update();

                // Set lại input hiển thị
                document.getElementById('from').value = data.from;
                document.getElementById('to').value = data.to;
            }

            // Sự kiện nút Áp dụng
            document.getElementById('apply').onclick = function () {
                var preset = document.getElementById('preset').value;
                var f = document.getElementById('from').value;
                var t = document.getElementById('to').value;

                if (preset)
                    load({range: preset});
                else if (f && t)
                    load({from: f, to: t});
                else
                    alert('Chọn preset hoặc nhập khoảng ngày!');
            };

            // Tải mặc định
            load({range: 'this_month'});
        </script>
    </body>
</html>
