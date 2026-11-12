package com.library.servlet;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;

import com.library.dao.DBConnection;

public class SearchBookServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String keyword = request.getParameter("keyword");

        try {
            Connection con = DBConnection.getConnection();

            if (keyword == null || keyword.trim().isEmpty()) {
                response.sendRedirect("index.jsp?error=Enter search keyword");
                return;
            }
            String query = "SELECT * FROM books WHERE title LIKE ? OR author LIKE ?";
            PreparedStatement ps = con.prepareStatement(query);

            ps.setString(1, "%" + keyword + "%");
            ps.setString(2, "%" + keyword + "%");

            ResultSet rs = ps.executeQuery();

            request.setAttribute("resultSet", rs);

            request.getRequestDispatcher("searchResult.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}