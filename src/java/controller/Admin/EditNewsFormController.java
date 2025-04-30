package controller.Admin;

import dao.EditNewsDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.News;
import model.User;
import java.io.IOException;

@WebServlet(name = "EditNewsFormController", urlPatterns = {"/formeditnews"})
public class EditNewsFormController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login?error=Please+login+first");
            return;
        }

        int id = Integer.parseInt(request.getParameter("id"));
        EditNewsDAO dao = new EditNewsDAO();
        News news = dao.getNewsById(id);
        
        request.setAttribute("news", news);
        request.getRequestDispatcher("Admin/EditNews.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login?error=Please+login+first");
            return;
        }

        response.sendRedirect("displayNews");
    }

    @Override
    public String getServletInfo() {
        return "Servlet to display news edit form";
    }
}