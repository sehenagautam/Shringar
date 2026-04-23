package com.shringar.utils;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class CookieUtil {

    /**
     * Creates and adds a cookie to the response.
     * @param response The HttpServletResponse object
     * @param name     The name of the cookie
     * @param value    The value of the cookie
     * @param min      Max age in seconds
     */
    public static void addCookie(HttpServletResponse response, String name, String value, int min) {
        Cookie cookie = new Cookie(name, value);
        cookie.setPath("/");
        cookie.setMaxAge(min);
        cookie.setHttpOnly(true);
        response.addCookie(cookie);
    }

    /**
     * Deletes a cookie by setting its max age to 0.
     * @param response The HttpServletResponse object
     * @param name     The name of the cookie to delete
     */
    public static void deleteCookie(HttpServletResponse response, String name) {
        Cookie cookie = new Cookie(name, "");
        cookie.setPath("/");
        cookie.setMaxAge(0);
        response.addCookie(cookie);
    }

    /**
     * Optional: Helper to retrieve a cookie value by name
     */
    public static String getCookieValue(HttpServletRequest request, String name) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (name.equals(cookie.getName())) {
                    return cookie.getValue();
                }
            }
        }
        return null;
    }
}
