package com.shringar.model;

import java.util.ArrayList;
import java.util.List;

public class AdminDashboardData {

    private String adminDisplayName;
    private String generatedAtDisplay;
    private int totalUsers;
    private int approvedUsers;
    private int pendingUsers;
    private int totalBookings;
    private int totalServices;
    private int totalMessages;
    private int pendingRequests;
    private int distinctCategories;
    private String totalRevenueDisplay;
    private String bookingTrendLabel;
    private String bookingTrendDirection;
    private String userTrendLabel;
    private String userTrendDirection;
    private String revenueTrendLabel;
    private String revenueTrendDirection;
    private String requestTrendLabel;
    private String requestTrendDirection;
    private String messageTrendLabel;
    private String messageTrendDirection;
    private AdminReportSection monthlyReport;
    private AdminReportSection yearlyReport;
    private final List<AdminServiceSummary> topServices = new ArrayList<>();
    private final List<AdminBookingSummary> recentBookings = new ArrayList<>();
    private final List<AdminUserSummary> recentUsers = new ArrayList<>();
    private final List<ContactMessage> recentMessages = new ArrayList<>();

    public String getAdminDisplayName() {
        return adminDisplayName;
    }

    public void setAdminDisplayName(String adminDisplayName) {
        this.adminDisplayName = adminDisplayName;
    }

    public String getGeneratedAtDisplay() {
        return generatedAtDisplay;
    }

    public void setGeneratedAtDisplay(String generatedAtDisplay) {
        this.generatedAtDisplay = generatedAtDisplay;
    }

    public int getTotalUsers() {
        return totalUsers;
    }

    public void setTotalUsers(int totalUsers) {
        this.totalUsers = totalUsers;
    }

    public int getApprovedUsers() {
        return approvedUsers;
    }

    public void setApprovedUsers(int approvedUsers) {
        this.approvedUsers = approvedUsers;
    }

    public int getPendingUsers() {
        return pendingUsers;
    }

    public void setPendingUsers(int pendingUsers) {
        this.pendingUsers = pendingUsers;
    }

    public int getTotalBookings() {
        return totalBookings;
    }

    public void setTotalBookings(int totalBookings) {
        this.totalBookings = totalBookings;
    }

    public int getTotalServices() {
        return totalServices;
    }

    public void setTotalServices(int totalServices) {
        this.totalServices = totalServices;
    }

    public int getTotalMessages() {
        return totalMessages;
    }

    public void setTotalMessages(int totalMessages) {
        this.totalMessages = totalMessages;
    }

    public int getPendingRequests() {
        return pendingRequests;
    }

    public void setPendingRequests(int pendingRequests) {
        this.pendingRequests = pendingRequests;
    }

    public int getDistinctCategories() {
        return distinctCategories;
    }

    public void setDistinctCategories(int distinctCategories) {
        this.distinctCategories = distinctCategories;
    }

    public String getTotalRevenueDisplay() {
        return totalRevenueDisplay;
    }

    public void setTotalRevenueDisplay(String totalRevenueDisplay) {
        this.totalRevenueDisplay = totalRevenueDisplay;
    }

    public String getBookingTrendLabel() {
        return bookingTrendLabel;
    }

    public void setBookingTrendLabel(String bookingTrendLabel) {
        this.bookingTrendLabel = bookingTrendLabel;
    }

    public String getBookingTrendDirection() {
        return bookingTrendDirection;
    }

    public void setBookingTrendDirection(String bookingTrendDirection) {
        this.bookingTrendDirection = bookingTrendDirection;
    }

    public String getUserTrendLabel() {
        return userTrendLabel;
    }

    public void setUserTrendLabel(String userTrendLabel) {
        this.userTrendLabel = userTrendLabel;
    }

    public String getUserTrendDirection() {
        return userTrendDirection;
    }

    public void setUserTrendDirection(String userTrendDirection) {
        this.userTrendDirection = userTrendDirection;
    }

    public String getRevenueTrendLabel() {
        return revenueTrendLabel;
    }

    public void setRevenueTrendLabel(String revenueTrendLabel) {
        this.revenueTrendLabel = revenueTrendLabel;
    }

    public String getRevenueTrendDirection() {
        return revenueTrendDirection;
    }

    public void setRevenueTrendDirection(String revenueTrendDirection) {
        this.revenueTrendDirection = revenueTrendDirection;
    }

    public String getRequestTrendLabel() {
        return requestTrendLabel;
    }

    public void setRequestTrendLabel(String requestTrendLabel) {
        this.requestTrendLabel = requestTrendLabel;
    }

    public String getRequestTrendDirection() {
        return requestTrendDirection;
    }

    public void setRequestTrendDirection(String requestTrendDirection) {
        this.requestTrendDirection = requestTrendDirection;
    }

    public String getMessageTrendLabel() {
        return messageTrendLabel;
    }

    public void setMessageTrendLabel(String messageTrendLabel) {
        this.messageTrendLabel = messageTrendLabel;
    }

    public String getMessageTrendDirection() {
        return messageTrendDirection;
    }

    public void setMessageTrendDirection(String messageTrendDirection) {
        this.messageTrendDirection = messageTrendDirection;
    }

    public AdminReportSection getMonthlyReport() {
        return monthlyReport;
    }

    public void setMonthlyReport(AdminReportSection monthlyReport) {
        this.monthlyReport = monthlyReport;
    }

    public AdminReportSection getYearlyReport() {
        return yearlyReport;
    }

    public void setYearlyReport(AdminReportSection yearlyReport) {
        this.yearlyReport = yearlyReport;
    }

    public List<AdminServiceSummary> getTopServices() {
        return topServices;
    }

    public List<AdminBookingSummary> getRecentBookings() {
        return recentBookings;
    }

    public List<AdminUserSummary> getRecentUsers() {
        return recentUsers;
    }

    public List<ContactMessage> getRecentMessages() {
        return recentMessages;
    }
}
