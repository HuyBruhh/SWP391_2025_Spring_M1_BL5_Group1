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
import java.net.URLEncoder;

@WebServlet(name = "DeleteNewsController", urlPatterns = {"/deleteNews"})
public class DeleteNewsController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login?error=Please+login+first");
            return;
        }
        response.sendRedirect("displayNews");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login?error=Please+login+first");
            return;
        }

        try {
            int newsId = Integer.parseInt(request.getParameter("newsId"));
            
            News news = new News();
            news.setNewId(newsId);

            EditNewsDAO dao = new EditNewsDAO();
            int result = dao.DeleteNews(news);

            StringBuilder redirectUrl = new StringBuilder("displayNews");
            boolean hasParams = false;

            String index = request.getParameter("index");
            String pageSize = request.getParameter("pageSize");
            String search = request.getParameter("search");

            if (index != null && !index.isEmpty()) {
                redirectUrl.append(hasParams ? "&" : "?").append("index=").append(index);
                hasParams = true;
            }
            if (pageSize != null && !pageSize.isEmpty()) {
                redirectUrl.append(hasParams ? "&" : "?").append("pageSize=").append(pageSize);
                hasParams = true;
            }
            if (search != null && !search.isEmpty()) {
                redirectUrl.append(hasParams ? "&" : "?").append("search=").append(URLEncoder.encode(search, "UTF-8"));
                hasParams = true;
            }

            if (result > 0) {
                redirectUrl.append(hasParams ? "&" : "?").append("success=News+deleted+successfully");
            } else {
                redirectUrl.append(hasParams ? "&" : "?").append("error=Failed+to+delete+news");
            }

            response.sendRedirect(redirectUrl.toString());
        } catch (NumberFormatException e) {
            response.sendRedirect("displayNews?error=Invalid+news+ID");
        } catch (Exception e) {
            response.sendRedirect("displayNews?error=Error+occurred+while+deleting+news");
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet to delete news";
    }
}