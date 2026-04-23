package com.java_web_app.controller;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.java_web_app.dao.ApplyRequestDAO;
import com.java_web_app.dao.ServiceDAO;
import com.java_web_app.model.ApplyRequest;
import com.java_web_app.model.User;
import com.java_web_app.utils.PortalAuth;
import com.java_web_app.utils.ValidationUtil;

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
            req.getSession().setAttribute("flashError", String.join(" ", errors));
            res.sendRedirect(req.getContextPath() + "/search");
            return;
        }

        ServiceDAO serviceDAO = new ServiceDAO();
        if (serviceDAO.findById(serviceId) == null) {
            req.getSession().setAttribute("flashError", "That service is not available.");
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
            req.getSession().setAttribute("flashSuccess", "Your service request was submitted successfully. We will confirm it soon.");
        } else {
            req.getSession().setAttribute("flashError", "Could not submit your request. Please try again.");
        }

        res.sendRedirect(req.getContextPath() + "/search");
    }
}
