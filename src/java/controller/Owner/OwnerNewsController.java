package controller.Owner;

import dao.NewDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import model.News;

@WebServlet(name = "OwnerNewsController", urlPatterns = {"/ownernews"})
public class OwnerNewsController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        NewDAO newsDAO = new NewDAO();
        
        String indexParam = request.getParameter("index");
        int index = 1;
        try {
            if (indexParam != null && !indexParam.isEmpty()) {
                index = Integer.parseInt(indexParam);
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }

        String pageSizeParam = request.getParameter("pageSize");
        int pageSize = 5;
        try {
            if (pageSizeParam != null && !pageSizeParam.isEmpty()) {
                pageSize = Integer.parseInt(pageSizeParam);
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }

        List<News> ListN = newsDAO.getNewsList(index, pageSize);
        SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-dd-MM HH:mm:ss.S");
        SimpleDateFormat sds = new SimpleDateFormat("dd-MM-yyyy");
        for (News news : ListN) {
            String formattedDate = news.getCreateAt();
            try {
                Date date = inputFormat.parse(formattedDate);
                formattedDate = sds.format(date);
                news.setCreateAt(formattedDate);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        request.setAttribute("ListN", ListN);
        request.setAttribute("pageSize", pageSize);
        request.setAttribute("currentPage", index);
        request.getRequestDispatcher("Owner/OwnerNews.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String search = request.getParameter("search");
        NewDAO newsDAO = new NewDAO();

        String indexParam = request.getParameter("index");
        int index = 1;
        try {
            if (indexParam != null && !indexParam.isEmpty()) {
                index = Integer.parseInt(indexParam);
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }

        String pageSizeParam = request.getParameter("pageSize");
        int pageSize = 5;
        try {
            if (pageSizeParam != null && !pageSizeParam.isEmpty()) {
                pageSize = Integer.parseInt(pageSizeParam);
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }

        List<News> ListN = newsDAO.searchByText(index, pageSize, search);
        SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-dd-MM HH:mm:ss.S");
        SimpleDateFormat sds = new SimpleDateFormat("dd-MM-yyyy");
        for (News news : ListN) {
            String formattedDate = news.getCreateAt();
            try {
                Date date = inputFormat.parse(formattedDate);
                formattedDate = sds.format(date);
                news.setCreateAt(formattedDate);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        request.setAttribute("ListN", ListN);
        request.setAttribute("pageSize", pageSize);
        request.setAttribute("currentPage", index);
        request.setAttribute("search", search);
        request.getRequestDispatcher("Owner/OwnerNews.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "OwnerNewsController Servlet";
    }
}