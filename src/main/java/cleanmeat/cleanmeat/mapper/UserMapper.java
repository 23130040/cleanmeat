package cleanmeat.cleanmeat.mapper;

import cleanmeat.cleanmeat.model.User;

import java.sql.ResultSet;
import java.sql.SQLException;

public class UserMapper {
    public static User map(ResultSet rs) throws SQLException {
        User user = new User();
        user.setId(rs.getInt("id"));
        user.setName(rs.getString("name"));
        user.setEmail(rs.getString("email"));
        user.setPassword(rs.getString("password"));
        user.setPhone(rs.getString("phone"));
        user.setGender(rs.getString("gender"));
        user.setBirthday(rs.getDate("birthday").toLocalDate());
        user.setRole(rs.getString("role"));
        user.setAvatar(rs.getString("avatar"));
        user.setCreated_at(rs.getTimestamp("created_at").toLocalDateTime());
        user.setUpdated_at(rs.getTimestamp("updated_at").toLocalDateTime());
        user.setStatus(rs.getBoolean("status"));
        user.setVerify_token(rs.getString("verify_token"));
        return user;
    }
}
