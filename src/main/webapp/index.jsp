<%@ page import="java.sql.*" %>
<%@ page import="com.library.dao.DBConnection" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    String user = (String) session.getAttribute("user");
    String role = (String) session.getAttribute("role");
%>

<html>
<head>
    <title>Library System</title>
    <link rel="stylesheet" href="css/style.css">
</head>

<body>

<div class="header">
    <h2>📚 Expert Learning Library</h2>
</div>

<div class="nav">

    <% if(user == null){ %>
    <a href="login.jsp">Login</a>
    <% } else { %>

    <span>Welcome, <b><%= user %></b> (<%= role %>)</span> |

    <% if(role != null && role.equals("admin")){ %>
    <a href="addBook.jsp">Add Book</a> |
    <a href="viewBooks.jsp">Manage Books</a> |
    <% } else { %>
    <a href="viewBooks.jsp">View Books</a> |
    <% } %>
    <% if(role != null && role.equals("user")){ %>
    <a href="cart.jsp">Cart</a> |
    <% } %>
    <a href="logout">Logout</a>

    <% } %>

</div>

<div class="container">

    <div class="summary">
        <p>Welcome to Expert Learning Library. Explore your adventure here.</p>
    </div>

    <div class="search-box">
        <form action="searchBook" method="get">
            <input type="text" name="keyword" placeholder="Search books...">
            <button type="submit">Search</button>
        </form>
    </div>

    <div class="books">

        <%
            Connection con = DBConnection.getConnection();

            Statement st1 = con.createStatement();
            ResultSet rs1 = st1.executeQuery("SELECT COUNT(*) FROM books");
            rs1.next();
            int count = rs1.getInt(1);

            int limit = (count > 10) ? 5 : 3;

            PreparedStatement ps = con.prepareStatement("SELECT * FROM books LIMIT ?");
            ps.setInt(1, limit);

            ResultSet rs = ps.executeQuery();

            while(rs.next()){
        %>

        <div class="book-card">

            <div class="book-title">
                <%= rs.getString("title") %>
            </div>

            <div class="book-info">
                <p>Author: <%= rs.getString("author") %></p>
                <p>Price: &#8377;<%= rs.getInt("price") %></p>
            </div>

        </div>

        <%
            }
        %>

    </div>

</div>

<!-- FOOTER -->
<div class="footer">

    <div class="footer-container">

        <div>
            <h3>📚 My Library</h3>
            <p>A simple library management system to manage and explore books.</p>
        </div>

        <div>
            <h3>Quick Links</h3>
            <p><a href="index.jsp">Home</a></p>
            <p><a href="login.jsp">Admin Login</a></p>
        </div>

        <div>
            <h3>Contact</h3>
            <p>Email: library@email.com</p>
            <p>Phone: +91 XXXXX XXXXX</p>
        </div>

    </div>

    <div class="footer-bottom">
        © 2026 My Library | All Rights Reserved
    </div>

</div>

</body>
</html>