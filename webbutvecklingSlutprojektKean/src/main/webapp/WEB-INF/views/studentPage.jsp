<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="servlets.UserPageServlet.Course" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
  <title>Your Enrolled Courses</title>
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
    table {
      width: 100%;
      margin-top: 20px;
      border-collapse: collapse;
    }
    th, td {
      padding: 10px;
      text-align: left;
      border-bottom: 1px solid grey;
    }
    th {
      background-color: black;
      color: white;
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
    <li><a href="login">Login</a></li>
    <li><a href="logout">Logout</a></li>
    <li><a href="userPage">User Page</a></li>
  </ul>
</nav>
<h1>Enrolled Courses</h1>

<c:if test="${not empty courses}">
  <table>
    <thead>
    <tr>
      <th>Course ID</th>
      <th>Course Name</th>
      <th>Teacher</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${courses}" var="course">
      <tr>
        <td>${course.id}</td>
        <td>${course.name}</td>
        <td>${course.teacherName}</td>
      </tr>
    </c:forEach>

    </tbody>
  </table>
</c:if>

<c:if test="${empty courses}">
  <p>You are currently not enrolled in any courses.</p>
</c:if>
<footer>
  <p>Grit Academy Portal &copy; 2024</p>
</footer>
</body>
</html>