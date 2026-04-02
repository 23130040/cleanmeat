package cleanmeat.cleanmeat.mapper;

import cleanmeat.cleanmeat.model.SystemConfig;
import java.sql.ResultSet;
import java.sql.SQLException;

public class SystemConfigMapper {
    public static SystemConfig map(ResultSet rs) throws SQLException {
        SystemConfig config = new SystemConfig();
        config.setId(rs.getInt("id"));
        config.setName(rs.getString("name"));
        config.setEmail(rs.getString("email"));
        config.setHotline(rs.getString("hotline"));
        config.setTax_code(rs.getString("tax_code"));
        config.setFacebook(rs.getString("facebook"));
        config.setAddress(rs.getString("address"));
        config.setLogo_url(rs.getString("logo_url"));
        
        int createdBy = rs.getInt("created_by");
        if (!rs.wasNull()) config.setCreated_by(createdBy);
        
        return config;
    }
}
