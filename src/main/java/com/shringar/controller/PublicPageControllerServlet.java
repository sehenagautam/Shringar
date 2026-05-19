package com.shringar.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.shringar.dao.ServiceDAO;
import com.shringar.model.Service;
import com.shringar.utils.SalonMediaUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class PublicPageControllerServlet extends HttpServlet {

    private static final Map<String, String> VIEW_BY_PATH = new HashMap<>();

    static {
        VIEW_BY_PATH.put("/aboutus", "/aboutus.jsp");
        VIEW_BY_PATH.put("/pages/services", "/pages/services.jsp");
        VIEW_BY_PATH.put("/pages/Gallery", "/pages/Gallery.jsp");
        VIEW_BY_PATH.put("/pages/gallery", "/pages/Gallery.jsp");
        VIEW_BY_PATH.put("/pages/hair", "/pages/hair.jsp");
        VIEW_BY_PATH.put("/pages/makeup", "/pages/makeup.jsp");
        VIEW_BY_PATH.put("/pages/nail", "/pages/nail.jsp");
        VIEW_BY_PATH.put("/pages/gallery/hair", "/pages/gallery-hair.jsp");
        VIEW_BY_PATH.put("/pages/gallery/makeup", "/pages/gallery-makeup.jsp");
        VIEW_BY_PATH.put("/pages/gallery/nail", "/pages/gallery-nail.jsp");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String servletPath = req.getServletPath();

        if ("/pages/appointment".equals(servletPath) || "/pages/appointments".equals(servletPath)) {
            res.sendRedirect(req.getContextPath() + "/search");
            return;
        }

        String view = VIEW_BY_PATH.get(servletPath);
        if (view == null) {
            res.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        if ("/pages/hair".equals(servletPath) || "/pages/makeup".equals(servletPath) || "/pages/nail".equals(servletPath)) {
            String category = servletPath.substring(servletPath.lastIndexOf("/") + 1);
            category = category.substring(0, 1).toUpperCase() + category.substring(1);
            ServiceDAO dao = new ServiceDAO();
            List<Service> services = dao.listByCategory(category);
            req.setAttribute("services", services);
            req.setAttribute("serviceImageMap", SalonMediaUtil.buildServiceImageMap(services));
        } else if ("/pages/services".equals(servletPath)) {
            ServiceDAO dao = new ServiceDAO();
            List<Service> allServices = dao.listAllActive();
            req.setAttribute("allServices", allServices);
            req.setAttribute("serviceImageMap", SalonMediaUtil.buildServiceImageMap(allServices));
        }

        req.getRequestDispatcher(view).forward(req, res);
    }
}
