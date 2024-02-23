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

@WebServlet(name = "UserPageServlet", urlPatterns = {"/userPage"})
public class UserPageServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userType") == null) {
            request.setAttribute("errorMessage", "You must be logged in to view this page.");
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
            return;
        }

        String userType = (String) session.getAttribute("userType");
        Integer userId = (Integer) session.getAttribute("userId");

        try (Connection conn = DatabaseConnection.getConnection()) {
            if ("student".equals(userType)) {
                handleStudentView(conn, userId, request, response);
            } else if ("teacher".equals(userType)) {
                handleTeacherView(conn, request, response);
            } else {
                handleSessionError(request, response, "Invalid user type. Access denied.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            handleSessionError(request, response, "Database connection error while fetching data for the user page.");
        }
    }

    private void handleStudentView(Connection conn, int studentId, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        List<Course> studentCourses = fetchStudentCourses(conn, studentId);
        request.setAttribute("courses", studentCourses);
        request.getRequestDispatcher("/WEB-INF/views/studentPage.jsp").forward(request, response);
    }

    private void handleTeacherView(Connection conn, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        List<Course> allCourses = fetchAllCoursesWithDetails(conn);
        request.setAttribute("allCourses", allCourses);
        request.getRequestDispatcher("/WEB-INF/views/teacherPage.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userType") == null) {
            request.setAttribute("errorMessage", "You must be logged in to view this page.");
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
            return;
        }

        String userType = (String) session.getAttribute("userType");

        if ("teacher".equals(userType)) {
            String searchType = request.getParameter("searchType");
            String searchTerm = request.getParameter("searchTerm");

            if (searchType != null && searchTerm != null && !searchTerm.isEmpty()) {
                try (Connection conn = DatabaseConnection.getConnection()) {
                    List<Course> searchResults = searchCourses(conn, searchType, searchTerm);
                    request.setAttribute("searchResults", searchResults);
                    request.getRequestDispatcher("/WEB-INF/views/teacherPage.jsp").forward(request, response);
                } catch (SQLException e) {
                    e.printStackTrace();
                    handleSessionError(request, response, "Database connection error while fetching search results.");
                }
            } else {
                response.sendRedirect("userPage");
            }
        } else {
            response.sendRedirect("userPage");
        }
    }

    private List<Course> fetchStudentCourses(Connection conn, int studentId) throws SQLException {
        List<Course> courses = new ArrayList<>();
        String sql = "SELECT c.coursesId, c.name, " +
                "GROUP_CONCAT(DISTINCT t.firstName, ' ', t.lastName ORDER BY t.firstName) AS teacherNames, " +
                "GROUP_CONCAT(DISTINCT s.firstName, ' ', s.lastName ORDER BY s.firstName SEPARATOR ', ') AS students " +
                "FROM courses c " +
                "LEFT JOIN teacherscourses tc ON c.coursesId = tc.coursesId " +
                "LEFT JOIN teachers t ON tc.teachersId = t.teachersId " +
                "JOIN studentscourses sc ON c.coursesId = sc.coursesId " +
                "LEFT JOIN students s ON sc.studentsId = s.studentId " +
                "WHERE sc.studentsId = ? " +
                "GROUP BY c.coursesId, c.name";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, studentId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String teacherNames = rs.getString("teacherNames") != null ? rs.getString("teacherNames") : "No teacher assigned";
                String studentNames = rs.getString("students") != null ? rs.getString("students") : "No students enrolled";
                courses.add(new Course(rs.getInt("coursesId"), rs.getString("name"), teacherNames, studentNames));
            }
        }
        return courses;
    }

    private List<Course> fetchAllCoursesWithDetails(Connection conn) throws SQLException {
        List<Course> courses = new ArrayList<>();
        String sql = "SELECT c.coursesId, c.name, GROUP_CONCAT(DISTINCT t.firstName, ' ', t.lastName) AS teacherNames, " +
                "GROUP_CONCAT(DISTINCT s.firstName, ' ', s.lastName SEPARATOR ', ') AS students " +
                "FROM courses c " +
                "LEFT JOIN teacherscourses tc ON c.coursesId = tc.coursesId " +
                "LEFT JOIN teachers t ON tc.teachersId = t.teachersId " +
                "LEFT JOIN studentscourses sc ON c.coursesId = sc.coursesId " +
                "LEFT JOIN students s ON sc.studentsId = s.studentId " +
                "GROUP BY c.coursesId";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String teacherNames = rs.getString("teacherNames") != null ? rs.getString("teacherNames") : "No teacher assigned";
                String studentNames = rs.getString("students") != null ? rs.getString("students") : "No students enrolled";
                courses.add(new Course(rs.getInt("coursesId"), rs.getString("name"), teacherNames, studentNames));
            }
        }
        return courses;
    }

    private List<Course> searchCourses(Connection conn, String searchType, String searchTerm) throws SQLException {
        List<Course> searchResults = new ArrayList<>();
        String sql = "";

        if ("student".equals(searchType)) {
            sql = "SELECT DISTINCT c.coursesId, c.name, " +
                    "GROUP_CONCAT(DISTINCT t.firstName, ' ', t.lastName ORDER BY t.firstName) AS teacherNames, " +
                    "GROUP_CONCAT(DISTINCT s.firstName, ' ', s.lastName ORDER BY s.firstName SEPARATOR ', ') AS students " +
                    "FROM courses c " +
                    "LEFT JOIN teacherscourses tc ON c.coursesId = tc.coursesId " +
                    "LEFT JOIN teachers t ON tc.teachersId = t.teachersId " +
                    "JOIN studentscourses sc ON c.coursesId = sc.coursesId " +
                    "LEFT JOIN students s ON sc.studentsId = s.studentId " +
                    "WHERE CONCAT(s.firstName, ' ', s.lastName) LIKE ? " +
                    "GROUP BY c.coursesId, c.name";
        } else if ("course".equals(searchType)) {
            sql = "SELECT DISTINCT c.coursesId, c.name, " +
                    "GROUP_CONCAT(DISTINCT t.firstName, ' ', t.lastName ORDER BY t.firstName) AS teacherNames, " +
                    "GROUP_CONCAT(DISTINCT s.firstName, ' ', s.lastName ORDER BY s.firstName SEPARATOR ', ') AS students " +
                    "FROM courses c " +
                    "LEFT JOIN teacherscourses tc ON c.coursesId = tc.coursesId " +
                    "LEFT JOIN teachers t ON tc.teachersId = t.teachersId " +
                    "JOIN studentscourses sc ON c.coursesId = sc.coursesId " +
                    "LEFT JOIN students s ON sc.studentsId = s.studentId " +
                    "WHERE c.name LIKE ? " +
                    "GROUP BY c.coursesId, c.name";
        }

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + searchTerm + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String teacherNames = rs.getString("teacherNames") != null ? rs.getString("teacherNames") : "No teacher assigned";
                String studentNames = rs.getString("students") != null ? rs.getString("students") : "No students enrolled";
                searchResults.add(new Course(rs.getInt("coursesId"), rs.getString("name"), teacherNames, studentNames));
            }
        }
        return searchResults;
    }

    private void handleSessionError(HttpServletRequest request, HttpServletResponse response, String errorMessage) throws ServletException, IOException {
        request.setAttribute("errorMessage", errorMessage);
        request.getRequestDispatcher("/WEB-INF/views/errorPage.jsp").forward(request, response);
    }

    public static class Course {
        private int id;
        private String name;
        private String teacherName;
        private String studentNames;

        public Course(int id, String name, String teacherName, String studentNames) {
            this.id = id;
            this.name = name;
            this.teacherName = teacherName;
            this.studentNames = studentNames;
        }

        public int getId() { return id; }
        public String getName() { return name; }
        public String getTeacherName() { return teacherName; }
        public String getStudentNames() { return studentNames; }
    }
}
