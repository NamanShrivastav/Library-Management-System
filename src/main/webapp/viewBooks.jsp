<%@ page import="java.sql.*" %>
<%@ page import="com.library.dao.DBConnection" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    if(session.getAttribute("user") == null){
        response.sendRedirect("login.jsp");
        return;
    }

    String role = (String) session.getAttribute("role");
%>

<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="css/viewbooks.css">
    <title>View Books</title>
</head>

<body>

<div class="container">

    <!-- Top Navigation -->
<%--    <div class="top-bar">--%>
<%--        <a href="addBook.jsp" class="nav-btn">Add Book</a>--%>
<%--        <a href="viewBooks.jsp" class="nav-btn active">View Books</a>--%>
<%--        <a href="cart.jsp" class="nav-btn">Cart</a>--%>
<%--        <a href="logout" class="nav-btn logout">Logout</a>--%>
<%--    </div>--%>

    <div class="top-bar">

        <a href="index.jsp" class="nav-btn">Home</a>

        <% if ("admin".equals(session.getAttribute("role"))) { %>
        <a href="addBook.jsp" class="nav-btn">Add Book</a>
        <% } %>

        <a href="viewBooks.jsp" class="nav-btn active">View Books</a>

        <% if ("user".equals(session.getAttribute("role"))) { %>
        <a href="cart.jsp" class="nav-btn">My Cart</a>
        <% } %>

        <a href="javascript:void(0);" class="nav-btn logout" onclick="return confirmLogout();">Logout</a>

    </div>

    <h2>📚 All Books</h2>

    <!-- Search -->
    <form action="searchBook" method="get" class="search-box">
        <input type="text" name="keyword" placeholder="Search by title or author">
        <input type="submit" value="Search">
    </form>

    <br>

    <!-- Table -->
    <table class="book-table">
        <tr>
            <th>ID</th>
            <th>Title</th>
            <th>Author</th>
            <th>Price</th>
            <th>Action</th>
        </tr>

        <%
            try {
                Connection con = DBConnection.getConnection();
                Statement stmt = con.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT * FROM books");

                while(rs.next()) {
        %>

        <tr>
            <td><%= rs.getInt("id") %></td>

            <td>
                <a href="bookDetails.jsp?id=<%= rs.getInt("id") %>" class="book-link">
                    <%= rs.getString("title") %>
                </a>
            </td>

            <td><%= rs.getString("author") %></td>
            <td>₹<%= rs.getDouble("price") %></td>

            <td>
                <!-- ADMIN CONTROLS -->
                <%
                    if("admin".equals(role)){
                %>
                <a href="editBook.jsp?id=<%= rs.getInt("id") %>" class="btn update">Edit</a>

                <a href="deleteBook?id=<%= rs.getInt("id")%>" class="btn delete"
                   onclick="return confirm('Delete this book?');">
                    Delete
                </a>
                <%
                    }
                %>

                <!-- USER CONTROLS -->
                <%
                    if("user".equals(role)){
                %>
                <a href="addToCart?id=<%= rs.getInt("id")%>" class="add-cart-btn">
                    Add To Cart
                </a>
                <%
                    }
                %>
            </td>

        </tr>

        <%
            }
        } catch(Exception e) {
        %>
        <tr>
            <td colspan="5" style="color:red;">
                Error: <%= e.getMessage() %>
            </td>
        </tr>
        <%
            }
        %>

    </table>

</div>

<script>
    function confirmLogout() {
        if (confirm("Do you want to logout?")) {
            window.location.href = "logout";
        }
        return false;
    }
</script>
</body>
</html>