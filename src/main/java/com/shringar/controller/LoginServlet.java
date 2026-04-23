package com.shringar.controller;

import com.shringar.dao.UserDAO;
import com.shringar.model.UserModel;
import com.shringar.service.LoginService;
import com.shringar.utils.SessionUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("/pages/login").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String email    = request.getParameter("email");
        String password = request.getParameter("password");

        LoginService service = new LoginService();
        String status = service.authenticate(email, password);

        if ("Success".equals(status)) {
            try {
                UserDAO dao = new UserDAO();
                UserModel user = dao.getUserByEmail(email);

                // Store user in session
                SessionUtil.setAttribute(request, "user", user, 7200);        // 2 hours
                SessionUtil.setAttribute(request, "userRole", user.getUserRole(), 7200);

                // Role-based redirect
                if ("ADMIN".equals(user.getUserRole())) {
                    response.sendRedirect(request.getContextPath() + "/pages/admin-dashboard.jsp");
                } else {
                    response.sendRedirect(request.getContextPath() + "/pages/user.jsp");
                }
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", "Login error occurred");
                request.getRequestDispatcher("/pages/login.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("error", status);
            request.setAttribute("typedEmail", email);
            request.getRequestDispatcher("/pages/login.jsp").forward(request, response);
        }
    }
}