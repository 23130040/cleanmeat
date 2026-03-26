package cleanmeat.cleanmeat.mapper;

import cleanmeat.cleanmeat.model.News;

import java.sql.ResultSet;
import java.sql.SQLException;

public class NewsMapper {
    public static News map(ResultSet rs) throws SQLException {
        News news = new News();
        news.setId(rs.getInt("id"));
        news.setTitle(rs.getString("title"));
        news.setAuthor(rs.getString("author"));
        news.setPicture_url(rs.getString("picture_url"));
        news.setContent(rs.getString("content"));
        news.setStatus(rs.getString("status"));
        news.setCreated_at(rs.getTimestamp("created_at").toLocalDateTime());
        news.setCreated_by(rs.getInt("created_by"));
        news.setUpdated_at(rs.getTimestamp("updated_at").toLocalDateTime());
        return news;
    }
}
