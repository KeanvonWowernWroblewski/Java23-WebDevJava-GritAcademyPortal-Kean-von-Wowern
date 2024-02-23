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

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        String sql = "SELECT 'student' AS userType, studentId AS userId, NULL as privilegeType FROM Students WHERE username = ? AND password = ? " +
                "UNION " +
                "SELECT 'teacher' AS userType, teachersId AS userId, privilegeType FROM Teachers WHERE username = ? AND password = ?";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, password);
            ps.setString(3, username);
            ps.setString(4, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String userType = rs.getString("userType");
                int userId = rs.getInt("userId");
                String privilegeType = rs.getString("privilegeType");

                HttpSession session = request.getSession();
                session.setAttribute("userType", userType);
                session.setAttribute("userId", userId);

                if ("teacher".equals(userType)) {
                    session.setAttribute("privilegeType", privilegeType);
                }

                response.sendRedirect("userPage");
            } else {
                request.setAttribute("errorMessage", "Invalid username or password");
                request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            throw new ServletException("Database connection error during login", e);
        }
    }





}