package servlets;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "IndexServlet", urlPatterns = {"/", "/index"})
public class IndexServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session != null && session.getAttribute("userType") != null) {
            String userType = (String) session.getAttribute("userType");
            request.setAttribute("userMessage", "Welcome back, " + userType + "!");
        } else {
            request.setAttribute("userMessage", "Welcome to Grit Academy Portal!");
        }
        request.getRequestDispatcher("/WEB-INF/views/index.jsp").forward(request, response);
    }
}
