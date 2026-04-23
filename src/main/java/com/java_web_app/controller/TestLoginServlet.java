package com.java_web_app.controller;

import java.io.IOException;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.java_web_app.dao.UserDAO;
import com.java_web_app.model.User;
import com.java_web_app.utils.SessionUtil;

@WebServlet("/test-login")
public class TestLoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException {
        UserDAO dao = new UserDAO();
        User user = dao.findByEmail("demo@salon.com");
        if (user == null) {
            res.sendRedirect(req.getContextPath() + "/register");
            return;
        }
        if (!"APPROVED".equalsIgnoreCase(user.getStatus())) {
            res.sendError(HttpServletResponse.SC_FORBIDDEN, "Demo user is not approved in the database.");
            return;
        }
        SessionUtil.setAttribute(req, "user", user, 60 * 60 * 2);
        res.sendRedirect(req.getContextPath() + "/user/dashboard");
    }
}
