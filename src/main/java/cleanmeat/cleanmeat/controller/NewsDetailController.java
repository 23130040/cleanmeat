package cleanmeat.cleanmeat.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import cleanmeat.cleanmeat.dao.NewsDAO;
import cleanmeat.cleanmeat.dao.NewsDAOImpl;
import cleanmeat.cleanmeat.model.News;
import java.util.List;
import java.io.IOException;

@WebServlet(name = "newsDetail", value = "/newsdetail")
public class NewsDetailController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/news");
            return;
        }

        int id;
        try {
            id = Integer.parseInt(idParam);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/news");
            return;
        }

        NewsDAO newsDAO = new NewsDAOImpl();
        News news = newsDAO.findById(id);

        if (news == null) {
            response.sendRedirect(request.getContextPath() + "/news");
            return;
        }

        List<News> latestNews = newsDAO.getNewsByPage(1, 3);
        for (News n : latestNews) {
            if (n.getContent() != null) {
                String plainText = n.getContent().replaceAll("<[^>]*>", "");
                plainText = plainText.replaceAll("&quot;", "\"").replaceAll("&nbsp;", " ");
                n.setContent(plainText.trim());
            }
        }

        request.setAttribute("news", news);
        request.setAttribute("latestNews", latestNews);

        request.setAttribute("pageTitle", news.getTitle());
        request.setAttribute("pageContent", "/view/customer/newsdetail.jsp");
        request.setAttribute("pageCss", "newsdetail.css");
        request.setAttribute("active", "news");
        
        request.getRequestDispatcher("/view/base.jsp").forward(request, response);
    }
}
