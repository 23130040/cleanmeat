package cleanmeat.cleanmeat.mapper;

import cleanmeat.cleanmeat.model.Transport;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

public class TransportMapper {
    public static Transport map(ResultSet rs) throws SQLException {
        Transport transport = new Transport();
        transport.setId(rs.getInt("id"));
        transport.setName(rs.getString("name"));
        transport.setBase_fee(rs.getInt("base_fee"));
        transport.setEstimate_day(rs.getInt("estimated_day"));
        transport.setStatus(rs.getBoolean("status"));
        transport.setFree_ship(rs.getInt("free_ship"));
        
        Timestamp created = rs.getTimestamp("created_day");
        if (created != null) {
            transport.setCreated_at(created.toLocalDateTime());
        }
        
        Timestamp updated = rs.getTimestamp("updated_day");
        if (updated != null) {
            transport.setUpdated_at(updated.toLocalDateTime());
        }
        
        return transport;
    }
}
