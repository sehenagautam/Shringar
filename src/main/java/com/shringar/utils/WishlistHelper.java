package com.shringar.utils;

import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

import jakarta.servlet.http.HttpServletRequest;

import com.shringar.dao.ServiceDAO;
import com.shringar.model.Service;

/**
 * Keeps wishlist service IDs in the session (no database table).
 */
public final class WishlistHelper {

    public static final String SESSION_KEY = "wishlistServiceIds";

    private WishlistHelper() {
    }

    @SuppressWarnings("unchecked")
    public static Set<Integer> getIds(HttpServletRequest request) {
        Object raw = SessionUtil.getAttribute(request, SESSION_KEY);
        if (raw instanceof Set) {
            return (Set<Integer>) raw;
        }
        // LinkedHashSet keeps the "saved" order predictable for the UI.
        LinkedHashSet<Integer> created = new LinkedHashSet<>();
        SessionUtil.setAttribute(request, SESSION_KEY, created, SessionUtil.USER_SESSION_TIMEOUT_SECONDS);
        return created;
    }

    public static void add(HttpServletRequest request, int serviceId) {
        getIds(request).add(serviceId);
    }

    public static void remove(HttpServletRequest request, int serviceId) {
        getIds(request).remove(serviceId);
    }

    public static List<Service> resolve(HttpServletRequest request, ServiceDAO dao) {
        // Resolve the lightweight session IDs into full service cards only
        // when the wishlist page actually needs to render them.
        List<Integer> ids = new ArrayList<>(getIds(request));
        return dao.findByIds(ids);
    }
}
