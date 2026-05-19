package com.salon.util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

    private static String url = "jdbc:mysql://localhost:3306/salon_booking";
    private static String user = "root";
    private static String password = "";

    public static Connection getConnection() {

        Connection con = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(url, user, password);
            System.out.println("Database Connected");
        } catch (Exception e) {
            e.printStackTrace();
        }

        return con;
    }
}