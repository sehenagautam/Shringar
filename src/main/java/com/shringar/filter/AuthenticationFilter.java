package com.shringar.filter;

import java.io.IOException;

import com.shringar.utils.SessionUtil;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebFilter(urlPatterns = {
        "/admin/*",
        "/pages/admin-dashboard.jsp",
        "/user/dashboard",
        "/user/profile",
        "/user/search",
        "/user/wishlist",
        "/user/apply",
        "/user/dashboard.jsp",
        "/user/profile.jsp",
        "/user/search.jsp",
        "/user/wishlist.jsp"
})
public class AuthenticationFilter extends HttpFilter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        boolean isLoggedIn = SessionUtil.getAttribute(httpRequest, "user") != null;
        boolean isAdminPage = httpRequest.getRequestURI() != null
                && (httpRequest.getRequestURI().contains(httpRequest.getContextPath() + "/admin/")
                        || httpRequest.getRequestURI().endsWith("/pages/admin-dashboard.jsp")
                        || httpRequest.getRequestURI().endsWith("/admin/dashboard"));

        if (!isLoggedIn) {
            httpResponse.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
            if (SessionUtil.hasExpiredSession(httpRequest)) {
                SessionUtil.invalidateSession(httpRequest);
                httpResponse.sendRedirect(httpRequest.getContextPath() + "/login?expired=1");
            } else {
                httpResponse.sendRedirect(httpRequest.getContextPath() + "/login");
            }
            return;
        }

        if (isAdminPage) {
            Object userRole = SessionUtil.getAttribute(httpRequest, "userRole");
            if (!"ADMIN".equalsIgnoreCase(String.valueOf(userRole))) {
                httpResponse.sendRedirect(httpRequest.getContextPath() + "/user/dashboard");
                return;
            }
        }

        chain.doFilter(request, response);
    }
}
