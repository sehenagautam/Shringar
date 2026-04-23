package com.java_web_app.model;

import java.time.LocalDate;

public class User {

    private int userId;
    private String name;
    private String email;
    private String phone;
    private String password;
    private String passwordHash;
    private LocalDate dateOfBirth;
    private String status;
    private String membershipLevel;
    private Integer memberSinceYear;
    private String preferredServices;
    private String image;

    public User() {
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

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

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPasswordHash() {
        return passwordHash;
    }

    public void setPasswordHash(String passwordHash) {
        this.passwordHash = passwordHash;
    }

    public LocalDate getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(LocalDate dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getMembershipLevel() {
        return membershipLevel;
    }

    public void setMembershipLevel(String membershipLevel) {
        this.membershipLevel = membershipLevel;
    }

    public Integer getMemberSinceYear() {
        return memberSinceYear;
    }

    public void setMemberSinceYear(Integer memberSinceYear) {
        this.memberSinceYear = memberSinceYear;
    }

    public String getPreferredServices() {
        return preferredServices;
    }

    public void setPreferredServices(String preferredServices) {
        this.preferredServices = preferredServices;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }
}
