package com.shringar.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.shringar.dao.ServiceDAO;
import com.shringar.model.Service;
import com.shringar.utils.PortalAuth;
import com.shringar.utils.SalonMediaUtil;
import com.shringar.utils.SessionUtil;
import com.shringar.utils.ValidationUtil;
import com.shringar.utils.WishlistHelper;

@WebServlet({ "/search", "/user/search" })
public class SearchServlet extends HttpServlet {

    private static final List<String> SALON_CATEGORIES = List.of("Nail", "Hair", "Makeup");

    private String clean(String value) {
        // Normalizes request params so later checks can just test for null.
        if (value == null) {
            return null;
        }
        String trimmed = value.trim();
        return trimmed.isEmpty() ? null : trimmed;
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        boolean requiresLogin = "/user/search".equals(req.getServletPath());
        if (requiresLogin && !PortalAuth.requireUser(req, res)) {
            return;
        }

        // Flash messages are stored in session because the action that creates
        // them usually redirects back to search.
        Object flashOk = SessionUtil.getAttribute(req, "flashSuccess");
        if (flashOk != null) {
            req.setAttribute("message", flashOk);
            SessionUtil.removeAttribute(req, "flashSuccess");
        }
        Object flashErr = SessionUtil.getAttribute(req, "flashError");
        if (flashErr != null) {
            req.setAttribute("flashError", flashErr);
            SessionUtil.removeAttribute(req, "flashError");
        }

        String stylist = clean(req.getParameter("stylist"));
        String serviceCode = clean(req.getParameter("serviceCode"));
        String keyword = clean(req.getParameter("q"));
        String category = clean(req.getParameter("category"));

        ServiceDAO dao = new ServiceDAO();
        List<Service> results = new ArrayList<>();
        List<String> hints = new ArrayList<>();

        boolean hasStylist = stylist != null;
        boolean hasCode = serviceCode != null;
        boolean hasKeyword = keyword != null;
        boolean hasCategory = category != null;

        if (hasCode && !ValidationUtil.isValidServiceCode(serviceCode)) {
            hints.add("Service code format is invalid. Use letters, numbers, or hyphens (3-40 characters).");
            serviceCode = null;
            hasCode = false;
        }

        if (!hasStylist && !hasCode && !hasKeyword && !hasCategory) {
            results = dao.listAllActive();
            hints.add(requiresLogin
                    ? "Showing the full salon menu. Choose a category or treatment to narrow it down."
                    : "Showing the full salon menu. Choose Nail, Hair, or Makeup, then select a treatment.");
        } else {
            // Search is intentionally additive: any combination of keyword,
            // category, stylist, and service code can be layered together.
            results = dao.searchServices(keyword, category, stylist, serviceCode);

            if (hasKeyword) {
                hints.add("Search keyword applied: " + keyword + ".");
            }
            if (hasCategory) {
                hints.add("Salon category selected: " + category + ".");
            }
            if (hasStylist) {
                hints.add("Stylist filter applied: " + stylist + ".");
            }
            if (hasCode) {
                hints.add("Exact service code filter applied.");
            }
            if (results.isEmpty()) {
                hints.add("No matches yet. Try another category or choose all salon treatments.");
            }
        }

        req.setAttribute("results", results);
        req.setAttribute("searchHints", hints);
        req.setAttribute("stylist", stylist);
        req.setAttribute("serviceCode", serviceCode);
        req.setAttribute("q", keyword);
        req.setAttribute("category", category);
        req.setAttribute("categories", SALON_CATEGORIES);
        req.setAttribute("serviceOptions", dao.listAllActive());
        req.setAttribute("serviceImageMap", SalonMediaUtil.buildServiceImageMap(results));
        // Guests can browse without a wishlist, so expose an empty set for them.
        req.setAttribute("wishlistIds", PortalAuth.currentUser(req) != null ? WishlistHelper.getIds(req) : new LinkedHashSet<Integer>());
        req.setAttribute("searchPath", requiresLogin ? "/user/search" : "/search");

        req.getRequestDispatcher(requiresLogin ? "/user/search.jsp" : "/pages/search.jsp").forward(req, res);
    }
}
