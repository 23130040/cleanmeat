package cleanmeat.cleanmeat.mapper;

import cleanmeat.cleanmeat.model.Origin;

import java.sql.ResultSet;
import java.sql.SQLException;

public class OriginMapper {
    public static Origin map(ResultSet rs) throws SQLException {
        Origin origin = new Origin();
        origin.setId(rs.getInt("id"));
        origin.setName(rs.getString("name"));
        origin.setDescription(rs.getString("description"));
        origin.setCreated_at(rs.getTimestamp("created_at").toLocalDateTime());
        origin.setUpdated_at(rs.getTimestamp("updated_at").toLocalDateTime());
        return origin;
    }
}
