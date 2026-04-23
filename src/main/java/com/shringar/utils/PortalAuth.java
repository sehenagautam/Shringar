package com.shringar.utils;

import java.io.IOException;

import com.shringar.model.User;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public final class PortalAuth {

    private PortalAuth() {
    }

    public static User currentUser(HttpServletRequest req) {
        Object o = SessionUtil.getAttribute(req, "user");
        if (o instanceof User) {
            return (User) o;
        }
        return null;
    }

    public static boolean requireUser(HttpServletRequest req, HttpServletResponse res) throws IOException {
        User u = currentUser(req);
        if (u == null || u.getUserId() <= 0) {
            if (SessionUtil.hasExpiredSession(req)) {
                SessionUtil.invalidateSession(req);
                res.sendRedirect(req.getContextPath() + "/login?expired=1");
            } else {
                res.sendRedirect(req.getContextPath() + "/login");
            }
            return false;
        }
        return true;
    }
}
