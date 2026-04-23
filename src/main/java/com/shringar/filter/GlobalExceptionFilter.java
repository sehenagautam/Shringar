package com.shringar.filter;

import java.io.IOException;

import com.shringar.utils.ExceptionUtil;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebFilter("/*")
public class GlobalExceptionFilter extends HttpFilter {

    @Override
    protected void doFilter(HttpServletRequest request, HttpServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        try {
            chain.doFilter(request, response);
        } catch (Throwable throwable) {
            ExceptionUtil.log("Unhandled request failure for " + request.getMethod() + " " + request.getRequestURI(),
                    throwable);

            if (response.isCommitted()) {
                if (throwable instanceof IOException) {
                    throw (IOException) throwable;
                }
                if (throwable instanceof ServletException) {
                    throw (ServletException) throwable;
                }
                throw new ServletException(throwable);
            }

            response.resetBuffer();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            request.setAttribute("friendlyErrorTitle", "Something went wrong on our side.");
            request.setAttribute("friendlyErrorMessage",
                    "Please try again in a moment. If the problem continues, contact the Shringar team.");
            request.setAttribute("failedPath", request.getRequestURI());
            request.getRequestDispatcher("/errors/500.jsp").forward(request, response);
        }
    }
}
