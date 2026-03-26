package cleanmeat.cleanmeat.dao;

import cleanmeat.cleanmeat.mapper.FeedbackMapper;
import cleanmeat.cleanmeat.model.Feedback;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class FeedbackDAOImpl extends BaseDAO implements FeedbackDAO {

    @Override
    public Feedback findById(int id) {
        String sql = "select * from feedback where id = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return FeedbackMapper.map(rs);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return null;
    }

    @Override
    public List<Feedback> findAll() {
        String sql = "select * from feedback";
        List<Feedback> feedbacks = new ArrayList<>();
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Feedback feedback = FeedbackMapper.map(rs);
                feedbacks.add(feedback);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return feedbacks;
    }

    @Override
    public boolean insert(Feedback feedback) {
        String sql = "insert into feedback (user_id, item_id, rating, comment) " +
                "values (?, ?, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, feedback.getUser_id());
            ps.setInt(2, feedback.getItem_id());
            ps.setInt(3, feedback.getRating());
            ps.setString(4, feedback.getComment());
            if (ps.executeUpdate() >= 1) return true;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return false;
    }

    @Override
    public boolean update(Feedback feedback) {
        String sql = """
                update feedback
                set rating = ?, comment = ?, updated_at = NOW()
                where id = ?
                """;
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, feedback.getRating());
            ps.setString(2, feedback.getComment());
            ps.setInt(3, feedback.getId());
            if (ps.executeUpdate() >= 1) return true;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return false;
    }

    @Override
    public boolean delete(int id) {
        String sql = "delete from feedback where id = ?";
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
