package com.shringar.filter;

import com.shringar.utils.SessionUtil;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebFilter(urlPatterns = {"/login", "/register", "/pages/login.jsp", "/pages/register.jsp"})
public class GuestFilter extends HttpFilter {

    @Override
    protected void doFilter(HttpServletRequest request, HttpServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        boolean isLoggedIn = SessionUtil.getAttribute(request, "user") != null;

        if (isLoggedIn) {
            response.sendRedirect(request.getContextPath() + "/pages/user.jsp");
        } else {
            chain.doFilter(request, response);
        }
    }
}