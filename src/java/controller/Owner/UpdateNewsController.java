/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.Owner;

import dao.NewDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.util.Base64;
import model.News;


@WebServlet(name = "UpdateNewsController", urlPatterns = {"/UpdateNewsController"})
@MultipartConfig
public class UpdateNewsController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
   @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    int id = Integer.parseInt(request.getParameter("id"));
    String title = request.getParameter("newTitle");
    String description = request.getParameter("description");
    Part imagePart = request.getPart("img");
    String createAt = request.getParameter("createAt");

    // Validation
    StringBuilder error = new StringBuilder();
    if (title == null || title.trim().isEmpty()) {
        error.append("Title is required.<br>");
    } else if (title.length() > 100) {
        error.append("Title must not exceed 100 characters.<br>");
    }

    if (description == null || description.trim().isEmpty()) {
        error.append("Description is required.<br>");
    } else if (description.length() > 500) {
        error.append("Description must not exceed 500 characters.<br>");
    }

    if (imagePart == null) {
        error.append("Image is required.<br>");
    }

    if (createAt == null || createAt.trim().isEmpty()) {
        error.append("Create date is required.<br>");
    }

    if (error.length() > 0) {
        request.setAttribute("error", error.toString());
        request.getRequestDispatcher("Owner/EditNews.jsp").forward(request, response);
        return;
    }

    byte[] photo = convertInputStreamToByteArray(imagePart.getInputStream());
    String imgBase64 = Base64.getEncoder().encodeToString(photo);

    NewDAO dao = new NewDAO();
    News news = new News(title, description, imgBase64, createAt);
    news.setNewId(id);
    int result = dao.updateNews(news);
    if (result > 0) {
        response.sendRedirect("displayNews");
    } else {
        request.setAttribute("errorMessage", "Error updating news");
        request.getRequestDispatcher("Owner/EditNews.jsp").forward(request, response);
    }
}

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//    }
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

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
