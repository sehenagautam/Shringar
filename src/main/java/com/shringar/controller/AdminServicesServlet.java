package com.shringar.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

import com.shringar.dao.AdminManagementDAO;
import com.shringar.model.Service;
import com.shringar.utils.ValidationUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/services")
public class AdminServicesServlet extends AdminBaseServlet {

    private final AdminManagementDAO dao = new AdminManagementDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        if (!requireAdmin(req, res)) {
            return;
        }
        prepareServicesPage(req);
        req.getRequestDispatcher("/admin/services.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        if (!requireAdmin(req, res)) {
            return;
        }

        String action = clean(req.getParameter("action"));
        if ("deactivate".equalsIgnoreCase(action)) {
            handleDeactivate(req, res);
            return;
        }

        List<String> errors = ValidationUtil.newErrorList();
        Service service = buildServiceFromRequest(req, errors);
        boolean update = "update".equalsIgnoreCase(action);

        if (update) {
            service.setServiceId(parsePositiveInt(req.getParameter("serviceId"), "Service", errors));
        }

        if (!errors.isEmpty()) {
            req.setAttribute("formService", service);
            req.setAttribute("editingService", update);
            prepareServicesPage(req);
            forwardWithErrors(req, res, "/admin/services.jsp", "services", errors);
            return;
        }

        boolean ok = update ? dao.updateService(service) : dao.createService(service);
        if (ok) {
            redirectWithSuccess(req, res, "/admin/services",
                    update ? "Service was updated successfully." : "Service was created successfully.");
        } else {
            redirectWithError(req, res, "/admin/services",
                    update ? "Could not update the service. Check if the service code is already used."
                            : "Could not create the service. Check if the service code is already used.");
        }
    }

    private void handleDeactivate(HttpServletRequest req, HttpServletResponse res) throws IOException {
        List<String> errors = ValidationUtil.newErrorList();
        int serviceId = parsePositiveInt(req.getParameter("serviceId"), "Service", errors);
        if (!errors.isEmpty()) {
            redirectWithError(req, res, "/admin/services", String.join(" ", errors));
            return;
        }
        if (dao.deactivateService(serviceId)) {
            redirectWithSuccess(req, res, "/admin/services", "Service was deactivated successfully.");
        } else {
            redirectWithError(req, res, "/admin/services", "Could not deactivate the service.");
        }
    }

    private void prepareServicesPage(HttpServletRequest req) {
        prepareAdminPage(req, "services");
        req.setAttribute("services", dao.listServicesForAdmin());

        String editId = clean(req.getParameter("editId"));
        if (editId != null) {
            List<String> errors = ValidationUtil.newErrorList();
            int serviceId = parsePositiveInt(editId, "Service", errors);
            if (errors.isEmpty()) {
                req.setAttribute("formService", dao.findServiceById(serviceId));
                req.setAttribute("editingService", true);
            }
        }
    }

    private Service buildServiceFromRequest(HttpServletRequest req, List<String> errors) {
        Service service = new Service();
        String serviceName = ValidationUtil.require(req.getParameter("serviceName"), "Service name", errors);
        String description = clean(req.getParameter("description"));
        String category = ValidationUtil.require(req.getParameter("category"), "Category", errors);
        String stylistName = ValidationUtil.require(req.getParameter("stylistName"), "Stylist name", errors);
        String serviceCode = ValidationUtil.require(req.getParameter("serviceCode"), "Service code", errors);
        String priceValue = ValidationUtil.require(req.getParameter("price"), "Price", errors);
        String durationValue = ValidationUtil.require(req.getParameter("durationMinutes"), "Duration", errors);

        if (!ValidationUtil.isBlank(serviceCode) && !ValidationUtil.isValidServiceCode(serviceCode)) {
            errors.add("Service code can only contain letters, numbers, and hyphens.");
        }

        BigDecimal price = BigDecimal.ZERO;
        if (!ValidationUtil.isBlank(priceValue)) {
            try {
                price = new BigDecimal(priceValue.trim());
                if (price.compareTo(BigDecimal.ZERO) < 0) {
                    errors.add("Price cannot be negative.");
                }
            } catch (NumberFormatException e) {
                errors.add("Price must be a valid amount.");
            }
        }

        int duration = 0;
        if (!ValidationUtil.isBlank(durationValue)) {
            try {
                duration = Integer.parseInt(durationValue.trim());
                if (duration <= 0) {
                    errors.add("Duration must be greater than zero.");
                }
            } catch (NumberFormatException e) {
                errors.add("Duration must be a valid number.");
            }
        }

        service.setServiceName(serviceName);
        service.setDescription(description);
        service.setCategory(category);
        service.setStylistName(stylistName);
        service.setServiceCode(serviceCode == null ? null : serviceCode.trim().toUpperCase());
        service.setPrice(price);
        service.setDurationMinutes(duration);
        service.setActive("1".equals(req.getParameter("isActive")));
        return service;
    }
}
