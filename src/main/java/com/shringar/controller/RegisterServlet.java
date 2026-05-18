package com.shringar.controller;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

import com.shringar.dao.UserDAO;
import com.shringar.model.User;
import com.shringar.utils.CookieUtil;
import com.shringar.utils.ProfileImageUtil;
import com.shringar.utils.ValidationUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet({ "/register", "/user/register" })
@MultipartConfig
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        req.getRequestDispatcher("/pages/Register.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String name = firstNonBlank(req.getParameter("fullName"), req.getParameter("name"));
        String email = req.getParameter("email");
        String phone = req.getParameter("phone");
        String password = req.getParameter("password");
        String confirm = req.getParameter("confirmPassword");
        String dobStr = req.getParameter("dateOfBirth");
        String membershipLevel = req.getParameter("membershipLevel");
        String memberYearStr = req.getParameter("memberSinceYear");
        String preferredServices = req.getParameter("preferredServices");
        Part profileImagePart = null;

        List<String> errors = ValidationUtil.newErrorList();
        ValidationUtil.require(name, "Full name", errors);
        ValidationUtil.require(email, "Email", errors);
        ValidationUtil.require(password, "Password", errors);

        // The register form can include an optional profile photo, so we only
        // try to read the part when the request is actually multipart.
        if (isMultipart(req)) {
            try {
                profileImagePart = req.getPart("profileImage");
            } catch (Exception e) {
                errors.add("Could not read the uploaded profile image.");
            }
        }

        if (!errors.isEmpty()) {
            forwardWithErrors(req, res, errors);
            return;
        }

        if (!ValidationUtil.isValidEmail(email)) {
            errors.add("Please enter a valid email address.");
        }
        if (!ValidationUtil.isValidPhone(phone)) {
            errors.add("Please enter a valid phone number (or leave blank).");
        }
        if (!ValidationUtil.isValidPassword(password)) {
            errors.add("Password must be at least 8 characters.");
        }
        if (confirm == null || !confirm.equals(password)) {
            errors.add("Passwords do not match.");
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

        if (!errors.isEmpty()) {
            forwardWithErrors(req, res, errors);
            return;
        }

        UserDAO dao = new UserDAO();
        if (dao.isEmailTaken(email)) {
            errors.add("That email is already registered.");
            forwardWithErrors(req, res, errors);
            return;
        }

        User user = new User();
        user.setName(name.trim());
        user.setEmail(email.trim());
        user.setPhone(ValidationUtil.isBlank(phone) ? null : phone.trim());
        user.setDateOfBirth(dob);
        // New accounts wait for an admin approval before they can sign in.
        user.setStatus("PENDING");
        user.setMembershipLevel(ValidationUtil.isBlank(membershipLevel) ? null : membershipLevel.trim());
        user.setMemberSinceYear(memberYear);
        user.setPreferredServices(ValidationUtil.isBlank(preferredServices) ? null : preferredServices.trim());

        if (profileImagePart != null && profileImagePart.getSize() > 0) {
            try {
                String savedPath = ProfileImageUtil.saveProfileImage(profileImagePart, req.getServletContext().getRealPath(""));
                user.setImage(savedPath);
            } catch (Exception e) {
                errors.add(e.getMessage());
                forwardWithErrors(req, res, errors);
                return;
            }
        }

        if (!dao.register(user, password)) {
            errors.add("Could not complete registration. Please try again.");
            forwardWithErrors(req, res, errors);
            return;
        }

        // Remember the latest email so the login page can greet them halfway.
        CookieUtil.addCookie(res, "shringar_last_email", email.trim(), 60 * 60 * 24 * 30);
        res.sendRedirect(req.getContextPath() + "/login?success=pending");
    }

    private void forwardWithErrors(HttpServletRequest req, HttpServletResponse res, List<String> errors)
            throws ServletException, IOException {
        req.setAttribute("errors", errors);
        req.setAttribute("error", errors.isEmpty() ? null : errors.get(0));
        req.getRequestDispatcher("/pages/Register.jsp").forward(req, res);
    }

    private boolean isMultipart(HttpServletRequest req) {
        String contentType = req.getContentType();
        return contentType != null && contentType.toLowerCase().contains("multipart/form-data");
    }

    private String firstNonBlank(String first, String second) {
        // Supports both the newer "fullName" field and the older "name" field.
        if (!ValidationUtil.isBlank(first)) {
            return first;
        }
        return second;
    }
}
