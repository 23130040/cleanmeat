package cleanmeat.cleanmeat.dao;
import cleanmeat.cleanmeat.mapper.CategoryMapper;
import cleanmeat.cleanmeat.mapper.NewsMapper;
import cleanmeat.cleanmeat.model.Category;
import cleanmeat.cleanmeat.model.News;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class NewsDAOImpl extends BaseDAO implements NewsDAO {

    @Override
    public News findById(int id) {
        String sql = "select * from news where id = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return NewsMapper.map(rs);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return null;
    }

    @Override
    public List<News> findAll() {
        String sql = "select * from news order by created_at desc";
        List<News> newss = new ArrayList<>();
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                News news = NewsMapper.map(rs);
                newss.add(news);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return newss;
    }

    @Override
    public List<News> getNewsByPage(int page, int pageSize) {
        String sql = "select * from news order by created_at desc limit ?, ?";
        List<News> newss = new ArrayList<>();
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            int offset = (page - 1) * pageSize;
            ps.setInt(1, offset);
            ps.setInt(2, pageSize);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    News news = NewsMapper.map(rs);
                    newss.add(news);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return newss;
    }

    @Override
    public int countNews() {
        String sql = "select count(*) from news";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return 0;
    }

    @Override
    public boolean insert(News news) {
        String sql = """
                insert into news (title, author, picture_url, content, status, created_by) 
                values (?, ?, ?, ?, ?, ?)
                """;
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, news.getTitle());
            ps.setString(2, news.getAuthor());
            ps.setString(3, news.getPicture_url());
            ps.setString(4, news.getContent());
            ps.setString(5, news.getStatus());
            ps.setInt(6, news.getCreated_by());
            if (ps.executeUpdate() >= 1) return true;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return false;
    }

    @Override
    public boolean update(News news) {
        String sql = """
                update news
                set title = ?, author = ?, picture_url = ?, content = ?, status = ?, updated_at = NOW()
                where id = ?
                """;
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, news.getTitle());
            ps.setString(2, news.getAuthor());
            ps.setString(3, news.getPicture_url());
            ps.setString(4, news.getContent());
            ps.setString(5, news.getStatus());
            ps.setInt(6, news.getId());
            if (ps.executeUpdate() >= 1) return true;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return false;
    }

    @Override
    public boolean delete(int id) {
        String sql = "delete from news where id = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            if (ps.executeUpdate() >= 1) return true;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return false;
    }
}
