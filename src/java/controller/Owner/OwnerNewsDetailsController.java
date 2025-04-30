package controller.Owner;

import dao.NewDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.News;

@WebServlet(name = "OwnerNewsDetailsController", urlPatterns = {"/ownernewsdetails"})
public class OwnerNewsDetailsController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        NewDAO dao = new NewDAO();
        String newId_raw = request.getParameter("id");
        int newId = Integer.parseInt(newId_raw);
        List<News> newsDetail = dao.getNewsDetails(newId);
        request.setAttribute("news", newsDetail);
        request.getRequestDispatcher("Owner/OwnerNewsDetails.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "OwnerNewsDetailsController Servlet";
    }
}