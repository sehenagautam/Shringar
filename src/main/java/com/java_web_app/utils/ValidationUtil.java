package com.java_web_app.utils;

import java.util.ArrayList;
import java.util.List;
import java.util.regex.Pattern;

public final class ValidationUtil {

    private static final Pattern EMAIL = Pattern.compile(
            "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$");
    private static final Pattern PHONE = Pattern.compile("^[0-9+()\\-\\s]{7,20}$");
    private static final Pattern SERVICE_CODE = Pattern.compile("^[A-Za-z0-9\\-]{3,40}$");

    private ValidationUtil() {
    }

    public static boolean isBlank(String s) {
        return s == null || s.trim().isEmpty();
    }

    public static boolean isValidEmail(String email) {
        return !isBlank(email) && EMAIL.matcher(email.trim()).matches();
    }

    public static boolean isValidPhone(String phone) {
        if (isBlank(phone)) {
            return true;
        }
        return PHONE.matcher(phone.trim()).matches();
    }

    public static boolean isValidPassword(String password) {
        return password != null && password.length() >= 8;
    }

    public static boolean isValidServiceCode(String code) {
        return !isBlank(code) && SERVICE_CODE.matcher(code.trim()).matches();
    }

    public static String require(String value, String fieldLabel, List<String> errors) {
        if (isBlank(value)) {
            errors.add(fieldLabel + " is required.");
            return "";
        }
        return value.trim();
    }

    public static List<String> newErrorList() {
        return new ArrayList<>();
    }
}
