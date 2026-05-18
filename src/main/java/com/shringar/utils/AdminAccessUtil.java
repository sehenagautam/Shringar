package com.shringar.utils;

import com.shringar.model.User;

public final class AdminAccessUtil {

    public static final String ADMIN_EMAIL = "admin@shringar.com";

    private AdminAccessUtil() {
    }

    public static boolean isAdminEmail(String email) {
        return email != null && ADMIN_EMAIL.equalsIgnoreCase(email.trim());
    }

    public static boolean isAdminUser(User user) {
        return user != null && isAdminEmail(user.getEmail());
    }
}
