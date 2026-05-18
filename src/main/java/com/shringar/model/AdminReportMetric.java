package com.shringar.model;

public class AdminReportMetric {

    private String label;
    private String currentValue;
    private String previousValue;
    private String changeLabel;
    private String direction;

    public String getLabel() {
        return label;
    }

    public void setLabel(String label) {
        this.label = label;
    }

    public String getCurrentValue() {
        return currentValue;
    }

    public void setCurrentValue(String currentValue) {
        this.currentValue = currentValue;
    }

    public String getPreviousValue() {
        return previousValue;
    }

    public void setPreviousValue(String previousValue) {
        this.previousValue = previousValue;
    }

    public String getChangeLabel() {
        return changeLabel;
    }

    public void setChangeLabel(String changeLabel) {
        this.changeLabel = changeLabel;
    }

    public String getDirection() {
        return direction;
    }

    public void setDirection(String direction) {
        this.direction = direction;
    }
}
