<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset = UTF-8" pageEncoding="UTF-8"%>

<html>
<head>
    <meta charset="UTF-8">
    <title>Search Results</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/searchresult.css">
</head>

<body>

<div class="container">


        <a href="addBook.jsp">Add Book</a> |
        <a href="viewBooks.jsp">View Books</a>


    <hr>

    <h2 class="title">Search Results</h2>

    <table class="book-table">
        <tr>
            <th>ID</th>
            <th>Title</th>
            <th>Author</th>
            <th>Price</th>
        </tr>

        <%
            ResultSet rs = (ResultSet) request.getAttribute("resultSet");
            boolean found = false;

            while(rs != null && rs.next()) {
                found = true;
        %>

        <tr>
            <td><%= rs.getInt("id") %></td>
            <td class="book-title"><%= rs.getString("title") %></td>
            <td><%= rs.getString("author") %></td>
            <td>&#8377;<%= rs.getDouble("price") %></td>
        </tr>

        <%
            }
        %>

    </table>

    <%
        if(!found){
    %>
    <div class="no-result">No books found</div>
    <%
        }
    %>

    <br>
    <div class="back-link">
        <a href="viewBooks.jsp">← Back</a>
    </div>

</div>

</body>
</html>