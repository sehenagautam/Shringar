package com.shringar.controller;

import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.shringar.dao.AdminManagementDAO;
import com.shringar.dao.UserDAO;
import com.shringar.utils.ValidationUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/users")
public class AdminUsersServlet extends AdminBaseServlet {

    private static final Set<String> ALLOWED_STATUSES = Set.of("PENDING", "APPROVED", "REJECTED");
    private final AdminManagementDAO dao = new AdminManagementDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        if (!requireAdmin(req, res)) {
            return;
        }
        prepareAdminPage(req, "users");
        req.setAttribute("users", dao.listUsers());
        req.getRequestDispatcher("/admin/users.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        if (!requireAdmin(req, res)) {
            return;
        }

        String action = clean(req.getParameter("action"));
        if ("create".equalsIgnoreCase(action)) {
            handleCreateCustomer(req, res);
            return;
        }

        List<String> errors = ValidationUtil.newErrorList();
        int userId = parsePositiveInt(req.getParameter("userId"), "User", errors);
        String status = clean(req.getParameter("status"));
        if (status == null || !ALLOWED_STATUSES.contains(status.toUpperCase())) {
            errors.add("Choose a valid user status.");
        }

        if (!errors.isEmpty()) {
            req.setAttribute("users", dao.listUsers());
            forwardWithErrors(req, res, "/admin/users.jsp", "users", errors);
            return;
        }

        if (dao.updateUserStatus(userId, status.toUpperCase())) {
            redirectWithSuccess(req, res, "/admin/users", "User account status was updated successfully.");
        } else {
            redirectWithError(req, res, "/admin/users", "Could not update the user account status.");
        }
    }

    private void handleCreateCustomer(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        List<String> errors = ValidationUtil.newErrorList();
        String fullName = ValidationUtil.require(req.getParameter("fullName"), "Customer name", errors);
        String email = ValidationUtil.require(req.getParameter("email"), "Email", errors);
        String phone = clean(req.getParameter("phone"));
        String password = ValidationUtil.require(req.getParameter("password"), "Temporary password", errors);
        String status = clean(req.getParameter("status"));
        String membershipLevel = clean(req.getParameter("membershipLevel"));

        if (!ValidationUtil.isBlank(fullName) && !ValidationUtil.isValidPersonName(fullName)) {
            errors.add("Customer name should contain letters and spaces only.");
        }
        if (!ValidationUtil.isBlank(email) && !ValidationUtil.isValidEmail(email)) {
            errors.add("Please enter a valid customer email.");
        }
        if (!ValidationUtil.isValidPhone(phone)) {
            errors.add("Please enter a valid phone number or leave it blank.");
        }
        if (!ValidationUtil.isBlank(password) && !ValidationUtil.isValidPassword(password)) {
            errors.add("Temporary password must be at least 8 characters.");
        }
        if (status == null || !ALLOWED_STATUSES.contains(status.toUpperCase())) {
            errors.add("Choose a valid customer status.");
        }
        if (membershipLevel != null && membershipLevel.length() > 64) {
            errors.add("Membership level must be 64 characters or fewer.");
        }
        if (errors.isEmpty() && new UserDAO().isEmailTaken(email)) {
            errors.add("That email is already registered.");
        }

        if (!errors.isEmpty()) {
            req.setAttribute("users", dao.listUsers());
            req.setAttribute("customerForm", buildCustomerForm(fullName, email, phone, status, membershipLevel));
            forwardWithErrors(req, res, "/admin/users.jsp", "users", errors);
            return;
        }

        boolean created = dao.createCustomer(fullName.trim(), email.trim(), phone,
                password, status.toUpperCase(), membershipLevel);
        if (created) {
            redirectWithSuccess(req, res, "/admin/users", "Customer account was added successfully.");
        } else {
            redirectWithError(req, res, "/admin/users", "Could not add the customer account.");
        }
    }

    private Map<String, String> buildCustomerForm(String fullName, String email, String phone, String status,
            String membershipLevel) {
        Map<String, String> form = new LinkedHashMap<>();
        form.put("fullName", fullName == null ? "" : fullName);
        form.put("email", email == null ? "" : email);
        form.put("phone", phone == null ? "" : phone);
        form.put("status", status == null ? "APPROVED" : status);
        form.put("membershipLevel", membershipLevel == null ? "" : membershipLevel);
        return form;
    }
}
