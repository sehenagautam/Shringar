package com.shringar.controller;

import com.shringar.service.RegisterService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("/pages/register").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            String userName   = request.getParameter("userName");
            String userEmail  = request.getParameter("userEmail");
            String userPhone  = request.getParameter("userPhone");
            String password   = request.getParameter("password");

            RegisterService service = new RegisterService();
            boolean isRegistered = service.addUser(userName, userEmail, userPhone, password);

            if (isRegistered) {
                response.sendRedirect(request.getContextPath() + "/login?success=registered");
            } else {
                request.setAttribute("error", "Email or Phone number already exists!");
                request.getRequestDispatcher("/pages/register.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Registration failed! Please try again.");
            request.getRequestDispatcher("/pages/register.jsp").forward(request, response);
        }
    }
}