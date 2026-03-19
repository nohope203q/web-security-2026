package controllerUser;

import service.ChatbotService;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import org.json.JSONObject;

@WebServlet("/client/chat")
public class ChatServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");

        HttpSession session = request.getSession();
        ChatbotService chatbotService = (ChatbotService) session.getAttribute("chatbot");
        if (chatbotService == null) {
            chatbotService = new ChatbotService();
            session.setAttribute("chatbot", chatbotService);
        }

        StringBuilder sb = new StringBuilder();
        BufferedReader reader = request.getReader();
        String line;
        while ((line = reader.readLine()) != null) {
            sb.append(line);
        }

        JSONObject jsonRequest = new JSONObject(sb.toString());
        String userMessage = jsonRequest.getString("message");

        String aiReplyContent;

        if ("reset".equalsIgnoreCase(userMessage)) {
            chatbotService.clearConversation();
            aiReplyContent = "🔄 Cuộc hội thoại đã được đặt lại!";
        } else {
            aiReplyContent = chatbotService.sendMessage(1, userMessage);
        }

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        JSONObject jsonResponse = new JSONObject();
        jsonResponse.put("answer", aiReplyContent);

        PrintWriter out = response.getWriter();
        out.print(jsonResponse.toString());
        out.flush();
    }
}
