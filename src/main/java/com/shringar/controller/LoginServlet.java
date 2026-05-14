package com.shringar.controller;

import java.io.IOException;
import java.util.List;

import com.shringar.dao.UserDAO;
import com.shringar.model.User;
import com.shringar.utils.AdminAccessUtil;
import com.shringar.utils.CookieUtil;
import com.shringar.utils.SessionUtil;
import com.shringar.utils.ValidationUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet({ "/login", "/user/login", "/admin/login", "/admin-login" })
public class LoginServlet extends HttpServlet {

    private static final String ADMIN_LOGIN_VIEW = "ADMIN";
    private static final String USER_LOGIN_VIEW = "USER";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        prepareLoginView(req);
        if ("1".equals(req.getParameter("expired"))) {
            req.setAttribute("message", "Your session expired after 30 minutes of inactivity. Please log in again.");
        }
        if ("pending".equalsIgnoreCase(req.getParameter("success"))) {
            req.setAttribute("message", "Registration submitted successfully. Please wait for admin approval before logging in.");
        }
        if ("registered".equalsIgnoreCase(req.getParameter("success"))) {
            req.setAttribute("message", "Registration submitted successfully. Please wait for admin approval before logging in.");
        }
        // If the user just failed a login attempt we keep the email they typed.
        // Otherwise, fall back to the remembered email cookie for convenience.
        if (req.getAttribute("typedEmail") == null) {
            String rememberedEmail = CookieUtil.getCookieValue(req, "shringar_last_email");
            if (rememberedEmail != null && !rememberedEmail.isBlank()) {
                req.setAttribute("typedEmail", rememberedEmail);
            }
        }
        req.getRequestDispatcher(resolveLoginPage(req)).forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        prepareLoginView(req);
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        List<String> errors = ValidationUtil.newErrorList();
        ValidationUtil.require(email, "Email", errors);
        ValidationUtil.require(password, "Password", errors);

        if (!errors.isEmpty()) {
            forwardWithErrors(req, res, errors, email);
            return;
        }

        if (!ValidationUtil.isValidEmail(email)) {
            errors.add("Please enter a valid email address.");
            forwardWithErrors(req, res, errors, email);
            return;
        }

        UserDAO dao = new UserDAO();
        if (AdminAccessUtil.isAdminEmail(email)) {
            // A brand-new database may not have the seeded admin row yet.
            // This keeps the admin login usable without a manual setup step.
            dao.ensureAdminAccount();
        }
        User user = dao.authenticate(email, password);
        if (user == null) {
            errors.add("Invalid email or password.");
            forwardWithErrors(req, res, errors, email);
            return;
        }

        if (!"APPROVED".equalsIgnoreCase(user.getStatus())) {
            errors.add("Your account is waiting for admin approval.");
            forwardWithErrors(req, res, errors, email);
            return;
        }

        // Session drives access control; the cookie is only there to remember
        // the last email the person used on this browser.
        SessionUtil.setAttribute(req, "user", user, SessionUtil.USER_SESSION_TIMEOUT_SECONDS);
        String userRole = AdminAccessUtil.isAdminUser(user) ? "ADMIN" : "CUSTOMER";
        SessionUtil.setAttribute(req, "userRole", userRole, SessionUtil.USER_SESSION_TIMEOUT_SECONDS);
        CookieUtil.addCookie(res, "shringar_last_email", user.getEmail(), 60 * 60 * 24 * 30);
        res.sendRedirect(req.getContextPath() + ("ADMIN".equals(userRole) ? "/admin/dashboard" : "/user/dashboard"));
    }

    private void forwardWithErrors(HttpServletRequest req, HttpServletResponse res, List<String> errors, String email)
            throws ServletException, IOException {
        // Keep the form populated so the user only has to fix the problem field.
        req.setAttribute("errors", errors);
        req.setAttribute("error", errors.isEmpty() ? null : errors.get(0));
        req.setAttribute("typedEmail", email);
        if (AdminAccessUtil.isAdminEmail(email)) {
            req.setAttribute("loginView", ADMIN_LOGIN_VIEW);
        }
        req.getRequestDispatcher(resolveLoginPage(req)).forward(req, res);
    }

    private void prepareLoginView(HttpServletRequest req) {
        String servletPath = req.getServletPath();
        boolean isAdminRoute = servletPath != null
                && (servletPath.startsWith("/admin/") || "/admin-login".equals(servletPath));
        req.setAttribute("loginView", isAdminRoute ? ADMIN_LOGIN_VIEW : USER_LOGIN_VIEW);
    }

    private String resolveLoginPage(HttpServletRequest req) {
        return ADMIN_LOGIN_VIEW.equals(req.getAttribute("loginView")) ? "/pages/admin-login.jsp" : "/pages/user.jsp";
    }
}
