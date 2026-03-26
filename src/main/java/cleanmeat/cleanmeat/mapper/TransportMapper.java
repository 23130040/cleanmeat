package cleanmeat.cleanmeat.mapper;

import cleanmeat.cleanmeat.model.Transport;

import java.sql.ResultSet;
import java.sql.SQLException;

public class TransportMapper {
    public static Transport map(ResultSet rs) throws SQLException {
        Transport transport = new Transport();
        transport.setId(rs.getInt("id"));
        transport.setName(rs.getString("name"));
        transport.setBase_fee(rs.getInt("base_fee"));
        transport.setEstimate_day(rs.getInt("estimate_day"));
        transport.setStatus(rs.getBoolean("status"));
        transport.setCreated_at(rs.getTimestamp("created_day").toLocalDateTime());
        transport.setUpdated_at(rs.getTimestamp("updated_day").toLocalDateTime());
        return transport;
    }
}
