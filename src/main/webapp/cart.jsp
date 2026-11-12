<%@ page import="java.sql.*" %>
<%@ page import="com.library.dao.DBConnection" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    if(session.getAttribute("user") == null){
        response.sendRedirect("login.jsp");
        return;
    }

    String username = session.getAttribute("user").toString();

    Connection con = DBConnection.getConnection();

    PreparedStatement ps = con.prepareStatement(
            "SELECT b.id, b.title, b.price, c.quantity " +
                    "FROM cart c " +
                    "JOIN books b ON c.book_id = b.id " +
                    "WHERE c.username=?"
    );

    ps.setString(1, username);

    ResultSet rs = ps.executeQuery();

    double total = 0;
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Cart</title>

    <link rel="stylesheet"
          href="<%=request.getContextPath()%>/css/cart.css">
</head>

<body>

<div class="cart-container">

    <h2 class="cart-title">🛒 Your Cart</h2>

    <table class="cart-table">

        <tr>
            <th>Title</th>
            <th>Price</th>
            <th>Qty</th>
            <th>Total</th>
            <th>Action</th>
        </tr>

        <%
            boolean hasData = false;

            while(rs.next()){

                hasData = true;

                double price = rs.getDouble("price");
                int qty = rs.getInt("quantity");

                double subTotal = price * qty;

                total += subTotal;
        %>

        <tr>

            <td><%= rs.getString("title") %></td>

            <td>₹<%= price %></td>

            <td><%= qty %></td>

            <td>₹<%= subTotal %></td>

            <td>
                <a href="removeFromCart?bookId=<%= rs.getInt("id") %>"
                   class="delete-btn"
                   onclick="return confirm('Remove this book from cart?')">
                    Remove
                </a>
            </td>

        </tr>

        <%
            }
        %>

    </table>

    <%
        if(!hasData){
    %>

    <p class="empty">Your cart is empty.</p>

    <%
    }else{
    %>

    <div class="total-box">
        Total Amount: ₹<%= total %>
    </div>

    <%
        }
    %>

    <br>

    <a href="viewBooks.jsp" class="back-btn">
        ← Back to Books
    </a>

    <a href="index.jsp" class="back-btn">
        🏠 Home
    </a>

</div>

</body>
</html>