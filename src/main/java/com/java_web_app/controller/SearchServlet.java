package com.java_web_app.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

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
        List<Service> results = new ArrayList<>();
        List<String> hints = new ArrayList<>();

        boolean hasStylist = !ValidationUtil.isBlank(stylist);
        boolean hasCode = !ValidationUtil.isBlank(serviceCode);
        boolean hasKeyword = !ValidationUtil.isBlank(keyword);
        boolean hasCategory = !ValidationUtil.isBlank(category);

        if (!hasStylist && !hasCode && !hasKeyword && !hasCategory) {
            results = dao.listAllActive();
            hints.add("Showing all available services. Use filters to narrow it down.");
        } else if (hasCategory && !hasStylist && !hasCode && !hasKeyword) {
            results = dao.listByCategory(category.trim());
            hints.add("Showing services in category: " + category.trim());
        } else if (hasStylist && hasCode) {
            if (!ValidationUtil.isValidServiceCode(serviceCode.trim())) {
                hints.add("Service code format is invalid. Use letters, numbers, or hyphens (3–40 characters).");
            } else {
                List<Service> byStylist = dao.searchByStylist(stylist.trim());
                Set<Integer> codeMatch = new LinkedHashSet<>();
                for (Service c : dao.searchByServiceCode(serviceCode.trim())) {
                    codeMatch.add(c.getServiceId());
                }
                for (Service s : byStylist) {
                    if (codeMatch.contains(s.getServiceId())) {
                        results.add(s);
                    }
                }
                hints.add("Showing services where stylist matches your text and service code matches exactly.");
            }
        } else if (hasCode) {
            if (!ValidationUtil.isValidServiceCode(serviceCode.trim())) {
                hints.add("Service code format is invalid.");
            } else {
                results = dao.searchByServiceCode(serviceCode.trim());
                hints.add("Showing an exact match for the service code.");
            }
        } else if (hasStylist) {
            results = dao.searchByStylist(stylist.trim());
            hints.add("Showing services by stylist name.");
        } else if (hasKeyword) {
            results = dao.searchKeyword(keyword.trim());
            hints.add("Showing services that match your keyword.");
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
