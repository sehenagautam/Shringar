package com.shringar.controller;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;

import com.shringar.model.User;
import com.shringar.utils.AdminAccessUtil;
import com.shringar.utils.PortalAuth;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public abstract class AdminBaseServlet extends HttpServlet {

    protected boolean requireAdmin(HttpServletRequest req, HttpServletResponse res) throws IOException {
        if (!PortalAuth.requireUser(req, res)) {
            return false;
        }

        User currentUser = PortalAuth.currentUser(req);
        if (!AdminAccessUtil.isAdminUser(currentUser)) {
            res.sendRedirect(req.getContextPath() + "/user/dashboard");
            return false;
        }
        return true;
    }

    protected void prepareAdminPage(HttpServletRequest req, String activePage) {
        req.setAttribute("activePage", activePage);

        String success = clean(req.getParameter("success"));
        if (success != null) {
            req.setAttribute("successMessage", success);
        }

        String error = clean(req.getParameter("error"));
        if (error != null) {
            req.setAttribute("errorMessage", error);
        }
    }

    protected void redirectWithSuccess(HttpServletRequest req, HttpServletResponse res, String path, String message)
            throws IOException {
        redirectWithMessage(req, res, path, "success", message);
    }

    protected void redirectWithError(HttpServletRequest req, HttpServletResponse res, String path, String message)
            throws IOException {
        redirectWithMessage(req, res, path, "error", message);
    }

    protected void forwardWithErrors(HttpServletRequest req, HttpServletResponse res, String view, String activePage,
            List<String> errors) throws ServletException, IOException {
        prepareAdminPage(req, activePage);
        req.setAttribute("errors", errors);
        req.getRequestDispatcher(view).forward(req, res);
    }

    protected int parsePositiveInt(String value, String fieldName, List<String> errors) {
        if (value == null || value.trim().isEmpty()) {
            errors.add(fieldName + " is required.");
            return -1;
        }
        try {
            int parsed = Integer.parseInt(value.trim());
            if (parsed <= 0) {
                errors.add(fieldName + " must be a positive number.");
                return -1;
            }
            return parsed;
        } catch (NumberFormatException e) {
            errors.add(fieldName + " must be a valid number.");
            return -1;
        }
    }

    protected String clean(String value) {
        if (value == null) {
            return null;
        }
        String trimmed = value.trim();
        return trimmed.isEmpty() ? null : trimmed;
    }

    private void redirectWithMessage(HttpServletRequest req, HttpServletResponse res, String path, String key,
            String message) throws IOException {
        String separator = path.contains("?") ? "&" : "?";
        String encodedMessage = URLEncoder.encode(message, StandardCharsets.UTF_8);
        res.sendRedirect(req.getContextPath() + path + separator + key + "=" + encodedMessage);
    }
}
