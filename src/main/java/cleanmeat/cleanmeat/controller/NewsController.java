package cleanmeat.cleanmeat.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import cleanmeat.cleanmeat.dao.NewsDAO;
import cleanmeat.cleanmeat.dao.NewsDAOImpl;
import cleanmeat.cleanmeat.model.News;
import java.util.List;
import java.io.IOException;

@WebServlet(name = "news", value = "/news")
public class NewsController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        NewsDAO newsDAO = new NewsDAOImpl();
        
        int page = 1;
        int pageSize = 4;
        String pageParam = request.getParameter("page");
        if (pageParam != null && !pageParam.isEmpty()) {
            try {
                page = Integer.parseInt(pageParam);
            } catch (NumberFormatException e) {
                page = 1;
            }
        }
        
        int totalNews = newsDAO.countNews();
        int totalPages = (int) Math.ceil((double) totalNews / pageSize);
        if (page > totalPages && totalPages > 0) {
            page = totalPages;
        }

        List<News> newsList = newsDAO.getNewsByPage(page, pageSize);
        List<News> latestNews = newsDAO.getNewsByPage(1, 3);
        for (News news : newsList) {
            if (news.getContent() != null) {
                String plainText = news.getContent().replaceAll("<[^>]*>", "");
                plainText = plainText.replaceAll("&quot;", "\"").replaceAll("&nbsp;", " ");
                news.setContent(plainText.trim());
            }
        }
        
        for (News news : latestNews) {
            if (news.getContent() != null) {
                String plainText = news.getContent().replaceAll("<[^>]*>", "");
                plainText = plainText.replaceAll("&quot;", "\"").replaceAll("&nbsp;", " ");
                news.setContent(plainText.trim());
            }
        }
        request.setAttribute("newsList", newsList);
        request.setAttribute("latestNews", latestNews);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("pageTitle", "Tin tức");
        request.setAttribute("pageContent", "/view/customer/news.jsp");
        request.setAttribute("pageCss", "news.css");
        request.setAttribute("active", "news");
        
        request.getRequestDispatcher("/view/customer/base.jsp").forward(request, response);
    }
}
