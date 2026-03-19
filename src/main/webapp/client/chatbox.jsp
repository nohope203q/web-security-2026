<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>AI Hỗ Trợ Khách Hàng</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"/>

        <style>
            body {
                background: #f2f2f2;
                font-family: "Segoe UI", sans-serif;
            }

            .chat-container {
                width: 400px;
                background: #fff;
                border-radius: 15px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                display: flex;
                flex-direction: column;
                overflow: hidden;
            }

            .chat-header {
                background: #007bff;
                color: white;
                border-top-left-radius: 15px;
                border-top-right-radius: 15px;
            }

            .chat-body {
                height: 420px;
                overflow-y: auto;
                padding: 15px;
                background: #f9f9f9;
                display: block; /* quan trọng: KHÔNG dùng flex */
                color: #000;
            }

            /* Kiểu tin nhắn chung */
            .message {
                display: inline-block;
                margin: 8px 0;
                padding: 8px 12px;
                border-radius: 10px;
                max-width: 80%;
                word-wrap: break-word;
                font-size: 15px;
                clear: both;
            }

            /* Tin nhắn người dùng */
            .user-message {
                background: #007bff;
                color: white;
                float: right;
            }

            /* Tin nhắn bot */
            .bot-message {
                background: #e9ecef;
                color: black;
                float: left;
            }

            .chat-footer {
                background: #fff;
                border-top: 1px solid #ddd;
            }

            .chat-footer input {
                border-radius: 0;
            }

            .chat-footer button {
                border-radius: 0;
            }

            .fa-spinner {
                margin-right: 6px;
            }
        </style>
    </head>

    <body>
        <div class="container d-flex justify-content-center">
            <div class="chat-container mt-5">
                <div class="chat-header p-3 text-center">
                    <h5>Gemini - Hỗ Trợ Sản Phẩm 🤖</h5>
                    <small>Hỏi bất cứ điều gì về sản phẩm của chúng tôi</small>
                </div>

                <div class="chat-body" id="chat-body">
                    <div class="message bot-message">
                        <span>Xin chào! Tôi có thể giúp gì cho bạn?</span>
                    </div>
                </div>

                <div class="chat-footer p-3">
                    <div class="input-group">
                        <input type="text" id="user-input" class="form-control" placeholder="Nhập câu hỏi của bạn..." autocomplete="off">
                        <button class="btn btn-primary" id="send-btn">
                            <i class="fas fa-paper-plane"></i>
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

        <script>
            document.addEventListener("DOMContentLoaded", () => {
                const chatBody = document.getElementById("chat-body");
                const userInput = document.getElementById("user-input");
                const sendBtn = document.getElementById("send-btn");

                // ✅ Hàm hiển thị tin nhắn (có hỗ trợ markdown cơ bản)
                function displayMessage(text, sender) {
                    console.log("📩 displayMessage được gọi với:", text, sender);
                    console.log(chatBody.innerHTML);
                    const messageDiv = document.createElement("div");
                    messageDiv.classList.add("message", sender === "user" ? "user-message" : "bot-message");



                    messageDiv.textContent = text;
                    chatBody.appendChild(messageDiv);
                    chatBody.scrollTop = chatBody.scrollHeight;
                }

                // ✅ Xử lý gửi tin nhắn
                async function handleSendMessage() {
                    const userText = userInput.value.trim();
                    if (userText === "")
                        return;

                    displayMessage(userText, "user");
                    userInput.value = "";

                    // Hiển thị "Đang suy nghĩ..."
                    const typingIndicator = document.createElement("div");
                    typingIndicator.classList.add("message", "bot-message");
                    typingIndicator.innerHTML = `<span><i class="fas fa-spinner fa-pulse"></i> Đang suy nghĩ...</span>`;
                    chatBody.appendChild(typingIndicator);
                    chatBody.scrollTop = chatBody.scrollHeight;

                    try {
                        // 🔗 Gửi yêu cầu đến Servlet /chat
                        const response = await fetch("chat", {
                            method: "POST",
                            headers: {"Content-Type": "application/json"},
                            body: JSON.stringify({message: userText})
                        });

                        // Xóa "Đang suy nghĩ..."
                        chatBody.removeChild(typingIndicator);

                        if (!response.ok) {
                            const errorData = await response.json();
                            throw new Error(errorData.answer || `Lỗi HTTP: ${response.status}`);
                        }

                        const data = await response.json();
                        displayMessage(data.answer, "bot");

                    } catch (error) {
                        console.error("Lỗi khi gửi tin nhắn:", error);
                        if (chatBody.contains(typingIndicator))
                            chatBody.removeChild(typingIndicator);
                        displayMessage(`Xin lỗi, có lỗi xảy ra rồi: ${error.message}`, "bot");
                    }
                }

                // ✅ Gửi tin nhắn khi nhấn nút
                sendBtn.addEventListener("click", handleSendMessage);

                // ✅ Gửi khi nhấn Enter
                userInput.addEventListener("keydown", (event) => {
                    if (event.key === "Enter") {
                        event.preventDefault();
                        handleSendMessage();
                    }
                });
            });
        </script>
    </body>
</html>
