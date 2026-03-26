package cleanmeat.cleanmeat.dao;

import cleanmeat.cleanmeat.mapper.CategoryMapper;
import cleanmeat.cleanmeat.mapper.OriginMapper;
import cleanmeat.cleanmeat.model.Category;
import cleanmeat.cleanmeat.model.Origin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class OriginDAOImpl extends BaseDAO implements OriginDAO {
    @Override
    public Origin findById(int id) {
        String sql = "select * from origin where id = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return OriginMapper.map(rs);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return null;
    }

    @Override
    public List<Origin> findAll() {
        String sql = "select * from origin";
        List<Origin> origins = new ArrayList<>();
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Origin origin = OriginMapper.map(rs);
                origins.add(origin);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return origins;
    }

    @Override
    public boolean insert(Origin origin) {
        String sql = "insert into origin (name, description) values (?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, origin.getName());
            ps.setString(2, origin.getDescription());
            if (ps.executeUpdate() >= 1) return true;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return false;
    }

    @Override
    public boolean update(Origin origin) {
        String sql = """
                update origin
                set name = ?, description = ?, updated_at = NOW()
                where id = ?
                """;
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, origin.getName());
            ps.setString(2, origin.getDescription());
            ps.setInt(3, origin.getId());
            if (ps.executeUpdate() >= 1) return true;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return false;
    }

    @Override
    public boolean delete(int id) {
        String sql = "delete from origin where id = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            if (ps.executeUpdate() >= 1) return true;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return false;
    }
}
