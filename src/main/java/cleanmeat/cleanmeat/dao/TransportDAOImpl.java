package cleanmeat.cleanmeat.dao;

import cleanmeat.cleanmeat.mapper.CategoryMapper;
import cleanmeat.cleanmeat.mapper.TransportMapper;
import cleanmeat.cleanmeat.model.Category;
import cleanmeat.cleanmeat.model.Transport;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class TransportDAOImpl extends BaseDAO implements TransportDAO {
    @Override
    public Transport findById(int id) {
        String sql = "select * from transport where id = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return TransportMapper.map(rs);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return null;
    }

    @Override
    public List<Transport> findAll() {
        String sql = "select * from transport";
        List<Transport> transports = new ArrayList<>();
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Transport transport = TransportMapper.map(rs);
                transports.add(transport);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return transports;
    }

    @Override
    public boolean insert(Transport transport) {
        String sql = "insert into transport (name, base_fee, estimated_day, status, free_ship) values (?, ?, ?, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, transport.getName());
            ps.setInt(2, transport.getBase_fee());
            ps.setInt(3, transport.getEstimate_day());
            ps.setBoolean(4, transport.isStatus());
            ps.setInt(5, transport.getFree_ship());
            if (ps.executeUpdate() >= 1) return true;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return false;
    }

    @Override
    public boolean update(Transport transport) {
        String sql = """
                update transport
                set name = ?, base_fee = ?, estimated_day = ?, status = ?, free_ship = ?, updated_day = NOW()
                where id = ?
                """;
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, transport.getName());
            ps.setInt(2, transport.getBase_fee());
            ps.setInt(3, transport.getEstimate_day());
            ps.setBoolean(4, transport.isStatus());
            ps.setInt(5, transport.getFree_ship());
            ps.setInt(6, transport.getId());
            if (ps.executeUpdate() >= 1) return true;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return false;
    }

    @Override
    public boolean delete(int id) {
        String sql = "delete from transport where id = ?";
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
