<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Thống kê hệ thống</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <link rel="stylesheet" href="<c:url value='/admin/styles/main.css'/>">
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <style>
            .main { padding: 20px; }
            .filters { display:flex; gap:10px; align-items:center; margin-bottom:20px; background: #f8f9fa; padding: 15px; border-radius: 8px; }
            .filters select, .filters input { padding:8px; border: 1px solid #ddd; border-radius: 4px; }
            .card-box { display:flex; gap:20px; margin-bottom:25px; }
            .card { background: #fff; padding: 20px; border-radius: 8px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); flex: 1; border-left: 5px solid #28a745; }
            .card b { font-size: 1.5rem; color: #333; }
            canvas { background: #fff; margin-bottom: 30px; padding: 15px; border-radius: 8px; box-shadow: 0 2px 5px rgba(0,0,0,0.05); }
        </style>
    </head>
    <body>
        <%@ include file="includes/sidebar.jsp" %>
        
        <div class="main">
            <h2><i class="fa-solid fa-chart-line"></i> Thống kê báo cáo</h2>

            <div class="filters">
                <select id="preset">
                    <option value="this_month">Tháng này</option>
                    <option value="last_month">Tháng trước</option>
                    <option value="this_week">Tuần này</option>
                    <option value="last_week">Tuần trước</option>
                    <option value="today">Hôm nay</option>
                    <option value="yesterday">Hôm qua</option>
                    <option value="">Tùy chọn ngày...</option>
                </select>
                <input type="date" id="from">
                <span>đến</span>
                <input type="date" id="to">
                <button class="btn btn-primary" id="apply" style="padding: 8px 20px; cursor: pointer;">Lọc dữ liệu</button>
            </div>

            <div class="card-box">
                <div class="card">
                    <span>Tổng doanh thu</span><br>
                    <b id="totalRev">0 ₫</b>
                </div>
                <div class="card" style="border-left-color: #007bff;">
                    <span>Tổng đơn hàng</span><br>
                    <b id="totalOrd">0</b>
                </div>
                <div class="card" style="border-left-color: #ffc107;">
                    <span>Người dùng mới</span><br>
                    <b id="totalUsr">0</b>
                </div>
            </div>

            <canvas id="rev" height="100"></canvas>
            <canvas id="ord" height="100"></canvas>
            <canvas id="usr" height="100"></canvas>
        </div>

        <script>
            const api = '<c:url value="/admin/statistic"/>?action=json';

            const chartConfig = (id, label, color) => new Chart(document.getElementById(id), {
                type: 'line',
                data: { labels: [], datasets: [{ label: label, data: [], borderColor: color, backgroundColor: color + '22', fill: true, tension: 0.3 }] },
                options: { responsive: true, plugins: { title: { display: true, text: label } }, scales: { y: { beginAtZero: true } } }
            });

            const revChart = chartConfig('rev', 'Doanh thu (VNĐ)', '#28a745');
            const ordChart = chartConfig('ord', 'Số lượng đơn hàng', '#007bff');
            const usrChart = chartConfig('usr', 'Người đăng ký mới', '#ffc107');

            function ymdLocal(dt) {
                return dt.toISOString().split('T')[0];
            }

            function daysRangeLocal(fromStr, toStr) {
                let out = [], d = new Date(fromStr), to = new Date(toStr);
                while (d <= to) {
                    out.push(ymdLocal(d));
                    d.setDate(d.getDate() + 1);
                }
                return out;
            }

            function toMapObj(arr) {
                let m = new Map();
                (arr || []).forEach(x => m.set(x.date, x.value || 0));
                return m;
            }

            async function load(params) {
                try {
                    let url = api + '&' + new URLSearchParams(params);
                    let res = await fetch(url);
                    let data = await res.json();

                    let labels = daysRangeLocal(data.from, data.to);
                    let maps = [toMapObj(data.revenueByDay), toMapObj(data.ordersByDay), toMapObj(data.newUsersByDay)];
                    let charts = [revChart, ordChart, usrChart];

                    charts.forEach((chart, i) => {
                        chart.data.labels = labels;
                        chart.data.datasets[0].data = labels.map(d => maps[i].get(d) || 0);
                        chart.update();
                    });

                    document.getElementById('totalRev').innerText = (data.totals.revenue || 0).toLocaleString('vi-VN') + ' ₫';
                    document.getElementById('totalOrd').innerText = data.totals.orders || 0;
                    document.getElementById('totalUsr').innerText = data.totals.users || 0;

                    document.getElementById('from').value = data.from;
                    document.getElementById('to').value = data.to;

                } catch (e) {
                    console.error("Lỗi khi tải dữ liệu:", e);
                }
            }

            document.getElementById('apply').onclick = () => {
                let preset = document.getElementById('preset').value;
                let f = document.getElementById('from').value;
                let t = document.getElementById('to').value;

                if (preset) load({ range: preset });
                else if (f && t) load({ from: f, to: t });
                else alert('Vui lòng chọn khoảng thời gian!');
            };

            load({ range: 'this_month' });
        </script>
    </body>
</html>