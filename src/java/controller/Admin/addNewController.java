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
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Base64;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "addNewController", urlPatterns = {"/addnews"})
@MultipartConfig
public class addNewController extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(addNewController.class.getName());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login?error=Please+login+first");
            return;
        }

        request.getRequestDispatcher("Admin/Addnews.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login?error=Please+login+first");
            return;
        }

        String title = request.getParameter("title");
        String description = request.getParameter("description");
        Part imagePart = request.getPart("image");
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

        if (imagePart == null) {
            error.append("Image is required.<br>");
        }

        if (createAt == null || createAt.trim().isEmpty()) {
            error.append("Creation date is required.<br>");
        }

        if (error.length() > 0) {
            request.setAttribute("error", error.toString());
            request.getRequestDispatcher("Admin/Addnews.jsp").forward(request, response);
            return;
        }

        byte[] photo = convertInputStreamToByteArray(imagePart.getInputStream());
        String imgBase64 = Base64.getEncoder().encodeToString(photo);

        NewDAO dao = new NewDAO();
        try {
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            Date createDate = dateFormat.parse(createAt);
            News news = new News(title, description, imgBase64, createAt);
            dao.insertNews(news);
            response.sendRedirect("displayNews");
        } catch (ParseException e) {
            LOGGER.log(Level.SEVERE, "Date parsing error", e);
            request.setAttribute("error", "Invalid date format.");
            request.getRequestDispatcher("Admin/Addnews.jsp").forward(request, response);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Database error", e);
            request.setAttribute("error", "Error occurred while saving news.");
            request.getRequestDispatcher("Admin/Addnews.jsp").forward(request, response);
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
        return "Servlet to add news";
    }
}