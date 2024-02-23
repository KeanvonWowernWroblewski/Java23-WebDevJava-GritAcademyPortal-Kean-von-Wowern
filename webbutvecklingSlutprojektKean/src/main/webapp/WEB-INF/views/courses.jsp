<%@ page import="servlets.CoursesServlet" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: sours
  Date: 2024-02-18
  Time: 15:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Available Courses</title>
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
        .course {
            background-color: white;
            border: 2px solid whitesmoke;
            padding: 15px;
            margin: 15px;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .course h2 {
            color: black;
        }
        .course p {
            font-size: 14px;
            color: grey;
        }
        footer {
            background-color: darkgoldenrod;
            color: white;
            text-align: center;
            padding: 10px;
            position: relative;
            bottom: 0;
            width: 100%;
            padding-top: 5px;
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
<h1>Available Courses</h1>
<%
    List<CoursesServlet.Course> courses = (List<CoursesServlet.Course>) request.getAttribute("courses");
    if (courses != null && !courses.isEmpty()) {
        for (CoursesServlet.Course course : courses) {
%>
<div class="course">
    <h2><%= course.getName() %></h2>
    <p><%= course.getDescription() %></p>
</div>
<%
    }
} else {
%>
<p>No courses available.</p>
<%
    }
%>

<footer>
    <p>Grit Academy Portal &copy; 2024</p>
</footer>
</body>
</html>
