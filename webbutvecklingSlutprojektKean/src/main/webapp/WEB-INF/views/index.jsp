<%@ page contentType="text/html;charset=UTF-8" pageEncoding="utf-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Grit Academy Portal</title>
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
        main {
            padding: 0 20px;
        }
        h1 {
            text-align: center;
        }
        h2 {
            text-align: center;
        }
        p {margin-left: 20%;
            margin-right: 20%;}

        .image {
            display: block;
            margin-left: auto;
            margin-right: auto;
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
    <h1><%= request.getAttribute("userMessage") %></h1>
</header>
<main>
    <section>
        <h2>About Grit Academy</h2>
        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
    </section>
    <img src="https://i.imgur.com/7f0yIhS.jpeg" alt="Grit Academy hallway" class="image" width="500" height="600">

</main>
<footer>
    <p>Grit Academy Portal &copy; 2024</p>
</footer>
</body>
</html>