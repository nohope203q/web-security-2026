package service;

import model.ChatConversation;
import model.ChatMessage;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;
import model.Announcement;
import model.Product;
import data.AnnouncementDAO;
import data.ProductDAO;
import org.json.JSONObject;
import org.json.JSONArray;

public class ChatbotService {

    private static final String GEMINI_API_KEY = "AIzaSyB2weNrBEpHMD-N5F-SVxJFpyeLytHzQLk"; // 🔑 thay bằng key thật của bạn
    private static final String GEMINI_URL
            = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=" + GEMINI_API_KEY;

    private final List<ChatMessage> conversationHistory = new ArrayList<>();

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

        return aiReplyContent; // Trả về String để Servlet có thể dùng ngay
    }

    private String callAIAPI(String contextFromDB) {
        try {
            String baseContext = loadChatContext();
            JSONObject payload = new JSONObject();
            JSONArray contents = new JSONArray();

            // Thêm lịch sử trò chuyện vào payload
            for (ChatMessage msg : conversationHistory) {
                JSONObject messageContent = new JSONObject();
                messageContent.put("role", msg.getSender()); // "user" hoặc "model"
                messageContent.put("parts", new JSONArray().put(new JSONObject().put("text", msg.getContent())));
                contents.put(messageContent);
            }

            payload.put("contents", contents);

            // Xây dựng system_instruction: Kết hợp context mặc định và context từ DB
            JSONObject systemInstruction = new JSONObject();
            JSONArray parts = new JSONArray();
            String fullContext = baseContext;
            if (contextFromDB != null && !contextFromDB.isEmpty()) {
                fullContext += "\n\n" + contextFromDB;
            }
            parts.put(new JSONObject().put("text", fullContext));
            systemInstruction.put("parts", parts);

            payload.put("system_instruction", systemInstruction);

            return callGeminiAPI(payload.toString());

        } catch (Exception e) {
            e.printStackTrace();
            return "❌ Lỗi khi xử lý AI: " + e.getMessage();
        }
    }

    private String callGeminiAPI(String jsonPayload) throws IOException {
        URL url = new URL(GEMINI_URL);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Content-Type", "application/json; utf-8");
        conn.setDoOutput(true);

        try (OutputStream os = conn.getOutputStream()) {
            byte[] input = jsonPayload.getBytes(StandardCharsets.UTF_8);
            os.write(input, 0, input.length);
        }

        int responseCode = conn.getResponseCode();
        InputStream inputStream = (responseCode >= 200 && responseCode < 300) ? conn.getInputStream() : conn.getErrorStream();

        StringBuilder response = new StringBuilder();
        try (BufferedReader br = new BufferedReader(new InputStreamReader(inputStream, StandardCharsets.UTF_8))) {
            String responseLine;
            while ((responseLine = br.readLine()) != null) {
                response.append(responseLine.trim());
            }
        }
        conn.disconnect();

        return parseGeminiReply(response.toString());
    }

    private String loadChatContext() {
        try (InputStream is = getClass().getClassLoader().getResourceAsStream("chat_context.txt")) {
            if (is == null) {
                System.err.println("Không tìm thấy file chat_context.txt, dùng context mặc định.");
                return getDefaultContext();
            }
            try (BufferedReader reader = new BufferedReader(new InputStreamReader(is, StandardCharsets.UTF_8))) {
                StringBuilder sb = new StringBuilder();
                String line;
                while ((line = reader.readLine()) != null) {
                    sb.append(line).append("\n");
                }
                return sb.toString().trim();
            }
        } catch (IOException e) {
            e.printStackTrace();
            return getDefaultContext();
        }
    }

    private String getDefaultContext() {
        return "Bạn là một trợ lý ảo tư vấn bán hàng cho một cửa hàng công nghệ. Hãy trả lời câu hỏi của khách hàng một cách ngắn gọn, thân thiện và chuyên nghiệp.";
    }

    private String parseGeminiReply(String jsonResponse) {
        try {
            JSONObject responseObject = new JSONObject(jsonResponse);

            if (responseObject.has("error")) {
                String errorMessage = responseObject.getJSONObject("error").getString("message");
                return "❌ API Gemini báo lỗi: " + errorMessage;
            }

            JSONArray candidates = responseObject.getJSONArray("candidates");
            if (candidates.length() > 0) {
                JSONObject content = candidates.getJSONObject(0).getJSONObject("content");
                JSONArray parts = content.getJSONArray("parts");
                if (parts.length() > 0) {
                    return parts.getJSONObject(0).getString("text");
                }
            }
            return "🤖 Không tìm thấy nội dung trả lời trong response.";
        } catch (Exception e) {
            e.printStackTrace();
            return "🤖 Lỗi khi đọc phản hồi từ Gemini: " + jsonResponse;
        }
    }

    public void clearConversation() {
        conversationHistory.clear();
    }

    // Bên trong file ChatbotService.java
    private String findRelevantProductInfo(String userMessage) {
        // Phần tách keyword vẫn giữ nguyên

        String[] keywords = userMessage.split("\\s+");
        List<Product> relevantProducts = new ArrayList<>();
        ProductDAO productDAO = new ProductDAO();
        for (String keyword : keywords) {
            if (keyword.length() > 2 && !keyword.equalsIgnoreCase("giá") && !keyword.equalsIgnoreCase("bao nhiêu")) {
                List<Product> found = productDAO.searchProducts(keyword);
                if (found != null) {
                    relevantProducts.addAll(found);
                }
            }
        }

        // Loại bỏ các sản phẩm trùng lặp bằng hàm equals/hashCode đã tạo ở Product.java
        List<Product> distinctProducts = relevantProducts.stream()
                .distinct()
                .collect(Collectors.toList());

        if (distinctProducts.isEmpty()) {
            return ""; // Không tìm thấy sản phẩm nào
        }

        // ✅ ĐỊNH DẠNG LẠI CONTEXT: Cung cấp nhiều thông tin hơn cho AI
        StringBuilder contextBuilder = new StringBuilder();
        contextBuilder.append("Dưới đây là thông tin sản phẩm từ CSDL có thể liên quan, hãy dựa vào đây để trả lời:\n\n");
        for (Product p : distinctProducts) {
            contextBuilder.append("---")
                    .append("\nTên sản phẩm: ").append(p.getName())
                    .append("\nThương hiệu: ").append(p.getBrand())
                    .append("\nGiá bán: ").append(p.getPrice()) // Dùng hàm định dạng tiền
                    .append("\nSố lượng còn lại: ").append(p.getQuantity())
                    .append("\nMô tả ngắn: ").append(p.getDescription()).append("\n\n");
        }
        return contextBuilder.toString();
    }

    private String findRelevantAnnouncements(String userMessage) {
        // Tách câu hỏi của người dùng thành từng từ khóa
        String[] keywords = userMessage.toLowerCase().split("\\s+");
        List<Announcement> relevantAnnouncements = new ArrayList<>();

        AnnouncementDAO announcementDAO = new AnnouncementDAO();
        for (String keyword : keywords) {
            // Bỏ qua mấy từ ngắn hoặc quá chung chung
            if (keyword.length() > 2 && !keyword.equalsIgnoreCase("có") && !keyword.equalsIgnoreCase("không")) {
                // Gọi DAO với từ khóa cụ thể (ví dụ: "sinh viên")
                List<Announcement> found = announcementDAO.getAllAnnouncements();
                if (found != null) {
                    relevantAnnouncements.addAll(found);
                }
            }
        }

        // Loại bỏ các kết quả bị trùng lặp
        List<Announcement> distinctAnnouncements = relevantAnnouncements.stream()
                .distinct()
                .collect(Collectors.toList());

        if (distinctAnnouncements.isEmpty()) {
            return ""; // Không tìm thấy gì thì thôi
        }

        // Định dạng lại thông tin tìm được để gửi cho AI
        StringBuilder contextBuilder = new StringBuilder();
        contextBuilder.append("Thông tin về các chương trình khuyến mãi, voucher có thể liên quan:\n");
        for (Announcement a : distinctAnnouncements) {
            contextBuilder.append("- Tiêu đề: ").append(a.getTitle())
                    .append(" (Hiệu lực đến ngày ").append(a.getEndDate()).append(")")
                    .append("\n  Nội dung: ").append(a.getContent()).append("\n");
        }
        return contextBuilder.toString();
    }
}
