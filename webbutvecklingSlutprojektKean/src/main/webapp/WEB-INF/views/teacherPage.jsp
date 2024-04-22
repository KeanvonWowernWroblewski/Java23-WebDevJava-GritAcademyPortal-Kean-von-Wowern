<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="servlets.UserPageServlet.Course" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
  <title>Courses and Students</title>
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
    h2 {
      color: black;
    }
    ul {
      list-style-type: none;
      padding: 0;
    }
    ul li {
      padding: 5px 0;
    }
    p {
      margin: 5px 0;
    }

    table {
      width: 100%;
      border-collapse: collapse;
    }
    th, td {
      border: 1px solid lightgray;
      padding: 8px;
    }
    th {
      background-color: whitesmoke;
    }
    form {
      margin-bottom: 20px;
    }
    label {
      margin-right: 10px;
    }
    select, input[type="text"], input[type="submit"] {
      padding: 5px;
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
    <li><a href="logout">Logout</a></li>
    <li><a href="userPage">User Page</a></li>
    <li><a href="register">Register students and teachers</a></li>
  </ul>
</nav>
<h1>Courses and their students</h1>

<c:if test="${not empty searchResults}">
  <h2>Search Results</h2>
  <table>
    <thead>
    <tr>
      <th>Course ID</th>
      <th>Course Name</th>
      <th>Teacher(s)</th>
      <th>Enrolled Students</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${searchResults}" var="course">
      <tr>
        <td>${course.id}</td>
        <td>${course.name}</td>
        <td>${course.teacherName}</td>
        <td>
          <c:if test="${not empty course.studentNames}">
            ${course.studentNames}
          </c:if>
          <c:if test="${empty course.studentNames}">
            No students enrolled.
          </c:if>
        </td>
      </tr>
    </c:forEach>
    </tbody>
  </table>
</c:if>

<c:if test="${empty searchResults}">
  <c:if test="${not empty allCourses}">
    <table>
      <thead>
      <tr>
        <th>Course ID</th>
        <th>Course Name</th>
        <th>Teacher(s)</th>
        <th>Enrolled Students</th>
      </tr>
      </thead>
      <tbody>
      <c:forEach items="${allCourses}" var="course">
        <tr>
          <td>${course.id}</td>
          <td>${course.name}</td>
          <td>${course.teacherName}</td>
          <td>
            <c:if test="${not empty course.studentNames}">
              ${course.studentNames}
            </c:if>
            <c:if test="${empty course.studentNames}">
              No students enrolled.
            </c:if>
          </td>
        </tr>
      </c:forEach>
      </tbody>
    </table>
  </c:if>

  <c:if test="${empty allCourses}">
    <p>You are not teaching any courses currently.</p>
  </c:if>

  <h2>Search for Students or Courses</h2>
  <form action="userPage" method="post">
    <label for="searchType">Search Type:</label>
    <select id="searchType" name="searchType">
      <option value="student">Student</option>
      <option value="course">Course</option>
    </select>
    <br>
    <label for="searchTerm">Search Term:</label>
    <input type="text" id="searchTerm" name="searchTerm">
    <br>
    <input type="submit" value="Search">
  </form>
</c:if>

<footer>
  <p>Grit Academy Portal &copy; 2024</p>
</footer>
</body>
</html>

