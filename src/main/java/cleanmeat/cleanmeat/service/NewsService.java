package cleanmeat.cleanmeat.service;

import cleanmeat.cleanmeat.dao.NewsDAO;
import cleanmeat.cleanmeat.dao.NewsDAOImpl;
import cleanmeat.cleanmeat.model.News;

import java.util.List;

public class NewsService {
    private final NewsDAO newsDAO;

    public NewsService() {
        this.newsDAO = new NewsDAOImpl();
    }

    public List<News> getAllNews() {
        return newsDAO.findAll();
    }

    public News getNewsById(int id) {
        return newsDAO.findById(id);
    }

    public boolean addNews(News news) {
        return newsDAO.insert(news);
    }

    public boolean updateNews(News news) {
        return newsDAO.update(news);
    }

    public boolean deleteNews(int id) {
        return newsDAO.delete(id);
    }
}
