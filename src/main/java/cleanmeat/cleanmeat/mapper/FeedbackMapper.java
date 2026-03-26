package cleanmeat.cleanmeat.mapper;

import cleanmeat.cleanmeat.model.Feedback;

import java.sql.ResultSet;
import java.sql.SQLException;

public class FeedbackMapper {
    public static Feedback map(ResultSet rs) throws SQLException {
        Feedback feedback = new Feedback();
        feedback.setId(rs.getInt("id"));
        feedback.setUser_id(rs.getInt("user_id"));
        feedback.setItem_id(rs.getInt("item_id"));
        feedback.setRating(rs.getInt("rating"));
        feedback.setComment(rs.getString("comment"));
        feedback.setCreated_at(rs.getTimestamp("created_at").toLocalDateTime());
        feedback.setUpdated_at(rs.getTimestamp("updated_at").toLocalDateTime());
        return feedback;
    }
}
