package com.shringar.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.shringar.dao.ServiceDAO;
import com.shringar.utils.PortalAuth;
import com.shringar.utils.SessionUtil;
import com.shringar.utils.ValidationUtil;
import com.shringar.utils.WishlistHelper;

@WebServlet({ "/wishlist", "/user/wishlist" })
public class WishlistServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        if (!PortalAuth.requireUser(req, res)) {
            return;
        }
        Object flash = SessionUtil.getAttribute(req, "flashSuccess");
        if (flash != null) {
            req.setAttribute("message", flash);
            SessionUtil.removeAttribute(req, "flashSuccess");
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
            SessionUtil.setAttribute(req, "flashSuccess", "Removed from wishlist.",
                    SessionUtil.USER_SESSION_TIMEOUT_SECONDS);
        } else {
            WishlistHelper.add(req, serviceId);
            SessionUtil.setAttribute(req, "flashSuccess", "Saved to your wishlist (session).",
                    SessionUtil.USER_SESSION_TIMEOUT_SECONDS);
        }

        String back = req.getParameter("redirect");
        if (back != null && !back.isEmpty() && back.startsWith("/")) {
            res.sendRedirect(req.getContextPath() + back);
        } else {
            res.sendRedirect(req.getContextPath() + "/wishlist");
        }
    }
}
