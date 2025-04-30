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

@WebServlet(name = "editNewController", urlPatterns = {"/editNews"})
public class editNewController extends HttpServlet {

    private EditNewsDAO newsDAO;

    @Override
    public void init() {
        newsDAO = new EditNewsDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login?error=Please+login+first");
            return;
        }

        int id = Integer.parseInt(request.getParameter("id"));
        News news = newsDAO.getNewsById(id);
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

        int id = Integer.parseInt(request.getParameter("id"));
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String img = request.getParameter("img");
        String createAt = request.getParameter("creatAt");

        StringBuilder error = new StringBuilder();
        if (title == null || title.trim().isEmpty()) {
            error.append("Title is required.<br>");
        } else if (title.length() > 100) {
            error.append("Title cannot exceed 100 characters.<br>");
        }

        if (description == null || description.trim().isEmpty()) {
            error.append("Description is required.<br>");
        } else if (description.length() > 500) {
            error.append("Description cannot exceed 500 characters.<br>");
        }

        if (img == null || img.trim().isEmpty()) {
            error.append("Image is required.<br>");
        }

        if (createAt == null || createAt.trim().isEmpty()) {
            error.append("Creation date is required.<br>");
        }

        if (error.length() > 0) {
            request.setAttribute("errorMessage", error.toString());
            request.getRequestDispatcher("Admin/EditNews.jsp").forward(request, response);
            return;
        }

        News news = new News();
        news.setNewId(id);
        news.setNewTitle(title);
        news.setDescription(description);
        news.setImg(img);
        news.setCreateAt(createAt);

        int result = newsDAO.updateNews(news);

        if (result > 0) {
            response.sendRedirect("displayNews");
        } else {
            request.setAttribute("errorMessage", "Error updating news");
            request.getRequestDispatcher("Admin/EditNews.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet to edit news";
    }
}