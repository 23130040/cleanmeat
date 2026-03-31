package cleanmeat.cleanmeat.controller;

import cleanmeat.cleanmeat.model.News;
import cleanmeat.cleanmeat.model.User;
import cleanmeat.cleanmeat.service.NewsService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "news-admin", value = "/news-admin")
public class NewsAdmin extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

        NewsService newsService = new NewsService();
        List<News> newsList = newsService.getAllNews();

        String search = request.getParameter("search");
        String filter = request.getParameter("filter");

        if (filter != null && !filter.isEmpty() && !filter.equals("Tất cả")) {
            newsList = newsList.stream().filter(n -> filter.equals(n.getStatus())).toList();
        }

        if (search != null && !search.trim().isEmpty()) {
            newsList = newsList.stream().filter(n -> n.getTitle().toLowerCase().contains(search.toLowerCase()) || n.getAuthor().toLowerCase().contains(search.toLowerCase())).toList();
        }

        request.setAttribute("newsList", newsList);
        request.setAttribute("currentFilter", filter != null ? filter : "Tất cả");
        request.setAttribute("searchQuery", search != null ? search : "");

        request.setAttribute("adminTitle", "Quản lý tin tức");
        request.setAttribute("active", "news-admin");
        request.setAttribute("user", currentUser);
        request.setAttribute("pageContent", "/view/admin/newsAdmin.jsp");
        request.setAttribute("pageCss", "newsAdmin.css");

        request.getRequestDispatcher("/view/admin/baseAdmin.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
