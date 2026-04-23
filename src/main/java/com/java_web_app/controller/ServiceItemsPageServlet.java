package com.java_web_app.controller;

import java.io.IOException;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.java_web_app.dao.ServiceDAO;
import com.java_web_app.model.Service;
import com.java_web_app.utils.PortalAuth;

@WebServlet({ "/user/services/makeup", "/user/services/hair", "/user/services/nails" })
public class ServiceItemsPageServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        if (!PortalAuth.requireUser(req, res)) {
            return;
        }

        String uri = req.getRequestURI();
        String jsp;
        List<String> categories;

        if (uri.endsWith("/makeup")) {
            jsp = "/user/makeup.jsp";
            categories = Arrays.asList("Bridal", "Makeup");
        } else if (uri.endsWith("/hair")) {
            jsp = "/user/hair.jsp";
            categories = Arrays.asList("Hair care", "Hair colour");
        } else if (uri.endsWith("/nails")) {
            jsp = "/user/nails.jsp";
            categories = Collections.singletonList("Nails");
        } else {
            res.sendRedirect(req.getContextPath() + "/user/services");
            return;
        }

        ServiceDAO dao = new ServiceDAO();
        dao.ensureDefaultServices();
        List<Service> services = dao.listByCategories(categories);
        req.setAttribute("services", services);
        req.getRequestDispatcher(jsp).forward(req, res);
    }
}

