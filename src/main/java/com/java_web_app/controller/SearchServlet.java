package com.java_web_app.controller;

import java.io.IOException;
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
import com.java_web_app.utils.WishlistHelper;

@WebServlet({ "/search", "/user/search" })
public class SearchServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        if (!PortalAuth.requireUser(req, res)) {
            return;
        }

        Object flashOk = req.getSession().getAttribute("flashSuccess");
        if (flashOk != null) {
            req.setAttribute("message", flashOk);
            req.getSession().removeAttribute("flashSuccess");
        }
        Object flashErr = req.getSession().getAttribute("flashError");
        if (flashErr != null) {
            req.setAttribute("flashError", flashErr);
            req.getSession().removeAttribute("flashError");
        }

        String stylist = req.getParameter("stylist");
        String serviceCode = req.getParameter("serviceCode");
        String keyword = req.getParameter("q");
        String category = req.getParameter("category");

        ServiceDAO dao = new ServiceDAO();
        dao.ensureDefaultServices();
        List<Service> results;
        List<String> hints = ValidationUtil.newErrorList();

        boolean hasStylist = !ValidationUtil.isBlank(stylist);
        boolean hasCode = !ValidationUtil.isBlank(serviceCode);
        boolean hasKeyword = !ValidationUtil.isBlank(keyword);
        boolean hasCategory = !ValidationUtil.isBlank(category);

        if (hasCode && !ValidationUtil.isValidServiceCode(serviceCode.trim())) {
            results = dao.listAllActive();
            hints.add("Service code format is invalid. Use numbers only (3-6 digits), for example 100.");
            hints.add("Showing all services until you provide a valid code.");
        } else if (!hasStylist && !hasCode && !hasKeyword && !hasCategory) {
            results = dao.listAllActive();
            hints.add("Showing all available services. Use filters to narrow it down.");
        } else {
            results = dao.searchAdvanced(stylist, serviceCode, keyword, category);
            hints.add("Showing filtered results based on your search.");
            if (hasCategory) {
                hints.add("Category filter: " + category.trim());
            }
        }

        req.setAttribute("results", results);
        req.setAttribute("searchHints", hints);
        req.setAttribute("stylist", stylist);
        req.setAttribute("serviceCode", serviceCode);
        req.setAttribute("q", keyword);
        req.setAttribute("category", category);
        req.setAttribute("categories", dao.listDistinctCategories());
        req.setAttribute("wishlistIds", WishlistHelper.getIds(req));

        req.getRequestDispatcher("/user/search.jsp").forward(req, res);
    }
}
