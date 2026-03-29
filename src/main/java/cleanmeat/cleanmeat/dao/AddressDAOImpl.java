package cleanmeat.cleanmeat.dao;

import cleanmeat.cleanmeat.mapper.AddressMapper;
import cleanmeat.cleanmeat.model.Address;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AddressDAOImpl extends BaseDAO implements AddressDAO {
    @Override
    public Address findById(int id) {
        String sql = """
                select * from address
                where id = ?
                """;
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next())
                    return AddressMapper.map(rs);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return null;
    }

    @Override
    public List<Address> findByUserId(int user_id) {
        List<Address> list = new ArrayList<>();
        String sql = """
                select * from address where user_id = ?
                """;
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, user_id);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Address address = AddressMapper.map(rs);
                    list.add(address);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return list;
    }

    @Override
    public boolean insert(Address address) {
        String sqlUnsetAll = "UPDATE address SET is_default = 0 WHERE user_id = ?";
        String sqlInsert = "INSERT INTO address (user_id, address, is_default) VALUES (?, ?, ?)";

        try (Connection conn = getConnection()) {
            conn.setAutoCommit(false);
            try {
                if (address.isIs_Default()) {
                    try (PreparedStatement ps1 = conn.prepareStatement(sqlUnsetAll)) {
                        ps1.setInt(1, address.getUser_id());
                        ps1.executeUpdate();
                    }
                }

                try (PreparedStatement ps2 = conn.prepareStatement(sqlInsert)) {
                    ps2.setInt(1, address.getUser_id());
                    ps2.setString(2, address.getAddress());
                    ps2.setBoolean(3, address.isIs_Default());
                    if (ps2.executeUpdate() >= 1) {
                        conn.commit();
                        return true;
                    }
                }
                conn.rollback();
            } catch (SQLException e) {
                conn.rollback();
                throw new RuntimeException(e);
            } finally {
                conn.setAutoCommit(true);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return false;
    }

    @Override
    public boolean update(Address address) {
        String sql = """
                update address
                set address = ?, is_default = ?, updated_at = NOW()
                where id = ?
                """;
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, address.getAddress());
            ps.setBoolean(2, address.isIs_Default());
            ps.setInt(3, address.getId());
            if (ps.executeUpdate() >= 1) return true;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return false;
    }

    @Override
    public boolean delete(int id) {
        String sql = """
                delete from address where id = ?
                """;
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            if (ps.executeUpdate() >= 1) return true;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return false;
    }

    @Override
    public boolean setDefault(int user_id, int addressId) {
        String sqlUnsetAll = "UPDATE address SET is_default = 0 WHERE user_id = ?";
        String sqlSetDefault = "UPDATE address SET is_default = 1 WHERE id = ? AND user_id = ?";

        try (Connection conn = getConnection()) {
            conn.setAutoCommit(false);
            try {
                try (PreparedStatement ps1 = conn.prepareStatement(sqlUnsetAll)) {
                    ps1.setInt(1, user_id);
                    ps1.executeUpdate();
                }

                try (PreparedStatement ps2 = conn.prepareStatement(sqlSetDefault)) {
                    ps2.setInt(1, addressId);
                    ps2.setInt(2, user_id);
                    int rows = ps2.executeUpdate();
                    if (rows > 0) {
                        conn.commit();
                        return true;
                    }
                }
                conn.rollback();
            } catch (SQLException e) {
                conn.rollback();
                throw new RuntimeException(e);
            } finally {
                conn.setAutoCommit(true);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return false;
    }
}
