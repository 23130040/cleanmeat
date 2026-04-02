package cleanmeat.cleanmeat.dao;

import cleanmeat.cleanmeat.model.News;

import java.util.List;

public interface NewsDAO {
    public News findById(int id);

    public List<News> findAll();

    public List<News> getNewsByPage(int page, int pageSize);

    public int countNews();

    public boolean insert(News news);

    public boolean update(News news);

    public boolean delete(int id);
}
