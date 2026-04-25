package com.shringar.controller;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.shringar.dao.AdminManagementDAO;
import com.shringar.utils.ValidationUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/bookings")
public class AdminBookingsServlet extends AdminBaseServlet {

    private static final Set<String> ALLOWED_STATUSES = Set.of("PENDING", "CONFIRMED", "COMPLETED", "CANCELLED");
    private final AdminManagementDAO dao = new AdminManagementDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        if (!requireAdmin(req, res)) {
            return;
        }
        prepareBookingsPage(req);
        req.getRequestDispatcher("/admin/bookings.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        if (!requireAdmin(req, res)) {
            return;
        }

        String action = clean(req.getParameter("action"));
        if ("delete".equalsIgnoreCase(action)) {
            handleDelete(req, res);
            return;
        }

        List<String> errors = ValidationUtil.newErrorList();
        int userId = parsePositiveInt(req.getParameter("userId"), "Customer", errors);
        int serviceId = parsePositiveInt(req.getParameter("serviceId"), "Service", errors);
        String status = clean(req.getParameter("status"));
        String notes = clean(req.getParameter("notes"));
        String appointmentValue = ValidationUtil.require(req.getParameter("appointmentDatetime"), "Appointment time", errors);

        LocalDateTime appointment = null;
        if (!ValidationUtil.isBlank(appointmentValue)) {
            try {
                appointment = LocalDateTime.parse(appointmentValue);
            } catch (Exception e) {
                errors.add("Appointment time is not valid.");
            }
        }

        if (status == null || !ALLOWED_STATUSES.contains(status.toUpperCase())) {
            errors.add("Choose a valid booking status.");
        }
        if (notes != null && notes.length() > 255) {
            errors.add("Notes must be 255 characters or fewer.");
        }

        boolean update = "update".equalsIgnoreCase(action);
        int bookingId = update ? parsePositiveInt(req.getParameter("bookingId"), "Booking", errors) : -1;

        if (!errors.isEmpty()) {
            prepareBookingsPage(req);
            req.setAttribute("bookingForm", Map.of(
                    "bookingId", bookingId,
                    "userId", userId,
                    "serviceId", serviceId,
                    "appointmentValue", appointmentValue == null ? "" : appointmentValue,
                    "status", status == null ? "" : status,
                    "notes", notes == null ? "" : notes));
            req.setAttribute("editingBooking", update);
            forwardWithErrors(req, res, "/admin/bookings.jsp", "bookings", errors);
            return;
        }

        boolean ok = update
                ? dao.updateBooking(bookingId, userId, serviceId, appointment, status.toUpperCase(), notes)
                : dao.createBooking(userId, serviceId, appointment, status.toUpperCase(), notes);
        if (ok) {
            redirectWithSuccess(req, res, "/admin/bookings",
                    update ? "Booking was updated successfully." : "Booking was created successfully.");
        } else {
            redirectWithError(req, res, "/admin/bookings",
                    update ? "Could not update the booking." : "Could not create the booking.");
        }
    }

    private void handleDelete(HttpServletRequest req, HttpServletResponse res) throws IOException {
        List<String> errors = ValidationUtil.newErrorList();
        int bookingId = parsePositiveInt(req.getParameter("bookingId"), "Booking", errors);
        if (!errors.isEmpty()) {
            redirectWithError(req, res, "/admin/bookings", String.join(" ", errors));
        } else if (dao.deleteBooking(bookingId)) {
            redirectWithSuccess(req, res, "/admin/bookings", "Booking was deleted successfully.");
        } else {
            redirectWithError(req, res, "/admin/bookings", "Could not delete the booking.");
        }
    }

    private void prepareBookingsPage(HttpServletRequest req) {
        prepareAdminPage(req, "bookings");
        req.setAttribute("bookings", dao.listBookingsForAdmin());
        req.setAttribute("userOptions", dao.listUserOptions());
        req.setAttribute("serviceOptions", dao.listActiveServiceOptions());

        String editId = clean(req.getParameter("editId"));
        if (editId != null) {
            List<String> errors = ValidationUtil.newErrorList();
            int bookingId = parsePositiveInt(editId, "Booking", errors);
            if (errors.isEmpty()) {
                req.setAttribute("bookingForm", dao.findBookingById(bookingId));
                req.setAttribute("editingBooking", true);
            }
        }
    }
}
