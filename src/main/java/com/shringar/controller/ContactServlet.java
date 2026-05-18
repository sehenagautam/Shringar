package com.shringar.controller;

import java.io.IOException;
import java.util.List;

import com.shringar.dao.ContactMessageDAO;
import com.shringar.model.ContactMessage;
import com.shringar.utils.SessionUtil;
import com.shringar.utils.ValidationUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class ContactServlet extends HttpServlet {

    private final ContactMessageDAO contactMessageDAO = new ContactMessageDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        Object flashSuccess = SessionUtil.getAttribute(req, "contactSuccessMessage");
        if (flashSuccess != null) {
            req.setAttribute("successMessage", flashSuccess);
            SessionUtil.removeAttribute(req, "contactSuccessMessage");
        }
        req.getRequestDispatcher("/ContactUs.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String fullName = trim(req.getParameter("name"));
        String email = trim(req.getParameter("email"));
        String phone = trim(req.getParameter("phone"));
        String message = trim(req.getParameter("message"));

        List<String> errors = ValidationUtil.newErrorList();
        ValidationUtil.require(fullName, "Name", errors);
        ValidationUtil.require(email, "Email", errors);
        ValidationUtil.require(message, "Message", errors);

        if (!ValidationUtil.isBlank(fullName) && !ValidationUtil.isValidPersonName(fullName)) {
            errors.add("Please enter a valid name using letters and spaces only.");
        }
        if (!ValidationUtil.isValidEmail(email)) {
            errors.add("Please enter a valid email address.");
        }
        if (!ValidationUtil.isValidPhone(phone)) {
            errors.add("Please enter a valid phone number or leave it blank.");
        }
        if (!ValidationUtil.isBlank(message) && message.length() > 1500) {
            errors.add("Message must be 1500 characters or fewer.");
        }

        if (!errors.isEmpty()) {
            forwardWithState(req, res, errors, fullName, email, phone, message);
            return;
        }

        ContactMessage contactMessage = new ContactMessage();
        contactMessage.setFullName(fullName);
        contactMessage.setEmail(email.toLowerCase());
        contactMessage.setPhone(phone);
        contactMessage.setMessage(message);

        if (!contactMessageDAO.save(contactMessage)) {
            errors.add("We could not send your message right now. Please try again later.");
            forwardWithState(req, res, errors, fullName, email, phone, message);
            return;
        }

        SessionUtil.setAttribute(req, "contactSuccessMessage",
                "Thank you for contacting Shringar. Our team will get back to you soon.",
                SessionUtil.USER_SESSION_TIMEOUT_SECONDS);
        res.sendRedirect(req.getContextPath() + "/ContactUs");
    }

    private void forwardWithState(HttpServletRequest req, HttpServletResponse res, List<String> errors,
            String fullName, String email, String phone, String message) throws ServletException, IOException {
        req.setAttribute("errors", errors);
        req.setAttribute("formName", fullName);
        req.setAttribute("formEmail", email);
        req.setAttribute("formPhone", phone);
        req.setAttribute("formMessage", message);
        req.getRequestDispatcher("/ContactUs.jsp").forward(req, res);
    }

    private String trim(String value) {
        if (value == null) {
            return null;
        }
        String trimmed = value.trim();
        return trimmed.isEmpty() ? null : trimmed;
    }
}
