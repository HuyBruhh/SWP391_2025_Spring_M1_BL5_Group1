package controller.Admin;

import dao.NewDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.News;
import model.User;
import java.io.IOException;

@WebServlet(name = "newDetailController", urlPatterns = {"/newsDetail"})
public class newDetailController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login?error=Please+login+first");
            return;
        }

        NewDAO dao = new NewDAO();
        String newId_raw = request.getParameter("id");
        int newId = Integer.parseInt(newId_raw);
        News newsDetail = dao.getNewsById(newId);
        request.setAttribute("news", newsDetail);
        request.getRequestDispatcher("Admin/NewsList.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet to display news details";
    }
}