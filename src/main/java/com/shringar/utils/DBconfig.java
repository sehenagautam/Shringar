package com.shringar.utils;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBconfig {
    private static final String URL = "jdbc:mysql://localhost:3306/salon_booking_system_db";
    private static final String USER = "root";
    private static final String PASSWORD = "";

    public static Connection getConnection() {
        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("✅ Connected to salon_booking_system_db");
        } catch (Exception e) {
            System.out.println("❌ DB Connection Failed");
            e.printStackTrace();
        }
        return conn;
    }
}