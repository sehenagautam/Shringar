package com.shringar.model;

public class AdminServiceSummary {

    private String serviceName;
    private String category;
    private String stylistName;
    private int bookingsCount;
    private String revenueDisplay;

    public String getServiceName() {
        return serviceName;
    }

    public void setServiceName(String serviceName) {
        this.serviceName = serviceName;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getStylistName() {
        return stylistName;
    }

    public void setStylistName(String stylistName) {
        this.stylistName = stylistName;
    }

    public int getBookingsCount() {
        return bookingsCount;
    }

    public void setBookingsCount(int bookingsCount) {
        this.bookingsCount = bookingsCount;
    }

    public String getRevenueDisplay() {
        return revenueDisplay;
    }

    public void setRevenueDisplay(String revenueDisplay) {
        this.revenueDisplay = revenueDisplay;
    }
}
