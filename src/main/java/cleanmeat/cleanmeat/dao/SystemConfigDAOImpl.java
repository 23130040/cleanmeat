package cleanmeat.cleanmeat.dao;

import cleanmeat.cleanmeat.mapper.SystemConfigMapper;
import cleanmeat.cleanmeat.model.SystemConfig;
import java.sql.*;

public class SystemConfigDAOImpl extends BaseDAO implements SystemConfigDAO {
    @Override
    public SystemConfig getConfig() {
        String sql = "SELECT * FROM system_config LIMIT 1";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return SystemConfigMapper.map(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public boolean updateConfig(SystemConfig config) {
        String sql = "UPDATE system_config SET name = ?, email = ?, hotline = ?, tax_code = ?, facebook = ?, address = ?, logo_url = ?, created_by = ? WHERE id = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, config.getName());
            ps.setString(2, config.getEmail());
            ps.setString(3, config.getHotline());
            ps.setString(4, config.getTax_code());
            ps.setString(5, config.getFacebook());
            ps.setString(6, config.getAddress());
            ps.setString(7, config.getLogo_url());
            
            if (config.getCreated_by() != null) {
                ps.setInt(8, config.getCreated_by());
            } else {
                ps.setNull(8, Types.INTEGER);
            }
            
            ps.setInt(9, config.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
