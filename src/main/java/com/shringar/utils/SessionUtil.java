package com.shringar.utils;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

public class SessionUtil {

    // A half-hour inactivity window keeps dashboards convenient without leaving
    // user sessions open forever on shared machines.
    public static final int USER_SESSION_TIMEOUT_SECONDS = 30 * 60;

    /**
     * Store a value in session and refresh the inactivity timeout at the same time.
     */
    public static void setAttribute(HttpServletRequest request, String name, Object value, int seconds) {
        HttpSession session = request.getSession(true);
        session.setAttribute(name, value);
        session.setMaxInactiveInterval(seconds);
    }

    /**
     * Read a session value without creating a new session for anonymous traffic.
     */
    public static Object getAttribute(HttpServletRequest request, String name) {
        HttpSession session = request.getSession(false);
        return (session != null) ? session.getAttribute(name) : null;
    }

    /**
     * Remove one key while leaving the rest of the session intact.
     */
    public static void removeAttribute(HttpServletRequest request, String name) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.removeAttribute(name);
        }
    }

    /**
     * Clear the whole session, typically during logout or expiry cleanup.
     */
    public static void invalidateSession(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
    }

    /**
     * Distinguish "no session yet" from "there was a session, but it expired."
     */
    public static boolean hasExpiredSession(HttpServletRequest request) {
        return request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid();
    }
}
