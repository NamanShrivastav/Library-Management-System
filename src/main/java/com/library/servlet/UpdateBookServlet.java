package com.library.servlet;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import com.library.dao.DBConnection;

public class UpdateBookServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String price = request.getParameter("price");

        try {
            Connection con = DBConnection.getConnection();

            String query = "UPDATE books SET title=?, author=?, price=? WHERE id=?";
            PreparedStatement ps = con.prepareStatement(query);

            ps.setString(1, title);
            ps.setString(2, author);
            ps.setDouble(3, Double.parseDouble(price));
            ps.setInt(4, id);

            ps.executeUpdate();

            response.sendRedirect("viewBooks.jsp");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}