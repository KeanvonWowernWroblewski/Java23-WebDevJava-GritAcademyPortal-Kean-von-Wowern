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

@WebServlet(name = "CoursesServlet", urlPatterns = {"/courses"})
public class CoursesServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        List<Course> courses = new ArrayList<>();
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement("SELECT coursesId, name, YHP, description FROM Courses")) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Course course = new Course(
                        rs.getInt("coursesId"),
                        rs.getString("name"),
                        rs.getInt("YHP"),
                        rs.getString("description")
                );
                courses.add(course);
            }

        } catch (SQLException e) {
            throw new ServletException("Database connection error at fetching courses", e);
        }

        request.setAttribute("courses", courses);

        if (session != null && session.getAttribute("userType") != null) {
            String userType = (String) session.getAttribute("userType");
            String privilegeType = (String) session.getAttribute("privilegeType");
            request.setAttribute("userType", userType);
            request.setAttribute("privilegeType", privilegeType);
            if ("teacher".equals(userType) && "admin".equals(privilegeType)) {
                request.setAttribute("showCourseManagementOptions", true);
            }
        }

        request.getRequestDispatcher("/WEB-INF/views/courses.jsp").forward(request, response);
    }

    public static class Course {
        private int id;
        private String name;
        private int yhp;
        private String description;

        public Course(int id, String name, int yhp, String description) {
            this.id = id;
            this.name = name;
            this.yhp = yhp;
            this.description = description;
        }

        public int getId() { return id; }
        public String getName() { return name; }
        public int getYhp() { return yhp; }
        public String getDescription() { return description; }
    }
}