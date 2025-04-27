package controller.Owner;

import dao.NewDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.News;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@WebServlet(name = "displayNewController", urlPatterns = {"/displayNews"})
public class displayNewController extends HttpServlet {

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

        String search = request.getParameter("search");
        List<News> newsList = (search == null || search.isEmpty())
                ? newsDAO.getNewsList(index, pageSize)
                : newsDAO.searchByText(index, pageSize, search);

        // Định dạng ngày
        SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-dd-MM HH:mm:ss.S");
        SimpleDateFormat outputFormat = new SimpleDateFormat("dd-MM-yyyy");
        for (News news : newsList) {
            try {
                Date date = inputFormat.parse(news.getCreateAt());
                news.setCreateAt(outputFormat.format(date));
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        // Ước lượng tổng số tin tức (vì không sửa DAO)
        // Lấy tất cả tin tức với pageSize lớn để tính totalNews
        List<News> allNews = (search == null || search.isEmpty())
                ? newsDAO.getNewsList(1, Integer.MAX_VALUE)
                : newsDAO.searchByText(1, Integer.MAX_VALUE, search);
        int totalNews = allNews.size();
        int totalPages = (int) Math.ceil((double) totalNews / pageSize);

        request.setAttribute("newsList", newsList);
        request.setAttribute("pageSize", pageSize);
        request.setAttribute("currentPage", index);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("search", search);
        request.getRequestDispatcher("Owner/DisplayNews.jsp").forward(request, response);
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
        return "Servlet for displaying news list";
    }
}