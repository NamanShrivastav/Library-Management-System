<%@ page session="true" %>
<%
    if(session.getAttribute("user") == null){
        response.sendRedirect("login.jsp");
    }
%>

<%--<%--%>
<%--    String role = (String) session.getAttribute("role");--%>
<%--    if(role == null || !role.equals("admin")){--%>
<%--        response.sendRedirect("login.jsp");--%>
<%--    }--%>
<%--%>--%>

<html>
<head>
    <meta charset="UTF-8">
    <title>Add Book</title>
    <link rel="stylesheet" href="css/style.css">

    <script>
        function validateBook() {
            let title = document.forms["bookForm"]["title"].value.trim();
            let author = document.forms["bookForm"]["author"].value.trim();
            let price = document.forms["bookForm"]["price"].value.trim();

            if(title === "" || author === "null" || price === ""){
                alert("All fields are required");
                return false;
            }
            if(isNaN(price) || price<=0){
                alert("Enter valid price...");
            }
            return true;
        }
    </script>
</head>

<body>

<div class="nav">
    <a href="index.jsp" class="nav-btn">Home</a>
    <a href="addBook.jsp">Add Book</a>
    <a href="viewBooks.jsp">View Books</a>
    <a href="javascript:void(0);" class="nav-btn logout" onclick="return confirmLogout();">Logout</a>
</div>

<div class="form-container">
    <h2>Add New Book</h2>

    <form name="bookForm"  action="addBook" method="post" onsubmit="return validateBook()">

        <div class="form-group">
            <label>Title</label>
            <input type="text" name="title">
        </div>

        <div class="form-group">
            <label>Author</label>
            <input type="text" name="author">
        </div>

        <div class="form-group">
            <label>Price</label>
            <input type="text" name="price">
        </div>

        <button class="form-btn" type="submit">Add Book</button>

    </form>
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