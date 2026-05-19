package com.shringar.controller;

import java.io.IOException;
import java.time.LocalDate;
import java.util.Collections;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import com.shringar.dao.UserDAO;
import com.shringar.model.User;
import com.shringar.utils.PortalAuth;
import com.shringar.utils.ProfileImageUtil;
import com.shringar.utils.SessionUtil;
import com.shringar.utils.ValidationUtil;

@WebServlet({ "/profile", "/user/profile" })
@MultipartConfig
public class ProfileServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        if (!PortalAuth.requireUser(req, res)) {
            return;
        }
        User sessionUser = PortalAuth.currentUser(req);
        UserDAO dao = new UserDAO();
        User fresh = dao.findById(sessionUser.getUserId());
        if (fresh != null) {
            // Pull the latest copy from the database before showing the form so
            // the page reflects any updates made in another tab or admin screen.
            SessionUtil.setAttribute(req, "user", fresh, SessionUtil.USER_SESSION_TIMEOUT_SECONDS);
        }
        req.getRequestDispatcher("/user/profile.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        if (!PortalAuth.requireUser(req, res)) {
            return;
        }

        User sessionUser = PortalAuth.currentUser(req);
        String name = req.getParameter("name");
        String phone = req.getParameter("phone");
        String email = req.getParameter("email");
        String dobStr = req.getParameter("dateOfBirth");
        String membershipLevel = req.getParameter("membershipLevel");
        String memberYearStr = req.getParameter("memberSinceYear");
        String preferredServices = req.getParameter("preferredServices");
        String newPassword = req.getParameter("newPassword");
        String confirmPassword = req.getParameter("confirmPassword");
        List<String> errors = ValidationUtil.newErrorList();
        Part profileImagePart = null;

        try {
            profileImagePart = req.getPart("profileImage");
        } catch (Exception e) {
            errors.add("Could not read the uploaded profile image.");
        }
        ValidationUtil.require(name, "Full name", errors);
        ValidationUtil.require(email, "Email", errors);
        ValidationUtil.require(phone, "Phone number", errors);

        if (!ValidationUtil.isValidEmail(email)) {
            errors.add("Please enter a valid email address.");
        }
        if (!ValidationUtil.isValidPhone(phone)) {
            errors.add("Please enter a valid phone number.");
        }

        LocalDate dob = null;
        if (!ValidationUtil.isBlank(dobStr)) {
            try {
                dob = LocalDate.parse(dobStr);
            } catch (Exception e) {
                errors.add("Date of birth is not valid.");
            }
        }

        Integer memberYear = null;
        if (!ValidationUtil.isBlank(memberYearStr)) {
            try {
                memberYear = Integer.parseInt(memberYearStr.trim());
            } catch (NumberFormatException e) {
                errors.add("Member since year must be a number.");
            }
        }

        boolean changePassword = !ValidationUtil.isBlank(newPassword)
                || !ValidationUtil.isBlank(confirmPassword);
        if (changePassword) {
            // Password checks only run when the user actually tries to change it.
            if (!ValidationUtil.isValidPassword(newPassword)) {
                errors.add("New password must be at least 8 characters.");
            } else if (newPassword == null || !newPassword.equals(confirmPassword)) {
                errors.add("New password and confirmation do not match.");
            }
        }

        UserDAO dao = new UserDAO();
        if (dao.isEmailTakenByOther(email, sessionUser.getUserId())) {
            errors.add("That email is already used by another account.");
        }

        if (!errors.isEmpty()) {
            req.setAttribute("errors", errors);
            req.getRequestDispatcher("/user/profile.jsp").forward(req, res);
            return;
        }

        User u = dao.findById(sessionUser.getUserId());
        if (u == null) {
            errors.add("Could not load your profile.");
            req.setAttribute("errors", errors);
            req.getRequestDispatcher("/user/profile.jsp").forward(req, res);
            return;
        }

        u.setName(name.trim());
        u.setPhone(ValidationUtil.isBlank(phone) ? null : phone.trim());
        u.setDateOfBirth(dob);
        u.setMembershipLevel(ValidationUtil.isBlank(membershipLevel) ? null : membershipLevel.trim());
        u.setMemberSinceYear(memberYear);
        u.setPreferredServices(ValidationUtil.isBlank(preferredServices) ? null : preferredServices.trim());
        if (profileImagePart != null && profileImagePart.getSize() > 0) {
            try {
                String savedPath = ProfileImageUtil.saveProfileImage(profileImagePart, req.getServletContext().getRealPath(""));
                u.setImage(savedPath);
            } catch (ServletException | IOException e) {
                errors.add(e.getMessage());
            }
        }

        if (!errors.isEmpty()) {
            req.setAttribute("errors", errors);
            req.getRequestDispatcher("/user/profile.jsp").forward(req, res);
            return;
        }

        boolean ok = dao.updateProfile(u);
        if (!u.getEmail().equalsIgnoreCase(email.trim())) {
            // Email lives in its own update path so we can keep the profile
            // update logic simple and reuse the duplicate-email guard above.
            ok = dao.updateEmail(u.getUserId(), email.trim()) && ok;
            u.setEmail(email.trim());
        }

        if (changePassword) {
            ok = dao.updatePasswordHash(u.getUserId(), newPassword) && ok;
        }

        User reloaded = dao.findById(u.getUserId());
        if (reloaded != null) {
            // Keep the session in sync with the saved record so the navbar,
            // dashboard, and profile form all show the same data immediately.
            SessionUtil.setAttribute(req, "user", reloaded, SessionUtil.USER_SESSION_TIMEOUT_SECONDS);
        }

        if (ok) {
            req.setAttribute("message", "Profile updated successfully.");
        } else {
            req.setAttribute("errors", Collections.singletonList("Some changes could not be saved. Please try again."));
        }

        req.getRequestDispatcher("/user/profile.jsp").forward(req, res);
    }
}
