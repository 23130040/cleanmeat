package cleanmeat.cleanmeat.mapper;

import cleanmeat.cleanmeat.model.Address;

import java.sql.ResultSet;
import java.sql.SQLException;

public class AddressMapper {
    public static Address map(ResultSet rs) throws SQLException {
        Address address = new Address();
        address.setId(rs.getInt("id"));
        address.setUser_id(rs.getInt("user_id"));
        address.setAddress(rs.getString("address"));
        address.setIs_Default(rs.getBoolean("is_default"));
        address.setCreated_at(rs.getTimestamp("created_at").toLocalDateTime());
        address.setUpdated_at(rs.getTimestamp("updated_at").toLocalDateTime());
        return address;
    }
}
