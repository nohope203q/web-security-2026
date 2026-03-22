package service;

import model.ChatConversation;
import model.ChatMessage;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import java.util.stream.Collectors;
import java.util.stream.Stream;
import model.Announcement;
import model.Product;
import data.AnnouncementDAO;
import data.ProductDAO;
import org.json.JSONObject;
import org.json.JSONArray;

public class ChatbotService {

    private static final String GROQ_API_KEY = loadApiKey();
    private static final String GROQ_URL = "https://api.groq.com/openai/v1/chat/completions";
    private static final String GROQ_MODEL = "llama-3.3-70b-versatile"; // Đổi model tại đây nếu cần

    private final List<ChatMessage> conversationHistory = new ArrayList<>();

    private static String loadApiKey() {
        try (InputStream is = ChatbotService.class.getClassLoader()
                .getResourceAsStream("config.properties")) {
            if (is == null) {
                throw new RuntimeException(
                    "Không tìm thấy file config.properties. " +
                    "Hãy tạo file src/main/resources/config.properties với nội dung: " +
                    "groq.api.key=YOUR_KEY_HERE"
                );
            }
            Properties props = new Properties();
            props.load(is);
            String key = props.getProperty("groq.api.key");
            if (key == null || key.isBlank()) {
                throw new RuntimeException("groq.api.key chưa được cấu hình trong config.properties");
            }
            return key.trim();
        } catch (IOException e) {
            throw new RuntimeException("Không đọc được API key: " + e.getMessage());
        }
    }

    // -------------------------------------------------------
    // Gửi tin nhắn và trả về phản hồi AI
    // -------------------------------------------------------
    public String sendMessage(int userId, String content) {
        ChatConversation conversation = new ChatConversation(1, userId);
        ChatMessage userMsg = new ChatMessage(1, conversation.getId(), "user", content);
        conversation.addMessage(userMsg);
        conversationHistory.add(userMsg);

        String dbContext = findRelevantProductInfo(content);
        String announcementContext = findRelevantAnnouncements(content);
        String fullDbContext = Stream.of(dbContext, announcementContext)
                .filter(s -> s != null && !s.isEmpty())
                .collect(Collectors.joining("\n\n"));

        String aiReplyContent = callAIAPI(fullDbContext);

        ChatMessage aiMsg = new ChatMessage(2, conversation.getId(), "model", aiReplyContent);
        conversation.addMessage(aiMsg);
        conversationHistory.add(aiMsg);

        return aiReplyContent;
    }

    // -------------------------------------------------------
    // Xây dựng payload theo chuẩn OpenAI và gọi Groq
    // -------------------------------------------------------
    private String callAIAPI(String contextFromDB) {
        try {
            String baseContext = loadChatContext();
            String fullContext = baseContext;
            if (contextFromDB != null && !contextFromDB.isEmpty()) {
                fullContext += "\n\n" + contextFromDB;
            }

            JSONArray messages = new JSONArray();

            // System message (context + DB info)
            messages.put(new JSONObject()
                    .put("role", "system")
                    .put("content", fullContext));

            for (ChatMessage msg : conversationHistory) {
                String role = msg.getSender().equals("model") ? "assistant" : msg.getSender();
                messages.put(new JSONObject()
                        .put("role", role)
                        .put("content", msg.getContent()));
            }

            JSONObject payload = new JSONObject();
            payload.put("model", GROQ_MODEL);
            payload.put("messages", messages);
            payload.put("max_tokens", 1024);
            payload.put("temperature", 0.7);

            return callGroqAPI(payload.toString());

        } catch (Exception e) {
            e.printStackTrace();
            return "❌ Lỗi khi xử lý AI: " + e.getMessage();
        }
    }

    private String callGroqAPI(String jsonPayload) throws IOException {
        URL url = new URL(GROQ_URL);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Content-Type", "application/json; utf-8");
        conn.setRequestProperty("Authorization", "Bearer " + GROQ_API_KEY);
        conn.setDoOutput(true);

        try (OutputStream os = conn.getOutputStream()) {
            os.write(jsonPayload.getBytes(StandardCharsets.UTF_8));
        }

        int responseCode = conn.getResponseCode();
        InputStream inputStream = (responseCode >= 200 && responseCode < 300)
                ? conn.getInputStream()
                : conn.getErrorStream();

        StringBuilder response = new StringBuilder();
        try (BufferedReader br = new BufferedReader(
                new InputStreamReader(inputStream, StandardCharsets.UTF_8))) {
            String line;
            while ((line = br.readLine()) != null) response.append(line.trim());
        }
        conn.disconnect();

        return parseGroqReply(response.toString());
    }

    private String parseGroqReply(String jsonResponse) {
        try {
            JSONObject responseObject = new JSONObject(jsonResponse);

            if (responseObject.has("error")) {
                String errorMessage = responseObject.getJSONObject("error").getString("message");
                return "❌ Groq API báo lỗi: " + errorMessage;
            }

            JSONArray choices = responseObject.getJSONArray("choices");
            if (choices.length() > 0) {
                return choices.getJSONObject(0)
                        .getJSONObject("message")
                        .getString("content");
            }

            return "🤖 Không tìm thấy nội dung trả lời trong response.";

        } catch (Exception e) {
            e.printStackTrace();
            return "🤖 Lỗi khi đọc phản hồi từ Groq: " + jsonResponse;
        }
    }


    private String loadChatContext() {
        try (InputStream is = getClass().getClassLoader().getResourceAsStream("chat_context.txt")) {
            if (is == null) {
                System.err.println("Không tìm thấy file chat_context.txt, dùng context mặc định.");
                return getDefaultContext();
            }
            try (BufferedReader reader = new BufferedReader(
                    new InputStreamReader(is, StandardCharsets.UTF_8))) {
                StringBuilder sb = new StringBuilder();
                String line;
                while ((line = reader.readLine()) != null) sb.append(line).append("\n");
                return sb.toString().trim();
            }
        } catch (IOException e) {
            e.printStackTrace();
            return getDefaultContext();
        }
    }

    private String getDefaultContext() {
        return "Bạn là một trợ lý ảo tư vấn bán hàng cho một cửa hàng công nghệ. " +
               "Hãy trả lời câu hỏi của khách hàng một cách ngắn gọn, thân thiện và chuyên nghiệp.";
    }

    private String findRelevantProductInfo(String userMessage) {
        String[] keywords = userMessage.split("\\s+");
        List<Product> relevantProducts = new ArrayList<>();
        ProductDAO productDAO = new ProductDAO();

        for (String keyword : keywords) {
            if (keyword.length() > 2
                    && !keyword.equalsIgnoreCase("giá")
                    && !keyword.equalsIgnoreCase("bao nhiêu")) {
                List<Product> found = productDAO.searchProducts(keyword);
                if (found != null) relevantProducts.addAll(found);
            }
        }

        List<Product> distinctProducts = relevantProducts.stream()
                .distinct()
                .collect(Collectors.toList());

        if (distinctProducts.isEmpty()) return "";

        StringBuilder contextBuilder = new StringBuilder();
        contextBuilder.append("Dưới đây là thông tin sản phẩm từ CSDL có thể liên quan, hãy dựa vào đây để trả lời:\n\n");
        for (Product p : distinctProducts) {
            contextBuilder.append("---")
                    .append("\nTên sản phẩm: ").append(p.getName())
                    .append("\nThương hiệu: ").append(p.getBrand())
                    .append("\nGiá bán: ").append(p.getPrice())
                    .append("\nSố lượng còn lại: ").append(p.getQuantity())
                    .append("\nMô tả ngắn: ").append(p.getDescription()).append("\n\n");
        }
        return contextBuilder.toString();
    }

    private String findRelevantAnnouncements(String userMessage) {
        String[] keywords = userMessage.toLowerCase().split("\\s+");
        List<Announcement> relevantAnnouncements = new ArrayList<>();
        AnnouncementDAO announcementDAO = new AnnouncementDAO();

        for (String keyword : keywords) {
            if (keyword.length() > 2
                    && !keyword.equalsIgnoreCase("có")
                    && !keyword.equalsIgnoreCase("không")) {
                List<Announcement> found = announcementDAO.getAllAnnouncements();
                if (found != null) relevantAnnouncements.addAll(found);
            }
        }

        List<Announcement> distinctAnnouncements = relevantAnnouncements.stream()
                .distinct()
                .collect(Collectors.toList());

        if (distinctAnnouncements.isEmpty()) return "";

        StringBuilder contextBuilder = new StringBuilder();
        contextBuilder.append("Thông tin về các chương trình khuyến mãi, voucher có thể liên quan:\n");
        for (Announcement a : distinctAnnouncements) {
            contextBuilder.append("- Tiêu đề: ").append(a.getTitle())
                    .append(" (Hiệu lực đến ngày ").append(a.getEndDate()).append(")")
                    .append("\n  Nội dung: ").append(a.getContent()).append("\n");
        }
        return contextBuilder.toString();
    }

    public void clearConversation() {
        conversationHistory.clear();
    }
}