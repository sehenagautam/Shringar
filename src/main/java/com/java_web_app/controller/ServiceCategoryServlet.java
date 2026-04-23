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
import com.java_web_app.utils.ValidationUtil;

@WebServlet({ "/user/services/category" })
public class ServiceCategoryServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        if (!PortalAuth.requireUser(req, res)) {
            return;
        }

        String type = req.getParameter("type"); // makeup | hair | nail
        if (ValidationUtil.isBlank(type)) {
            res.sendRedirect(req.getContextPath() + "/user/services");
            return;
        }

        type = type.trim().toLowerCase();
        String title;
        String heroImage;
        List<String> categories;

        switch (type) {
        case "makeup":
            title = "Makeup Services";
            heroImage = "makeup.png";
            categories = Collections.singletonList("Bridal");
            break;
        case "hair":
            title = "Hair Cut Services";
            heroImage = "makeup2.png";
            categories = Arrays.asList("Hair care", "Hair colour");
            break;
        case "nail":
        case "nails":
            title = "Nail Services";
            heroImage = "makeup4.png";
            categories = Collections.singletonList("Nails");
            break;
        default:
            res.sendRedirect(req.getContextPath() + "/user/services");
            return;
        }

        ServiceDAO dao = new ServiceDAO();
        List<Service> services = dao.listByCategories(categories);

        req.setAttribute("pageTitle", title);
        req.setAttribute("heroImage", heroImage);
        req.setAttribute("services", services);
        req.getRequestDispatcher("/user/services-category.jsp").forward(req, res);
    }
}

