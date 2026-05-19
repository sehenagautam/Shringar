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

/**
 * This servlet handles the main admin dashboard view.
 * It's responsible for fetching all the summary data like revenue and user counts.
 */
@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends AdminBaseServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        // First, we check if the person is actually an admin.
        // Safety first!
        if (!requireAdmin(req, res)) {
            return;
        }

        // Let's grab the current user to display their name on the dashboard
        User currentUser = PortalAuth.currentUser(req);
        
        // The DAO handles the heavy lifting of calculating stats from the database
        AdminDashboardData dashboard = new AdminDashboardDAO().loadDashboardData();
        
        // Default to 'Admin' if for some reason the name is missing
        dashboard.setAdminDisplayName(currentUser != null && currentUser.getName() != null
                ? currentUser.getName()
                : "Admin");

        // Set the data as an attribute so the JSP can pick it up
        req.setAttribute("dashboard", dashboard);
        
        // Mark this as the 'dashboard' page for the sidebar navigation highlighting
        prepareAdminPage(req, "dashboard");
        
        // Finally, send the user to the dashboard view
        req.getRequestDispatcher("/pages/admin-dashboard.jsp").forward(req, res);
    }
}
