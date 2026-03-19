
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<style>
    .chatbot-container {
        position: fixed;
        bottom: 20px;
        right: 20px;
        z-index: 1000;
    }
    .chatbot-button {
        width: 60px;
        height: 60px;
        border-radius: 50%;
        background-color: #607D8B;
        color: white;
        border: none;
        box-shadow: 0 4px 8px rgba(0,0,0,0.2);
        cursor: pointer;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 24px;
    }
    .chatbot-window {
        position: absolute;
        bottom: 70px;
        right: 0;
        width: 350px;
        height: 450px;
        background-color: white;
        border-radius: 10px;
        box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        display: none;
        flex-direction: column;
        overflow: hidden;
    }
    .chatbot-header {
        background-color: #607D8B;
        color: white;
        padding: 15px;
        font-weight: bold;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    .chatbot-messages {
        flex: 1;
        padding: 15px;
        overflow-y: auto;
        display: flex;
        flex-direction: column;
    }
    .message {
        max-width: 80%;
        padding: 10px;
        margin-bottom: 10px;
        border-radius: 10px;
        word-wrap: break-word;
    }
    .user-message {
        align-self: flex-end;
        background-color: #e3f2fd;
    }
    .bot-message {
        align-self: flex-start;
        background-color: #f5f5f5;
    }
    .chatbot-input {
        display: flex;
        padding: 10px;
        border-top: 1px solid #eee;
    }
    .chatbot-input input {
        flex: 1;
        padding: 10px;
        border: 1px solid #ddd;
        border-radius: 20px;
        margin-right: 10px;
    }
    .chatbot-input button {
        background-color: #607D8B;
        color: white;
        border: none;
        border-radius: 20px;
        padding: 0 15px;
        cursor: pointer;
    }
    .close-chatbot {
        background: none;
        border: none;
        color: white;
        font-size: 18px;
        cursor: pointer;
    }
</style>

<div class="chatbot-container">
    <a href="client/chatbox.jsp">
        <button class="chatbot-button" id="chatbotToggle"><i class="fas fa-robot"></i></button>
    </a>
</div>

<%-- File: /client/footer/footer.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%-- Đảm bảo bạn đã thêm Font Awesome vào trang của mình để hiển thị icon --%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"> 

<footer class="site-footer">
    <div class="container">
        <div class="row">
            <%-- Cột 1: Giới thiệu ngắn & Logo --%>
            <div class="col-lg-4 col-md-6 mb-4 mb-lg-0">
                <h5 class="footer-heading">TechStore</h5>
                <p class="text-muted">Nơi cung cấp các sản phẩm công nghệ chính hãng, uy tín với mức giá tốt nhất. Chúng tôi cam kết mang đến trải nghiệm mua sắm tuyệt vời cho khách hàng.</p>
            </div>

            <%-- Cột 2: Các liên kết nhanh --%>
            <div class="col-lg-2 col-md-6 mb-4 mb-lg-0">
                <h5 class="footer-heading">Khám Phá</h5>
                <ul class="list-unstyled footer-links">
                    <li><a href="${pageContext.request.contextPath}/home">Trang Chủ</a></li>
                    <li><a href="#">Sản Phẩm</a></li>
                    <li><a href="#">Về Chúng Tôi</a></li>
                    <li><a href="#">Liên Hệ</a></li>
                    <li><a href="#">Blog Công Nghệ</a></li>
                </ul>
            </div>

            <%-- Cột 3: Chính sách & Hỗ trợ --%>
            <div class="col-lg-3 col-md-6 mb-4 mb-lg-0">
                <h5 class="footer-heading">Hỗ Trợ Khách Hàng</h5>
                <ul class="list-unstyled footer-links">
                    <li><a href="#">Chính Sách Bảo Mật</a></li>
                    <li><a href="#">Điều Khoản Dịch Vụ</a></li>
                    <li><a href="#">Chính Sách Đổi Trả</a></li>
                    <li><a href="#">Hướng Dẫn Mua Hàng</a></li>
                    <li><a href="#">Câu Hỏi Thường Gặp</a></li>
                </ul>
            </div>

            <%-- Cột 4: Thông tin liên hệ & Mạng xã hội --%>
            <div class="col-lg-3 col-md-6">
                <h5 class="footer-heading">Liên Hệ</h5>
                <ul class="list-unstyled contact-info">
                    <li class="d-flex align-items-start">
                        <i class="fas fa-map-marker-alt me-3 pt-1"></i>
                        <span>Số 1 Võ Văn Ngân, Thủ Đức, TPHCM</span>
                    </li>
                    <li class="d-flex align-items-center">
                        <i class="fas fa-phone me-3"></i>
                        <a href="tel://19001234">1900 1234</a>
                    </li>
                    <li class="d-flex align-items-center">
                        <i class="fas fa-envelope me-3"></i>
                        <a href="mailto:support@techstore.com">support@techstore.com</a>
                    </li>
                </ul>
                <div class="social-icons mt-3">
                    <a href="#" class="social-icon"><i class="fab fa-facebook-f"></i></a>
                    <a href="#" class="social-icon"><i class="fab fa-youtube"></i></a>
                    <a href="#" class="social-icon"><i class="fab fa-instagram"></i></a>
                    <a href="#" class="social-icon"><i class="fab fa-tiktok"></i></a>
                </div>
            </div>
        </div>

        <hr>

        <div class="row">
            <div class="col-md-12 text-center">
                <p class="copyright-text">
                    &copy; ${java.time.Year.now().getValue()} TechStore. All Rights Reserved.
                </p>
            </div>
        </div>
    </div>
</footer>



<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/7.2.0/mdb.umd.min.js"></script>

</body>
</html>