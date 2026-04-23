package com.shringar.controller;

import java.io.IOException;
import java.util.List;
import java.util.Set;

import com.shringar.dao.AdminManagementDAO;
import com.shringar.utils.ValidationUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/requests")
public class AdminRequestsServlet extends AdminBaseServlet {

    private static final Set<String> ALLOWED_STATUSES = Set.of("PENDING", "APPROVED", "REJECTED");
    private final AdminManagementDAO dao = new AdminManagementDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        if (!requireAdmin(req, res)) {
            return;
        }
        prepareAdminPage(req, "requests");
        req.setAttribute("requests", dao.listRequestsForAdmin());
        req.getRequestDispatcher("/admin/requests.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        if (!requireAdmin(req, res)) {
            return;
        }

        List<String> errors = ValidationUtil.newErrorList();
        int requestId = parsePositiveInt(req.getParameter("requestId"), "Request", errors);
        String status = clean(req.getParameter("status"));
        if (status == null || !ALLOWED_STATUSES.contains(status.toUpperCase())) {
            errors.add("Choose a valid request status.");
        }

        if (!errors.isEmpty()) {
            req.setAttribute("requests", dao.listRequestsForAdmin());
            forwardWithErrors(req, res, "/admin/requests.jsp", "requests", errors);
            return;
        }

        if (dao.updateRequestStatus(requestId, status.toUpperCase())) {
            setSuccess(req, "Request status was updated successfully.");
        } else {
            setError(req, "Could not update the request status.");
        }
        res.sendRedirect(req.getContextPath() + "/admin/requests");
    }
}
