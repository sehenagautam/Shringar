package com.shringar.controller;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

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
import com.shringar.model.Service;
import com.shringar.model.User;
import com.shringar.utils.PortalAuth;
import com.shringar.utils.SalonMediaUtil;
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
            // Refresh the session copy so dashboard widgets reflect recent
            // profile edits without waiting for the next login.
            SessionUtil.setAttribute(req, "user", fresh, SessionUtil.USER_SESSION_TIMEOUT_SECONDS);
        }

        int userId = sessionUser.getUserId();
        BookingDAO bookingDAO = new BookingDAO();
        ApplyRequestDAO requestDAO = new ApplyRequestDAO();
        ServiceDAO serviceDAO = new ServiceDAO();
        List<Service> activeServices = serviceDAO.listAllActive();

        List<Booking> all = bookingDAO.findByUserId(userId);
        int pendingRequestCount = requestDAO.countPendingByUserId(userId);
        LocalDateTime now = LocalDateTime.now();
        List<Booking> upcoming = new ArrayList<>();
        List<Booking> history = new ArrayList<>();

        // The UI treats future bookings and past bookings differently, so we
        // split them once here instead of repeating that logic in the JSP.
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
        req.setAttribute("serviceImageMap", SalonMediaUtil.buildServiceImageMap(activeServices));
        req.setAttribute("categories", serviceDAO.listDistinctCategories());
        req.setAttribute("favouriteStylists", buildFavouriteStylists());
        req.setAttribute("promoCards", buildPromotions());

        req.getRequestDispatcher("/user/dashboard.jsp").forward(req, res);
    }

    private List<Map<String, String>> buildFavouriteStylists() {
        List<Map<String, String>> stylists = new ArrayList<>();
        stylists.add(stylistCard("Shringar Hair Team", "Hair Stylist", "Hair", "/images/ojeswi.png"));
        stylists.add(stylistCard("Shringar Makeup Team", "Makeup Artist", "Makeup", "/images/pratyusha.png"));
        stylists.add(stylistCard("Shringar Beautician", "Beautician", "Beauty", "/images/sabya.png"));
        stylists.add(stylistCard("Shringar Nail Team", "Nail Technician", "Nail", "/public/nail_technician.jpg"));
        return stylists;
    }

    private List<Map<String, String>> buildPromotions() {
        List<Map<String, String>> promotions = new ArrayList<>();
        // These cards are intentionally hard-coded for now so content updates
        // can stay lightweight while the dashboard layout is still evolving.
        promotions.add(promoCard("Black Friday discount", "Makeup", "HD Makeup",
                "Limited-time Black Friday savings on premium glam sessions with a polished photo-ready finish.",
                "/images/makeup5.jpg", "Claim Black Friday deal"));
        promotions.add(promoCard("Bridal glow offer", "Makeup", "Bridal Makeup",
                "Wedding-ready glam with a softer bridal finish and priority beauty prep.",
                "/images/makeup3.jpg", "Explore bridal makeup"));
        promotions.add(promoCard("Hair refresh week", "Hair", "Rapid Refresh Haircut",
                "Quick cut and finish for a polished look before your next event or work week.",
                "/images/hair2.jpg", "Book a fresh haircut"));
        promotions.add(promoCard("Nail art spotlight", "Nail", "Nail Art Design",
                "Signature nail designs and glossy finishing touches for your next celebration.",
                "/images/nail2.jpg", "Choose a nail design"));
        return promotions;
    }

    private Map<String, String> stylistCard(String name, String role, String category, String imagePath) {
        // LinkedHashMap keeps insertion order stable for the JSP carousel/grid.
        Map<String, String> stylist = new LinkedHashMap<>();
        stylist.put("name", name);
        stylist.put("role", role);
        stylist.put("category", category);
        stylist.put("imagePath", imagePath);
        return stylist;
    }

    private Map<String, String> promoCard(String title, String category, String query, String description,
            String imagePath, String buttonLabel) {
        // Query and category are stored alongside display text so each promo
        // can deep-link directly into the search experience.
        Map<String, String> promo = new LinkedHashMap<>();
        promo.put("title", title);
        promo.put("category", category);
        promo.put("query", query);
        promo.put("description", description);
        promo.put("imagePath", imagePath);
        promo.put("buttonLabel", buttonLabel);
        return promo;
    }
}
