package com.shringar.controller;

import java.io.IOException;

import com.shringar.dao.AdminDashboardDAO;
import com.shringar.model.AdminDashboardData;
import com.shringar.model.User;
import com.shringar.utils.AdminAccessUtil;
import com.shringar.utils.PortalAuth;
import com.shringar.utils.SessionUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        if (!PortalAuth.requireUser(req, res)) {
            return;
        }

        User currentUser = PortalAuth.currentUser(req);
        if (!AdminAccessUtil.isAdminUser(currentUser)
                && !"ADMIN".equalsIgnoreCase(String.valueOf(SessionUtil.getAttribute(req, "userRole")))) {
            res.sendRedirect(req.getContextPath() + "/user/dashboard");
            return;
        }

        AdminDashboardData dashboard = new AdminDashboardDAO().loadDashboardData();
        dashboard.setAdminDisplayName(currentUser != null && currentUser.getName() != null
                ? currentUser.getName()
                : "Admin");

        req.setAttribute("dashboard", dashboard);
        req.setAttribute("activePage", "dashboard");
        req.getRequestDispatcher("/pages/admin-dashboard.jsp").forward(req, res);
    }
}
