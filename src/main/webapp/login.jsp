<%
    response.setHeader("Cache-Control","no-cache,no-store,must-revalidate");
    response.setHeader("Pragma","no-cache");
    response.setHeader("Expires", String.valueOf(0));
%>

<html>
<head>
    <title>Login</title>
    <link rel="stylesheet" href="css/style.css">

    <script>
        function validateLogin() {
            let username = document.forms["loginForm"]["username"].value.trim();
            let password = document.forms["loginForm"]["password"].value.trim();

            if (username === "" || password === "") {
                alert("All fields are required");
                return false;
            }
            return true;
        }
    </script>
</head>

<body>

<div class="form-container">
    <h2>Login</h2>

    <%
        String error = request.getParameter("error");
        if(error != null){
    %>
    <p style="color:red;"><%= error %></p>
    <%
        }
    %>

    <form name="loginForm"  action="<%=request.getContextPath()%>/login" method="post" onsubmit="return validateLogin()">

        <div class="form-group">
            <label>Username</label>
            <input type="text" name="username" placeholder="Username" autocomplete="off" required>
        </div>

        <div class="form-group">
            <label>Password</label>
            <input type="password" name="password" autocomplete="new-password" required >
        </div>

        <button class="form-btn" type="submit">Login</button>

    </form>
</div>
</body>
</html>