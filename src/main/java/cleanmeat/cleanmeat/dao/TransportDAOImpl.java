package cleanmeat.cleanmeat.dao;

import cleanmeat.cleanmeat.mapper.TransportMapper;
import cleanmeat.cleanmeat.model.Transport;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TransportDAOImpl extends BaseDAO implements TransportDAO {
    @Override
    public Transport findById(int id) {
        checkAndInitializeTable();
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
        checkAndInitializeTable();
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
        checkAndInitializeTable();
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
        checkAndInitializeTable();
        String sql = "update transport set name = ?, base_fee = ?, estimated_day = ?, status = ?, free_ship = ?, updated_day = NOW() where id = ?";
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
        checkAndInitializeTable();
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

    public boolean updateStatus(int id, boolean status) {
        checkAndInitializeTable();
        String sql = "update transport set status = ?, updated_day = NOW() where id = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setBoolean(1, status);
            ps.setInt(2, id);
            if (ps.executeUpdate() >= 1) return true;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return false;
    }

    private synchronized void checkAndInitializeTable() {
        try (Connection conn = getConnection()) {
            DatabaseMetaData metaData = conn.getMetaData();
            String catalog = conn.getCatalog();
            try (ResultSet rs = metaData.getTables(catalog, null, "transport", null)) {
                if (!rs.next()) {
                    try (Statement stmt = conn.createStatement()) {
                        stmt.execute("CREATE TABLE IF NOT EXISTS `transport` (" +
                                "  `id` int NOT NULL AUTO_INCREMENT," +
                                "  `name` varchar(255) NOT NULL," +
                                "  `base_fee` int DEFAULT 0," +
                                "  `estimated_day` int DEFAULT NULL," +
                                "  `status` bit(1) DEFAULT b'1'," +
                                "  `created_day` datetime DEFAULT CURRENT_TIMESTAMP," +
                                "  `updated_day` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP," +
                                "  `free_ship` int DEFAULT NULL," +
                                "  PRIMARY KEY (`id`)" +
                                ") ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci;");
                    }
                }
            }
        } catch (SQLException e) {
            System.err.println("Database error during 'transport' table initialization: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
