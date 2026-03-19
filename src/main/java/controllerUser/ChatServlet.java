package controllerUser;

import service.ChatbotService;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import org.json.JSONObject; // Nhớ import thư viện JSON

@WebServlet("/client/chat")
public class ChatServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ✅ Đặt charset TRƯỚC khi đọc dữ liệu
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");

        // --- PHẦN SESSION GIỮ NGUYÊN, VÌ NÓ RẤT TỐT ---
        HttpSession session = request.getSession();
        ChatbotService chatbotService = (ChatbotService) session.getAttribute("chatbot");
        if (chatbotService == null) {
            chatbotService = new ChatbotService();
            session.setAttribute("chatbot", chatbotService);
        }

        // --- SỬA CÁCH ĐỌC REQUEST ĐỂ NHẬN JSON ---
        StringBuilder sb = new StringBuilder();
        BufferedReader reader = request.getReader();
        String line;
        while ((line = reader.readLine()) != null) {
            sb.append(line);
        }

        JSONObject jsonRequest = new JSONObject(sb.toString());
        String userMessage = jsonRequest.getString("message"); // Lấy message từ JSON

        String aiReplyContent;

        // Phần logic reset và gửi tin nhắn giữ nguyên
        if ("reset".equalsIgnoreCase(userMessage)) {
            chatbotService.clearConversation();
            aiReplyContent = "🔄 Cuộc hội thoại đã được đặt lại!";
        } else {
            // Giả sử sendMessage trả về một đối tượng có getContent()
            // Hoặc đơn giản là trả về String
            // ChatMessage aiReply = chatbotService.sendMessage(1, userMessage);
            // aiReplyContent = aiReply.getContent();

            // Ví dụ nếu sendMessage chỉ trả về String
            aiReplyContent = chatbotService.sendMessage(1, userMessage);
        }

        // --- SỬA CÁCH TRẢ VỀ RESPONSE, TRẢ VỀ JSON THAY VÌ FORWARD ---
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        JSONObject jsonResponse = new JSONObject();
        jsonResponse.put("answer", aiReplyContent);

        PrintWriter out = response.getWriter();
        out.print(jsonResponse.toString());
        out.flush();
    }
}
