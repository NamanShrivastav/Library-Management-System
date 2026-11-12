<%@ page import="java.sql.*" %>
<%@ page import="com.library.dao.DBConnection" %>

<%--<%--%>
<%--    String role = (String) session.getAttribute("role");--%>
<%--    if(role == null || !role.equals("admin")){--%>
<%--        response.sendRedirect("login.jsp");--%>
<%--    }--%>
<%--%>--%>

<%
    if(session.getAttribute("user") == null){
        response.sendRedirect("login.jsp");
        return;
    }
%>

<%
    int id = Integer.parseInt(request.getParameter("id"));
    Connection con = DBConnection.getConnection();
    PreparedStatement ps = con.prepareStatement("SELECT * FROM books WHERE id=?");
    ps.setInt(1, id);
    ResultSet rs = ps.executeQuery();
    rs.next();
%>
<%--<%--%>
<%--    if(session.getAttribute("user") == null){--%>
<%--        response.sendRedirect("login.jsp");--%>
<%--    }--%>
<%--%>--%>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Book</title>
    <link rel="stylesheet"
          href="<%= request.getContextPath() %>/css/editBook.css">
</head>
<body>
<a href="addBook.jsp">Add Book</a> |
<a href="viewBooks.jsp">View Books</a>
<a href="logout">Logout</a>
<hr>

<h2>Edit Book</h2>

<form action="updateBook" method="post">

    <input type="hidden" name="id" value="<%= rs.getInt("id") %>">

    Title: <input type="text" name="title" value="<%= rs.getString("title") %>"><br><br>
    Author: <input type="text" name="author" value="<%= rs.getString("author") %>"><br><br>
    Price: <input type="text" name="price" value="<%= rs.getDouble("price") %>"><br><br>

    <input type="submit" value="Update Book">

</form>

</body>
</html>