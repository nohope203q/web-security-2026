package model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class ChatConversation {

    private int id;
    private int userId;
    private Date startedAt;
    private Date endedAt;
    private List<ChatMessage> messages = new ArrayList<>();

    public ChatConversation() {
        this.startedAt = new Date();
    }

    public ChatConversation(int id, int userId) {
        this.id = id;
        this.userId = userId;
        this.startedAt = new Date();
    }

    public int getId() {
        return id;
    }

    public int getUserId() {
        return userId;
    }

    public Date getStartedAt() {
        return startedAt;
    }

    public Date getEndedAt() {
        return endedAt;
    }

    public List<ChatMessage> getMessages() {
        return messages;
    }

    public void addMessage(ChatMessage message) {
        this.messages.add(message);
    }
}
