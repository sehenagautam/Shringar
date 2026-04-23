package com.java_web_app.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.java_web_app.dao.ServiceDAO;
import com.java_web_app.utils.PortalAuth;
import com.java_web_app.utils.ValidationUtil;
import com.java_web_app.utils.WishlistHelper;

@WebServlet({ "/wishlist", "/user/wishlist" })
public class WishlistServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        if (!PortalAuth.requireUser(req, res)) {
            return;
        }
        Object flash = req.getSession().getAttribute("flashSuccess");
        if (flash != null) {
            req.setAttribute("message", flash);
            req.getSession().removeAttribute("flashSuccess");
        }
        ServiceDAO serviceDAO = new ServiceDAO();
        req.setAttribute("wishlistServices", WishlistHelper.resolve(req, serviceDAO));
        req.getRequestDispatcher("/user/wishlist.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException {
        if (!PortalAuth.requireUser(req, res)) {
            return;
        }

        String action = req.getParameter("action");
        String serviceIdStr = req.getParameter("serviceId");

        if (ValidationUtil.isBlank(serviceIdStr)) {
            res.sendRedirect(req.getContextPath() + "/wishlist");
            return;
        }

        int serviceId;
        try {
            serviceId = Integer.parseInt(serviceIdStr.trim());
        } catch (NumberFormatException e) {
            res.sendRedirect(req.getContextPath() + "/wishlist");
            return;
        }

        if ("remove".equalsIgnoreCase(action)) {
            WishlistHelper.remove(req, serviceId);
            req.getSession().setAttribute("flashSuccess", "Removed from wishlist.");
        } else {
            WishlistHelper.add(req, serviceId);
            req.getSession().setAttribute("flashSuccess", "Saved to your wishlist (session).");
        }

        String back = req.getParameter("redirect");
        if (back != null && !back.isEmpty() && back.startsWith("/")) {
            res.sendRedirect(req.getContextPath() + back);
        } else {
            res.sendRedirect(req.getContextPath() + "/wishlist");
        }
    }
}
