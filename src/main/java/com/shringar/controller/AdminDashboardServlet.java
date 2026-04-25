package com.shringar.controller;

import java.io.IOException;

import com.shringar.dao.AdminDashboardDAO;
import com.shringar.model.AdminDashboardData;
import com.shringar.model.User;
import com.shringar.utils.PortalAuth;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends AdminBaseServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        if (!requireAdmin(req, res)) {
            return;
        }

        User currentUser = PortalAuth.currentUser(req);
        AdminDashboardData dashboard = new AdminDashboardDAO().loadDashboardData();
        dashboard.setAdminDisplayName(currentUser != null && currentUser.getName() != null
                ? currentUser.getName()
                : "Admin");

        req.setAttribute("dashboard", dashboard);
        prepareAdminPage(req, "dashboard");
        req.getRequestDispatcher("/pages/admin-dashboard.jsp").forward(req, res);
    }
}
