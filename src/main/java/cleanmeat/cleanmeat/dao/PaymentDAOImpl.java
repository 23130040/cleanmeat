package cleanmeat.cleanmeat.dao;

import cleanmeat.cleanmeat.mapper.CategoryMapper;
import cleanmeat.cleanmeat.mapper.PaymentMapper;
import cleanmeat.cleanmeat.model.Category;
import cleanmeat.cleanmeat.model.Payment;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class PaymentDAOImpl extends BaseDAO implements PaymentDAO {
    @Override
    public boolean insert(Payment payment) {
        String sql = "insert into payment (name, status) values (?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, payment.getName());
            ps.setBoolean(2, payment.isStatus());
            if (ps.executeUpdate() >= 1) return true;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return false;
    }

    @Override
    public Payment findById(int id) {
        String sql = "select * from payment where id = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return PaymentMapper.map(rs);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return null;
    }

    @Override
    public boolean updateStatus(int id, boolean status) {
        String sql = "update payment set status = ? where id = ?";
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

    @Override
    public List<Payment> findByStatus(boolean status) {
        List<Payment> payments = new ArrayList<>();
        String sql = "select * from payment where status = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setBoolean(1, status);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Payment payment = PaymentMapper.map(rs);
                    payments.add(payment);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return payments;
    }

    @Override
    public List<Payment> findAll() {
        String sql = "select * from payment";
        List<Payment> payments = new ArrayList<>();
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Payment payment = PaymentMapper.map(rs);
                payments.add(payment);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return payments;
    }
}
