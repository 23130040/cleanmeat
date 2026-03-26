package cleanmeat.cleanmeat.dao;

import cleanmeat.cleanmeat.mapper.SystemConfigMapper;
import cleanmeat.cleanmeat.model.SystemConfig;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class SystemConfigDAOImpl extends BaseDAO implements SystemConfigDAO {
    @Override
    public SystemConfig get() {
        String sql = "select * from system_config";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return SystemConfigMapper.map(rs);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return null;
    }

    @Override
    public boolean update(SystemConfig config) {
        String sql = """
                update system_config
                set name = ?, email = ?, hotline = ?, tax_code = ?, facebook = ?, address = ?, logo_url = ?, created_by = ?
                where id = ?
                """;
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, config.getName());
            ps.setString(2, config.getEmail());
            ps.setString(3, config.getHotline());
            ps.setString(4, config.getTax_code());
            ps.setString(5, config.getFacebook());
            ps.setString(6, config.getAddress());
            ps.setString(7, config.getLogo_url());
            ps.setInt(8, config.getCreated_by());
            ps.setInt(9, config.getId());
            if (ps.executeUpdate() >= 1) return true;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return false;
    }

    @Override
    public boolean insert(SystemConfig config) {
        String sql = """
                insert into system_config (name, email, hotline, tax_code, facebook, address, logo_url, created_by)
                values (?, ?, ?, ?, ?, ?, ?, ?)
                """;
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, config.getName());
            ps.setString(2, config.getEmail());
            ps.setString(3, config.getHotline());
            ps.setString(4, config.getTax_code());
            ps.setString(5, config.getFacebook());
            ps.setString(6, config.getAddress());
            ps.setString(7, config.getLogo_url());
            ps.setInt(8, config.getCreated_by());
            if (ps.executeUpdate() >= 1) return true;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return false;
    }
}
