package model;

import java.util.Date;

public class ChatMessage {

    private int id;
    private int conversationId;
    private String sender;
    private String content;
    private Date timestamp;

    public ChatMessage() {
        this.timestamp = new Date();
    }

    public ChatMessage(int id, int conversationId, String sender, String content) {
        this.id = id;
        this.conversationId = conversationId;
        this.sender = sender;
        this.content = content;
        this.timestamp = new Date();
    }

    public int getId() {
        return id;
    }

    public int getConversationId() {
        return conversationId;
    }

    public String getSender() {
        return sender;
    }

    public String getContent() {
        return content;
    }

    public Date getTimestamp() {
        return timestamp;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setConversationId(int conversationId) {
        this.conversationId = conversationId;
    }

    public void setSender(String sender) {
        this.sender = sender;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public void setTimestamp(Date timestamp) {
        this.timestamp = timestamp;
    }

    public String formatMessage() {
        return String.format("[%s] %s: %s", timestamp, sender, content);
    }
}
