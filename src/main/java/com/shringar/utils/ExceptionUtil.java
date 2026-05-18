package com.shringar.utils;

import java.util.logging.Level;
import java.util.logging.Logger;

public final class ExceptionUtil {

    private static final Logger LOGGER = Logger.getLogger(ExceptionUtil.class.getName());

    private ExceptionUtil() {
    }

    public static void log(String context, Exception exception) {
        LOGGER.log(Level.SEVERE, context, exception);
    }

    public static void log(String context, Throwable throwable) {
        LOGGER.log(Level.SEVERE, context, throwable);
    }
}
