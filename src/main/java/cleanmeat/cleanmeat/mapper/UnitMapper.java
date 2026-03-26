package cleanmeat.cleanmeat.mapper;

import cleanmeat.cleanmeat.model.Unit;

import java.sql.ResultSet;
import java.sql.SQLException;

public class UnitMapper {
    public static Unit map(ResultSet rs) throws SQLException {
        Unit unit = new Unit();
        unit.setId(rs.getInt("id"));
        unit.setName(rs.getString("name"));
        unit.setAmount(rs.getDouble("amount"));
        unit.setCreated_at(rs.getTimestamp("created_at").toLocalDateTime());
        unit.setUpdated_at(rs.getTimestamp("updated_at").toLocalDateTime());
        return unit;
    }
}
