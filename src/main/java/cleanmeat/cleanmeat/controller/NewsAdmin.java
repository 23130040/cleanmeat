package cleanmeat.cleanmeat.controller;

import cleanmeat.cleanmeat.model.News;
import cleanmeat.cleanmeat.model.User;
import cleanmeat.cleanmeat.service.NewsService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

import cleanmeat.cleanmeat.utils.R2Util;
import jakarta.servlet.http.Part;

@WebServlet(name = "news-admin", value = "/news-admin")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,
    maxFileSize = 1024 * 1024 * 10,
    maxRequestSize = 1024 * 1024 * 50
)
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
        request.setAttribute("pageJs", "newsAdmin.js");

        request.getRequestDispatcher("/view/admin/baseAdmin.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        
        if ("add".equals(action)) {
            try {
                String title = request.getParameter("title");
                String author = request.getParameter("author");
                String status = request.getParameter("status");
                String content = request.getParameter("content");
                Part filePart = request.getPart("picture");
                
                String pictureUrl = "";
                if (filePart != null && filePart.getSize() > 0) {
                    R2Util r2Util = new R2Util();
                    String fileName = "news_" + System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();
                    pictureUrl = r2Util.uploadFile(fileName, filePart.getInputStream(), filePart.getSize(), filePart.getContentType());
                }
                
                News news = new News();
                news.setTitle(title);
                news.setAuthor(author);
                news.setStatus(status);
                news.setContent(content);
                news.setPicture_url(pictureUrl);
                news.setCreated_by(currentUser.getId());
                
                NewsService newsService = new NewsService();
                if (newsService.addNews(news)) {
                    response.sendRedirect(request.getContextPath() + "/news-admin?success=news_added");
                } else {
                    response.sendRedirect(request.getContextPath() + "/news-admin?error=add_failed");
                }
                return;
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect(request.getContextPath() + "/news-admin?error=add_failed");
                return;
            }
        }
        
        doGet(request, response);
    }
}
