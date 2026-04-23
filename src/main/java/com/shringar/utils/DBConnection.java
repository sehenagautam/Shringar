package com.shringar.utils;

import java.sql.Connection;

public class DBConnection {

    public static Connection getConnection() {
        return DBconfig.getConnection();
    }
}
