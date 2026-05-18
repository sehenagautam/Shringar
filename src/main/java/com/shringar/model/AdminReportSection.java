package com.shringar.model;

import java.util.ArrayList;
import java.util.List;

public class AdminReportSection {

    private String title;
    private String comparisonLabel;
    private String summary;
    private String direction;
    private final List<AdminReportMetric> metrics = new ArrayList<>();

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getComparisonLabel() {
        return comparisonLabel;
    }

    public void setComparisonLabel(String comparisonLabel) {
        this.comparisonLabel = comparisonLabel;
    }

    public String getSummary() {
        return summary;
    }

    public void setSummary(String summary) {
        this.summary = summary;
    }

    public String getDirection() {
        return direction;
    }

    public void setDirection(String direction) {
        this.direction = direction;
    }

    public List<AdminReportMetric> getMetrics() {
        return metrics;
    }
}
