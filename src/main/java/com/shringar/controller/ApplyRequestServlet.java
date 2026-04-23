package com.shringar.controller;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.shringar.dao.ApplyRequestDAO;
import com.shringar.dao.ServiceDAO;
import com.shringar.model.ApplyRequest;
import com.shringar.model.User;
import com.shringar.utils.PortalAuth;
import com.shringar.utils.SessionUtil;
import com.shringar.utils.ValidationUtil;

@WebServlet({ "/apply", "/user/apply" })
public class ApplyRequestServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        if (!PortalAuth.requireUser(req, res)) {
            return;
        }

        User user = PortalAuth.currentUser(req);
        String serviceIdStr = req.getParameter("serviceId");
        String preferredDateStr = req.getParameter("preferredDate");
        String message = req.getParameter("message");

        List<String> errors = ValidationUtil.newErrorList();
        if (ValidationUtil.isBlank(serviceIdStr)) {
            errors.add("Please choose a service.");
        }

        int serviceId = -1;
        if (!ValidationUtil.isBlank(serviceIdStr)) {
            try {
                serviceId = Integer.parseInt(serviceIdStr.trim());
            } catch (NumberFormatException e) {
                errors.add("Invalid service.");
            }
        }

        LocalDate preferredDate = null;
        if (!ValidationUtil.isBlank(preferredDateStr)) {
            try {
                preferredDate = LocalDate.parse(preferredDateStr);
            } catch (Exception e) {
                errors.add("Preferred date is not valid.");
            }
        }

        if (!errors.isEmpty()) {
            SessionUtil.setAttribute(req, "flashError", String.join(" ", errors),
                    SessionUtil.USER_SESSION_TIMEOUT_SECONDS);
            res.sendRedirect(req.getContextPath() + "/search");
            return;
        }

        ServiceDAO serviceDAO = new ServiceDAO();
        if (serviceDAO.findById(serviceId) == null) {
            SessionUtil.setAttribute(req, "flashError", "That service is not available.",
                    SessionUtil.USER_SESSION_TIMEOUT_SECONDS);
            res.sendRedirect(req.getContextPath() + "/search");
            return;
        }

        ApplyRequest ar = new ApplyRequest();
        ar.setUserId(user.getUserId());
        ar.setServiceId(serviceId);
        ar.setPreferredDate(preferredDate);
        ar.setMessage(ValidationUtil.isBlank(message) ? null : message.trim());
        ar.setStatus("PENDING");

        ApplyRequestDAO dao = new ApplyRequestDAO();
        if (dao.insert(ar)) {
            SessionUtil.setAttribute(req, "flashSuccess",
                    "Your service request was submitted successfully. We will confirm it soon.",
                    SessionUtil.USER_SESSION_TIMEOUT_SECONDS);
        } else {
            SessionUtil.setAttribute(req, "flashError", "Could not submit your request. Please try again.",
                    SessionUtil.USER_SESSION_TIMEOUT_SECONDS);
        }

        res.sendRedirect(req.getContextPath() + "/search");
    }
}
