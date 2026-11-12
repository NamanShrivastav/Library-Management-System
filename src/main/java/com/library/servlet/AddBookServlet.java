package com.library.servlet;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.library.dao.DBConnection;

public class AddBookServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String priceStr = request.getParameter("price");

// 🔴 VALIDATION
        if (title == null || title.trim().isEmpty() ||
                author == null || author.trim().isEmpty() ||
                priceStr == null || priceStr.trim().isEmpty()) {

            response.sendRedirect("addBook.jsp?error=All fields required");
            return;
        }

        double price = 0;

        try {
            price = Double.parseDouble(priceStr);
            if (price <= 0) {
                response.sendRedirect("addBook.jsp?error=Invalid price");
                return;
            }
        } catch (Exception e) {
            response.sendRedirect("addBook.jsp?error=Invalid price");
            return;
        }

// ✅ ONLY AFTER VALIDATION → INSERT
        Connection con = DBConnection.getConnection();
        PreparedStatement ps = null;
        try {
            ps = con.prepareStatement(
                    "INSERT INTO books(title, author, price) VALUES(?,?,?)"
            );
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        try {
            ps.setString(1, title);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        try {
            ps.setString(2, author);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        try {
            ps.setDouble(3, price);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        try {
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        response.sendRedirect("viewBooks.jsp");
    }
}