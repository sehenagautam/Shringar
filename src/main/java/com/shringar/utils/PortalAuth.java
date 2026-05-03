package com.shringar.utils;

import java.io.IOException;

import com.shringar.model.User;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public final class PortalAuth {

    private PortalAuth() {
    }

    public static User currentUser(HttpServletRequest req) {
        // Central safe-cast so controllers do not repeat session plumbing.
        Object o = SessionUtil.getAttribute(req, "user");
        if (o instanceof User) {
            return (User) o;
        }
        return null;
    }

    public static boolean requireUser(HttpServletRequest req, HttpServletResponse res) throws IOException {
        User u = currentUser(req);
        if (u == null || u.getUserId() <= 0) {
            // Match the filter behavior so auth redirects feel consistent no
            // matter which protected entry point was hit first.
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
