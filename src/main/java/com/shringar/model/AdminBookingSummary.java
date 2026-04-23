package com.shringar.model;

public class AdminBookingSummary {

    private String customerName;
    private String serviceName;
    private String appointmentDisplay;
    private String status;
    private String amountDisplay;

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getServiceName() {
        return serviceName;
    }

    public void setServiceName(String serviceName) {
        this.serviceName = serviceName;
    }

    public String getAppointmentDisplay() {
        return appointmentDisplay;
    }

    public void setAppointmentDisplay(String appointmentDisplay) {
        this.appointmentDisplay = appointmentDisplay;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getAmountDisplay() {
        return amountDisplay;
    }

    public void setAmountDisplay(String amountDisplay) {
        this.amountDisplay = amountDisplay;
    }
}
