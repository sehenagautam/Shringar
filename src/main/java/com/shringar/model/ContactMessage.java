package com.shringar.model;

import java.time.LocalDateTime;

public class ContactMessage {

    private int messageId;
    private String fullName;
    private String email;
    private String phone;
    private String message;
    private LocalDateTime createdAt;
    private String createdAtDisplay;

    public int getMessageId() {
        return messageId;
    }

    public void setMessageId(int messageId) {
        this.messageId = messageId;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public String getCreatedAtDisplay() {
        return createdAtDisplay;
    }

    public void setCreatedAtDisplay(String createdAtDisplay) {
        this.createdAtDisplay = createdAtDisplay;
    }
}
