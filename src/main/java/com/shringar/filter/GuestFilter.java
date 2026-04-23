package com.shringar.filter;

import java.io.IOException;

import com.shringar.utils.SessionUtil;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebFilter(urlPatterns = {
        "/login",
        "/register",
        "/user/login",
        "/user/register",
        "/pages/user",
        "/pages/register",
        "/pages/user.jsp",
        "/pages/Register.jsp"
})
public class GuestFilter extends HttpFilter {

    @Override
    protected void doFilter(HttpServletRequest request, HttpServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        boolean isLoggedIn = SessionUtil.getAttribute(request, "user") != null;

        if (isLoggedIn) {
            Object userRole = SessionUtil.getAttribute(request, "userRole");
            response.sendRedirect(request.getContextPath()
                    + ("ADMIN".equalsIgnoreCase(String.valueOf(userRole)) ? "/admin/dashboard" : "/user/dashboard"));
            return;
        }

        chain.doFilter(request, response);
    }
}
