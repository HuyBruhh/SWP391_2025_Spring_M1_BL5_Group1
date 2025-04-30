package controller.Admin;

import dao.NewDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import model.News;
import model.User;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Base64;

@WebServlet(name = "UpdateNewsController", urlPatterns = {"/UpdateNewsController"})
@MultipartConfig
public class UpdateNewsController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login?error=Please+login+first");
            return;
        }

        int id = Integer.parseInt(request.getParameter("id"));
        String title = request.getParameter("newTitle");
        String description = request.getParameter("description");
        Part imagePart = request.getPart("img");
        String createAt = request.getParameter("createAt");

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

        if (createAt == null || createAt.trim().isEmpty()) {
            error.append("Creation date is required.<br>");
        }

        if (error.length() > 0) {
            request.setAttribute("error", error.toString());
            request.getRequestDispatcher("Admin/EditNews.jsp").forward(request, response);
            return;
        }

        String imgBase64;
        NewDAO dao = new NewDAO();
        if (imagePart != null && imagePart.getSize() > 0) {
            byte[] photo = convertInputStreamToByteArray(imagePart.getInputStream());
            imgBase64 = Base64.getEncoder().encodeToString(photo);
        } else {
            News existingNews = dao.getNewsById(id);
            imgBase64 = existingNews.getImg();
        }

        News news = new News(title, description, imgBase64, createAt);
        news.setNewId(id);
        int result = dao.updateNews(news);
        if (result > 0) {
            response.sendRedirect("displayNews");
        } else {
            request.setAttribute("errorMessage", "Error updating news");
            request.getRequestDispatcher("Admin/EditNews.jsp").forward(request, response);
        }
    }

    private byte[] convertInputStreamToByteArray(InputStream inputStream) throws IOException {
        try (ByteArrayOutputStream outputStream = new ByteArrayOutputStream()) {
            byte[] buffer = new byte[4096];
            int bytesRead;
            while ((bytesRead = inputStream.read(buffer)) != -1) {
                outputStream.write(buffer, 0, bytesRead);
            }
            return outputStream.toByteArray();
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet to update news";
    }
}