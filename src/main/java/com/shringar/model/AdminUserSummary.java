package com.shringar.model;

public class AdminUserSummary {

    private String name;
    private String email;
    private String phone;
    private String status;
    private String joinedDisplay;
    private String membershipLevel;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
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

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getJoinedDisplay() {
        return joinedDisplay;
    }

    public void setJoinedDisplay(String joinedDisplay) {
        this.joinedDisplay = joinedDisplay;
    }

    public String getMembershipLevel() {
        return membershipLevel;
    }

    public void setMembershipLevel(String membershipLevel) {
        this.membershipLevel = membershipLevel;
    }
}
