package com.shringar.filter;

import com.shringar.utils.SessionUtil;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebFilter(urlPatterns = {"/pages/admin-dashboard.jsp", "/pages/user.jsp"})
public class AuthenticationFilter extends HttpFilter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        boolean isLoggedIn = SessionUtil.getAttribute(httpRequest, "user") != null;

        if (isLoggedIn) {
            chain.doFilter(request, response);
        } else {
            httpResponse.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login");
        }
    }
}