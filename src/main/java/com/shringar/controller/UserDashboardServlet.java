package com.shringar.controller;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

import com.shringar.dao.ApplyRequestDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.shringar.dao.BookingDAO;
import com.shringar.dao.ServiceDAO;
import com.shringar.dao.UserDAO;
import com.shringar.model.Booking;
import com.shringar.model.User;
import com.shringar.utils.PortalAuth;
import com.shringar.utils.SessionUtil;

@WebServlet("/user/dashboard")
public class UserDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        if (!PortalAuth.requireUser(req, res)) {
            return;
        }

        User sessionUser = PortalAuth.currentUser(req);
        UserDAO userDAO = new UserDAO();
        User fresh = userDAO.findById(sessionUser.getUserId());
        if (fresh != null) {
            SessionUtil.setAttribute(req, "user", fresh, SessionUtil.USER_SESSION_TIMEOUT_SECONDS);
        }

        int userId = sessionUser.getUserId();
        BookingDAO bookingDAO = new BookingDAO();
        ApplyRequestDAO requestDAO = new ApplyRequestDAO();
        ServiceDAO serviceDAO = new ServiceDAO();

        List<Booking> all = bookingDAO.findByUserId(userId);
        int pendingRequestCount = requestDAO.countPendingByUserId(userId);
        LocalDateTime now = LocalDateTime.now();
        List<Booking> upcoming = new ArrayList<>();
        List<Booking> history = new ArrayList<>();
        for (Booking b : all) {
            if (b.getAppointmentDatetime() != null && b.getAppointmentDatetime().isAfter(now)) {
                upcoming.add(b);
            } else {
                history.add(b);
            }
        }
        upcoming.sort(Comparator.comparing(Booking::getAppointmentDatetime));

        req.setAttribute("bookings", all);
        req.setAttribute("upcomingBookings", upcoming);
        req.setAttribute("historyBookings", history);
        req.setAttribute("bookingCount", bookingDAO.countByUserId(userId));
        req.setAttribute("pendingRequestCount", pendingRequestCount);
        req.setAttribute("applyRequests", requestDAO.findByUserId(userId));
        req.setAttribute("popularServices", serviceDAO.findMostBooked(5));
        req.setAttribute("categories", serviceDAO.listDistinctCategories());

        req.getRequestDispatcher("/user/dashboard.jsp").forward(req, res);
    }
}
