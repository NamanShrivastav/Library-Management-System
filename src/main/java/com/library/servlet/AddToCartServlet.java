package com.library.servlet;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import com.library.dao.DBConnection;

public class AddToCartServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // ✅ CHECK LOGIN
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            int bookId = Integer.parseInt(request.getParameter("id"));
            String username = session.getAttribute("user").toString();

            Connection con = DBConnection.getConnection();

            // ✅ CHECK IF BOOK ALREADY IN CART
            PreparedStatement check = con.prepareStatement(
                    "SELECT * FROM cart WHERE username=? AND book_id=?"
            );
            check.setString(1, username);
            check.setInt(2, bookId);

            ResultSet rs = check.executeQuery();

            if (rs.next()) {
                // 🔁 UPDATE QUANTITY
                PreparedStatement update = con.prepareStatement(
                        "UPDATE cart SET quantity = quantity + 1 WHERE username=? AND book_id=?"
                );
                update.setString(1, username);
                update.setInt(2, bookId);
                update.executeUpdate();

            } else {
                // ➕ INSERT NEW BOOK
                PreparedStatement insert = con.prepareStatement(
                        "INSERT INTO cart(username, book_id, quantity) VALUES (?, ?, 1)"
                );
                insert.setString(1, username);
                insert.setInt(2, bookId);
                insert.executeUpdate();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        // ✅ REDIRECT BACK
        response.sendRedirect("viewBooks.jsp");
    }
}