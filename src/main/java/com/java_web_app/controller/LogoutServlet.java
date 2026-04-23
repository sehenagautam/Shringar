package com.java_web_app.controller;

import java.io.IOException;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.java_web_app.utils.SessionUtil;

@WebServlet({ "/logout", "/user/logout" })
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException {
        SessionUtil.invalidateSession(req);
        res.sendRedirect(req.getContextPath() + "/index.jsp");
    }
}
