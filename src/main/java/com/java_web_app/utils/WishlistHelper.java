package com.java_web_app.utils;

import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

import jakarta.servlet.http.HttpServletRequest;

import com.java_web_app.dao.ServiceDAO;
import com.java_web_app.model.Service;

/**
 * Keeps wishlist service IDs in the session (no database table).
 */
public final class WishlistHelper {

    public static final String SESSION_KEY = "wishlistServiceIds";

    private WishlistHelper() {
    }

    @SuppressWarnings("unchecked")
    public static Set<Integer> getIds(HttpServletRequest request) {
        Object raw = request.getSession(true).getAttribute(SESSION_KEY);
        if (raw instanceof Set) {
            return (Set<Integer>) raw;
        }
        LinkedHashSet<Integer> created = new LinkedHashSet<>();
        request.getSession(true).setAttribute(SESSION_KEY, created);
        return created;
    }

    public static void add(HttpServletRequest request, int serviceId) {
        getIds(request).add(serviceId);
    }

    public static void remove(HttpServletRequest request, int serviceId) {
        getIds(request).remove(serviceId);
    }

    public static List<Service> resolve(HttpServletRequest request, ServiceDAO dao) {
        List<Integer> ids = new ArrayList<>(getIds(request));
        return dao.findByIds(ids);
    }
}
