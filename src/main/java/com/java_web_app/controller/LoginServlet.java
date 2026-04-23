package com.java_web_app.controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.java_web_app.dao.UserDAO;
import com.java_web_app.model.User;
import com.java_web_app.utils.SessionUtil;
import com.java_web_app.utils.ValidationUtil;

@WebServlet({ "/login", "/user/login" })
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        req.getRequestDispatcher("/user/login.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        List<String> errors = ValidationUtil.newErrorList();
        ValidationUtil.require(email, "Email", errors);
        ValidationUtil.require(password, "Password", errors);

        if (!errors.isEmpty()) {
            req.setAttribute("errors", errors);
            req.getRequestDispatcher("/user/login.jsp").forward(req, res);
            return;
        }

        if (!ValidationUtil.isValidEmail(email)) {
            errors.add("Please enter a valid email address.");
            req.setAttribute("errors", errors);
            req.getRequestDispatcher("/user/login.jsp").forward(req, res);
            return;
        }

        UserDAO dao = new UserDAO();
        User u = dao.authenticate(email, password);
        if (u == null) {
            errors.add("Invalid email or password.");
            req.setAttribute("errors", errors);
            req.getRequestDispatcher("/user/login.jsp").forward(req, res);
            return;
        }

        if (!"APPROVED".equalsIgnoreCase(u.getStatus())) {
            errors.add("Your account is not approved yet. Please wait for an administrator.");
            req.setAttribute("errors", errors);
            req.getRequestDispatcher("/user/login.jsp").forward(req, res);
            return;
        }

        SessionUtil.setAttribute(req, "user", u, 60 * 60 * 2);
        res.sendRedirect(req.getContextPath() + "/user/dashboard");
    }
}
