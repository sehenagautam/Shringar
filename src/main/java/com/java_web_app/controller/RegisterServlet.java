package com.java_web_app.controller;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import com.java_web_app.dao.UserDAO;
import com.java_web_app.model.User;
import com.java_web_app.utils.ProfileImageUtil;
import com.java_web_app.utils.ValidationUtil;

@WebServlet({ "/register", "/user/register" })
@MultipartConfig
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        req.getRequestDispatcher("/user/register.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String name = req.getParameter("name");
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
        if (req.getContentType() == null || !req.getContentType().toLowerCase().contains("multipart/form-data")) {
            errors.add("Profile image upload is required.");
        } else {
            try {
                profileImagePart = req.getPart("profileImage");
                if (profileImagePart == null || profileImagePart.getSize() <= 0) {
                    errors.add("Profile image is required.");
                }
            } catch (Exception e) {
                errors.add("Could not read the uploaded profile image.");
            }
        }

        if (!errors.isEmpty()) {
            req.setAttribute("errors", errors);
            req.getRequestDispatcher("/user/register.jsp").forward(req, res);
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
            req.setAttribute("errors", errors);
            req.getRequestDispatcher("/user/register.jsp").forward(req, res);
            return;
        }

        UserDAO dao = new UserDAO();
        if (dao.isEmailTaken(email)) {
            errors.add("That email is already registered.");
            req.setAttribute("errors", errors);
            req.getRequestDispatcher("/user/register.jsp").forward(req, res);
            return;
        }

        User u = new User();
        u.setName(name.trim());
        u.setEmail(email.trim());
        u.setPhone(ValidationUtil.isBlank(phone) ? null : phone.trim());
        u.setDateOfBirth(dob);
        u.setMembershipLevel(ValidationUtil.isBlank(membershipLevel) ? null : membershipLevel.trim());
        u.setMemberSinceYear(memberYear);
        u.setPreferredServices(ValidationUtil.isBlank(preferredServices) ? null : preferredServices.trim());
        try {
            String savedPath = ProfileImageUtil.saveProfileImage(profileImagePart, req.getServletContext().getRealPath(""));
            u.setImage(savedPath);
        } catch (Exception e) {
            errors.add(e.getMessage());
            req.setAttribute("errors", errors);
            req.getRequestDispatcher("/user/register.jsp").forward(req, res);
            return;
        }

        if (dao.register(u, password)) {
            req.setAttribute("message",
                    "Registration received. Your account must be approved by an administrator before you can sign in.");
            req.getRequestDispatcher("/user/login.jsp").forward(req, res);
        } else {
            errors.add("Could not complete registration. Please try again.");
            req.setAttribute("errors", errors);
            req.getRequestDispatcher("/user/register.jsp").forward(req, res);
        }
    }
}
