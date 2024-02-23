<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Registration</title>
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
        form {
            background-color: white;
            padding: 20px;
            margin-top: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        label, select, input[type="submit"] {
            display: block;
            margin-top: 10px;
            width: 100%;
        }
        select, input[type="submit"] {
            padding: 10px;
            margin-bottom: 20px;
        }
        input[type="submit"] {
            background-color: blue;
            color: white;
            cursor: pointer;
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
        <li><a href="login">Login</a></li>
        <li><a href="logout">Logout</a></li>
        <li><a href="userPage">User Page</a></li>
        <li><a href="registration.jsp">Register students and teachers</a></li>
    </ul>
</nav>
<h1>Assign Teachers and Students to Courses</h1>

<form action="register" method="post">
    <h2>Assign Teacher to Course</h2>
    <input type="hidden" name="actionType" value="assignTeacher">
    <label for="teachersId">Teacher:</label>
    <select id="teachersId" name="teachersId">
        <% List<String> teachers = (List<String>) request.getAttribute("teachers");
            for(String teacher : teachers) {
                out.println("<option value=\"" + teacher.split(" - ")[0] + "\">" + teacher + "</option>");
            }
        %>
    </select>

    <label for="teacherCourseId">Course:</label>
    <select id="teacherCourseId" name="courseId">
        <% List<String> courses = (List<String>) request.getAttribute("courses");
            for(String course : courses) {
                out.println("<option value=\"" + course.split(" - ")[0] + "\">" + course + "</option>");
            }
        %>
    </select>

    <input type="submit" value="Assign Teacher">
</form>

<form action="register" method="post">
    <h2>Assign Student to Course</h2>
    <input type="hidden" name="actionType" value="assignStudent">
    <label for="studentId">Student:</label>
    <select id="studentId" name="studentId">
        <% List<String> students = (List<String>) request.getAttribute("students");
            for(String student : students) {
                out.println("<option value=\"" + student.split(" - ")[0] + "\">" + student + "</option>");
            }
        %>
    </select>

    <label for="studentCourseId">Course:</label>
    <select id="studentCourseId" name="courseId">
        <%
            for(String course : courses) {
                out.println("<option value=\"" + course.split(" - ")[0] + "\">" + course + "</option>");
            }
        %>
    </select>

    <input type="submit" value="Assign Student">
</form>
<footer>
    <p>Grit Academy Portal &copy; 2024</p>
</footer>
</body>
</html>