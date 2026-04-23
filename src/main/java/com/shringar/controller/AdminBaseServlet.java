package com.shringar.controller;

import java.io.IOException;
import java.util.List;

import com.shringar.model.User;
import com.shringar.utils.AdminAccessUtil;
import com.shringar.utils.PortalAuth;
import com.shringar.utils.SessionUtil;

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
        Object role = SessionUtil.getAttribute(req, "userRole");
        if (!AdminAccessUtil.isAdminUser(currentUser) && !"ADMIN".equalsIgnoreCase(String.valueOf(role))) {
            res.sendRedirect(req.getContextPath() + "/user/dashboard");
            return false;
        }
        return true;
    }

    protected void prepareAdminPage(HttpServletRequest req, String activePage) {
        req.setAttribute("activePage", activePage);

        Object success = SessionUtil.getAttribute(req, "adminSuccess");
        if (success != null) {
            req.setAttribute("successMessage", success);
            SessionUtil.removeAttribute(req, "adminSuccess");
        }

        Object error = SessionUtil.getAttribute(req, "adminError");
        if (error != null) {
            req.setAttribute("errorMessage", error);
            SessionUtil.removeAttribute(req, "adminError");
        }
    }

    protected void setSuccess(HttpServletRequest req, String message) {
        SessionUtil.setAttribute(req, "adminSuccess", message, SessionUtil.USER_SESSION_TIMEOUT_SECONDS);
    }

    protected void setError(HttpServletRequest req, String message) {
        SessionUtil.setAttribute(req, "adminError", message, SessionUtil.USER_SESSION_TIMEOUT_SECONDS);
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
}
