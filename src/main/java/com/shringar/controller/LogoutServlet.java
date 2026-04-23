package com.shringar.controller;

import java.io.IOException;

import com.shringar.utils.SessionUtil;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet({ "/logout", "/user/logout" })
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException {
        SessionUtil.invalidateSession(req);
        res.sendRedirect(req.getContextPath() + "/login");
    }
}
