<%@ page import="java.sql.*" %>
<%@ page import="com.library.dao.DBConnection" %>
<%@ page contentType="text/html; charset = UTF-8" pageEncoding="UTF-8"%>

<%
    if(session.getAttribute("user") == null){
        response.sendRedirect("login.jsp");
    }

    int id = Integer.parseInt(request.getParameter("id"));
%>

<html>
<head>
    <meta charset="UTF-8">
    <title>Book Details</title>
    <link rel="stylesheet" href="css/bookdetails.css">
</head>

<body>

<div class="container">

    <%
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT * FROM books WHERE id=?");
            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            if(rs.next()){
    %>

    <div class="card">

        <h2><%= rs.getString("title") %></h2>

        <p><strong>Author:</strong> <%= rs.getString("author") %></p>
        <p><strong>Price:</strong> &#8377;<%= rs.getDouble("price") %></p>

        <p class="desc">
            This is a great book available in our library. You can explore more
            content and enjoy reading.
        </p>

        <div class="actions">
            <a href="viewBooks.jsp" class="btn back">⬅ Back</a>
            <a href="editBook.jsp?id=<%= id %>" class="btn edit">Edit</a>
        </div>

    </div>

    <%
            } else {
                System.out.println("<p>Book not found</p>");
            }

        } catch(Exception e) {
                System.out.println("Error: " + e.getMessage());
        }
    %>

</div>

</body>
</html>