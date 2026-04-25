package cleanmeat.cleanmeat.dao;

import cleanmeat.cleanmeat.mapper.ContactMapper;
import cleanmeat.cleanmeat.model.Contact;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ContactDAOImpl extends BaseDAO implements ContactDAO {
    @Override
    public List<Contact> findAll() {
        String sql = "SELECT * FROM contacts ORDER BY created_at DESC";
        List<Contact> list = new ArrayList<>();
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(ContactMapper.map(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public Contact findById(int id) {
        String sql = "SELECT * FROM contacts WHERE id = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return ContactMapper.map(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public boolean updateStatus(int id, String status, int adminId) {
        String sql = "UPDATE contacts SET status = ?, handled_by = ?, updated_at = NOW() WHERE id = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, adminId);
            ps.setInt(3, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean delete(int id) {
        String sql = "DELETE FROM contacts WHERE id = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean insert(Contact contact) {
        String sql = "INSERT INTO contacts (full_name, email, subject, message, status, created_at, updated_at) VALUES (?, ?, ?, ?, ?, NOW(), NOW())";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, contact.getFull_name());
            ps.setString(2, contact.getEmail());
            ps.setString(3, contact.getSubject());
            ps.setString(4, contact.getMessage());
            ps.setString(5, "pending");
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
