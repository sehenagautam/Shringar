package com.shringar.utils;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class CookieUtil {

    /**
     * Creates and adds a cookie to the response.
     */
    public static void addCookie(HttpServletResponse response, String name, String value, int min) {
        Cookie cookie = new Cookie(name, value);
        cookie.setPath("/");
        cookie.setMaxAge(min);
        // The browser can send it back, but frontend code cannot read it.
        cookie.setHttpOnly(true);
        response.addCookie(cookie);
    }

    /**
     * Deletes a cookie by setting its max age to 0.
     */
    public static void deleteCookie(HttpServletResponse response, String name) {
        Cookie cookie = new Cookie(name, "");
        cookie.setPath("/");
        cookie.setMaxAge(0);
        response.addCookie(cookie);
    }

    /**
     * Read a cookie by name; handy for light personalization such as
     * remembering the last email used on the login form.
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
