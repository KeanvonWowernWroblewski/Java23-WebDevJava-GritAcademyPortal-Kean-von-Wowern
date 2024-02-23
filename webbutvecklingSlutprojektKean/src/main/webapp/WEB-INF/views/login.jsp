<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: whitesmoke;
            margin: 0;
            padding: 16px;
            color: black;
        }
        nav ul {
            list-style-type: none;
            padding: 5;
            background-color: darkgoldenrod;
            overflow: hidden;
            margin: 0;
        }
        nav ul li {
            float: left;
        }
        nav ul li a {
            display: block;
            color: white;
            text-align: center;
            padding: 15px 17px;
            text-decoration: none;
        }
        nav ul li a:hover {
            background-color: whitesmoke;
            color: black;
        }
        header {
            background-color: black;
            color: white;
            padding: 20px;
            text-align: center;
        }
        form {
            max-width: 300px;
            margin: 20px auto;
            padding: 20px;
            background-color: white;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        label, input {
            display: block;
            width: 100%;
            margin-bottom: 10px;
        }
        input[type="text"], input[type="password"] {
            padding: 8px;
            border: 2px solid lightgray;
            border-radius: 4px;
        }
        input[type="submit"] {
            background-color: blue;
            color: white;
            border: none;
            padding: 10px;
            cursor: pointer;
            border-radius: 4px;
        }
        input[type="submit"]:hover {
            background-color: darkblue;
        }
        .error {
            color: red;
            text-align: center;
        }
        footer {
            background-color: darkgoldenrod;
            color: white;
            text-align: center;
            padding: 10px;
            position: fixed;
            bottom: 0;
            width: 100%;
        }
    </style>
</head>
<body>
<nav>
    <ul>
        <li><a href="index">Home</a></li>
        <li><a href="courses">Courses</a></li>
        <% if (session.getAttribute("userType") == null) { %>
        <li><a href="login">Login</a></li>
        <% } else { %>
        <li><a href="userPage">User Page</a></li>
        <li><a href="logout">Logout</a></li>
        <% } %>
    </ul>
</nav>
<header>
    <h1>Login</h1>
</header>
<form action="login" method="post">
    <label for="username">Username:</label>
    <input type="text" id="username" name="username" required><br>
    <label for="password">Password:</label>
    <input type="password" id="password" name="password" required><br>
    <input type="submit" value="Login">
</form>
<% if (request.getAttribute("errorMessage") != null) { %>
<p class="error"><%= request.getAttribute("errorMessage") %></p>
<% } %>
<footer>
    <p>Grit Academy Portal &copy; 2024</p>
</footer>
</body>
</html>
