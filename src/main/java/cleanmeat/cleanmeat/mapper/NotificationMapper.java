package cleanmeat.cleanmeat.mapper;

import cleanmeat.cleanmeat.model.Notification;

import java.sql.ResultSet;
import java.sql.SQLException;

public class NotificationMapper {
    public static Notification map(ResultSet rs) throws SQLException {
        Notification notification = new Notification();
        notification.setId(rs.getInt("id"));
        notification.setUser_id(rs.getInt("user_id"));
        notification.setContent(rs.getString("content"));
        notification.setEmail(rs.getString("email"));
        notification.setUrl(rs.getString("url"));
        notification.setType(rs.getString("type"));
        notification.setIs_read(rs.getBoolean("is_read"));
        notification.setCreated_at(rs.getTimestamp("created_at").toLocalDateTime());
        return notification;
    }
}
