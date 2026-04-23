package com.java_web_app.controller;

import java.io.IOException;
import java.util.Collections;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.java_web_app.dao.ServiceDAO;
import com.java_web_app.model.Service;
import com.java_web_app.utils.PortalAuth;
import com.java_web_app.utils.ValidationUtil;

@WebServlet({ "/book", "/user/book" })
public class BookAppointmentServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        if (!PortalAuth.requireUser(req, res)) {
            return;
        }

        String serviceIdStr = req.getParameter("serviceId");
        if (ValidationUtil.isBlank(serviceIdStr)) {
            req.setAttribute("errors", Collections.singletonList("Please choose a service to book."));
            req.getRequestDispatcher("/user/search.jsp").forward(req, res);
            return;
        }

        int serviceId;
        try {
            serviceId = Integer.parseInt(serviceIdStr.trim());
        } catch (NumberFormatException e) {
            req.setAttribute("errors", Collections.singletonList("Invalid service."));
            req.getRequestDispatcher("/user/search.jsp").forward(req, res);
            return;
        }

        ServiceDAO dao = new ServiceDAO();
        Service service = dao.findById(serviceId);
        if (service == null) {
            req.setAttribute("errors", Collections.singletonList("That service is not available."));
            req.getRequestDispatcher("/user/search.jsp").forward(req, res);
            return;
        }

        req.setAttribute("service", service);
        req.getRequestDispatcher("/user/book.jsp").forward(req, res);
    }
}

