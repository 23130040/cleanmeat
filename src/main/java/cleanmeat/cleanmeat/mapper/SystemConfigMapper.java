package cleanmeat.cleanmeat.mapper;

import cleanmeat.cleanmeat.model.SystemConfig;

import java.sql.ResultSet;
import java.sql.SQLException;

public class SystemConfigMapper {
    public static SystemConfig map(ResultSet rs) throws SQLException {
        SystemConfig systemConfig = new SystemConfig();
        systemConfig.setId(rs.getInt("id"));
        systemConfig.setName(rs.getString("name"));
        systemConfig.setEmail(rs.getString("email"));
        systemConfig.setHotline(rs.getString("hotline"));
        systemConfig.setTax_code(rs.getString("tax_code"));
        systemConfig.setFacebook(rs.getString("facebook"));
        systemConfig.setAddress(rs.getString("address"));
        systemConfig.setLogo_url(rs.getString("logo_url"));
        systemConfig.setCreated_by(rs.getInt("created_by"));
        return systemConfig;
    }
}
