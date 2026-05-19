package com.shringar.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import com.shringar.dao.AdminManagementDAO;
import com.shringar.utils.PortalAuth;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/download-report")
public class AdminReportServlet extends HttpServlet {

    private final AdminManagementDAO dao = new AdminManagementDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        if (PortalAuth.currentUser(req) == null) {
            res.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        String type = req.getParameter("type");
        if ("bookings".equalsIgnoreCase(type)) {
            downloadBookingsReport(res);
        } else if ("services".equalsIgnoreCase(type)) {
            downloadServicesReport(res);
        } else {
            res.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid report type");
        }
    }

    private void downloadBookingsReport(HttpServletResponse res) throws IOException {
        res.setContentType("text/csv");
        res.setHeader("Content-Disposition", "attachment; filename=bookings_report.csv");

        List<Map<String, Object>> bookings = dao.listBookingsForAdmin();

        try (PrintWriter writer = res.getWriter()) {
            writer.println("Booking ID,Customer Name,Email,Service,Price,Status,Appointment Date");
            for (Map<String, Object> b : bookings) {
                writer.printf("%s,%s,%s,%s,%s,%s,%s%n",
                        b.get("bookingId"),
                        escapeCsv(String.valueOf(b.get("customerName"))),
                        escapeCsv(String.valueOf(b.get("customerEmail"))),
                        escapeCsv(String.valueOf(b.get("serviceName"))),
                        b.get("price"),
                        b.get("status"),
                        b.get("appointmentDisplay")
                );
            }
        }
    }

    private void downloadServicesReport(HttpServletResponse res) throws IOException {
        res.setContentType("text/csv");
        res.setHeader("Content-Disposition", "attachment; filename=services_report.csv");

        List<com.shringar.model.Service> services = dao.listServicesForAdmin();

        try (PrintWriter writer = res.getWriter()) {
            writer.println("Service ID,Name,Category,Stylist,Code,Price,Duration,Status");
            for (com.shringar.model.Service s : services) {
                writer.printf("%d,%s,%s,%s,%s,%s,%d,%s%n",
                        s.getServiceId(),
                        escapeCsv(s.getServiceName()),
                        escapeCsv(s.getCategory()),
                        escapeCsv(s.getStylistName()),
                        escapeCsv(s.getServiceCode()),
                        s.getPrice(),
                        s.getDurationMinutes(),
                        s.isActive() ? "Active" : "Inactive"
                );
            }
        }
    }

    private String escapeCsv(String value) {
        if (value == null) return "";
        if (value.contains(",") || value.contains("\"") || value.contains("\n")) {
            return "\"" + value.replace("\"", "\"\"") + "\"";
        }
        return value;
    }
}
