package servlets;

import util.DatabaseConnection;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "RegistrationServlet", urlPatterns = {"/register"})
public class RegistrationServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String userType = (String) session.getAttribute("userType");
        String privilegeType = (String) session.getAttribute("privilegeType");

        if (!("teacher".equals(userType) && "admin".equals(privilegeType))) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Unauthorized access.");
            return;
        }

        try (Connection conn = DatabaseConnection.getConnection()) {
            request.setAttribute("teachers", fetchTeachers(conn));
            request.setAttribute("students", fetchStudents(conn));
            request.setAttribute("courses", fetchCourses(conn));

            request.getRequestDispatcher("/WEB-INF/views/registration.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Database connection error while fetching data for registration", e);
        }
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String privilegeType = (String) session.getAttribute("privilegeType");

        if (!"admin".equals(privilegeType)) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Unauthorized access.");
            return;
        }

        String actionType = request.getParameter("actionType");
        String courseIdStr = request.getParameter("courseId");
        int courseId = -1;
        int id = -1;

        try {
            courseId = courseIdStr != null ? Integer.parseInt(courseIdStr) : -1;
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid course ID.");
            request.getRequestDispatcher("/WEB-INF/views/registration.jsp").forward(request, response);
            return;
        }

        try {
            if ("assignTeacher".equals(actionType)) {
                String teachersIdStr = request.getParameter("teachersId");
                id = teachersIdStr != null ? Integer.parseInt(teachersIdStr) : -1;
            } else if ("assignStudent".equals(actionType)) {
                String studentIdStr = request.getParameter("studentId");
                id = studentIdStr != null ? Integer.parseInt(studentIdStr) : -1;
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid teacher or student ID.");
            request.getRequestDispatcher("/WEB-INF/views/registration.jsp").forward(request, response);
            return;
        }

        if (courseId == -1 || id == -1) {
            request.setAttribute("error", "Missing or incorrect form data.");
            request.getRequestDispatcher("/WEB-INF/views/registration.jsp").forward(request, response);
            return;
        }

        try (Connection conn = DatabaseConnection.getConnection()) {
            if ("assignTeacher".equals(actionType)) {
                assignTeacherToCourse(conn, id, courseId);
            } else if ("assignStudent".equals(actionType)) {
                assignStudentToCourse(conn, id, courseId);
            }
            response.sendRedirect("register");
        } catch (SQLException e) {
            throw new ServletException("Database connection error during assignment", e);
        }
    }



    private List<String> fetchTeachers(Connection conn) throws SQLException {
        List<String> teachers = new ArrayList<>();
        try (PreparedStatement ps = conn.prepareStatement("SELECT teachersId, firstName, lastName FROM teachers")) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                teachers.add(rs.getInt("teachersId") + " - " + rs.getString("firstName") + " " + rs.getString("lastName"));
            }
        }
        return teachers;
    }

    private List<String> fetchStudents(Connection conn) throws SQLException {
        List<String> students = new ArrayList<>();
        try (PreparedStatement ps = conn.prepareStatement("SELECT studentId, firstName, lastName FROM students")) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                students.add(rs.getInt("studentId") + " - " + rs.getString("firstName") + " " + rs.getString("lastName"));
            }
        }
        return students;
    }

    private List<String> fetchCourses(Connection conn) throws SQLException {
        List<String> courses = new ArrayList<>();
        try (PreparedStatement ps = conn.prepareStatement("SELECT coursesId, name FROM courses")) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                courses.add(rs.getInt("coursesId") + " - " + rs.getString("name"));
            }
        }
        return courses;
    }

    private void assignTeacherToCourse(Connection conn, int teachersId, int coursesId) throws SQLException {
        try (PreparedStatement ps = conn.prepareStatement("INSERT INTO teacherscourses (teachersId, coursesId) VALUES (?, ?)")) {
            ps.setInt(1, teachersId);
            ps.setInt(2, coursesId);
            ps.executeUpdate();
        }
    }

    private void assignStudentToCourse(Connection conn, int studentId, int coursesId) throws SQLException {
        try (PreparedStatement ps = conn.prepareStatement("INSERT INTO studentscourses (studentsId, coursesId) VALUES (?, ?)")) {
            ps.setInt(1, studentId);
            ps.setInt(2, coursesId);
            ps.executeUpdate();
        }
    }
}
