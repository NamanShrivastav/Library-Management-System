package com.library.dao;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

    public static Connection getConnection() {
        Connection con = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/library_db",
                    "root",
                    "naman123"
            );

        } catch (Exception e) {
            e.printStackTrace();
        }

        return con;
    }

    // 👇 ADD THIS HERE (inside class)
    public static void main(String[] args) {
        Connection con = getConnection();

        if (con != null) {
            System.out.println("Connected to DB ✅");
        } else {
            System.out.println("Connection Failed ❌");
        }
    }
}