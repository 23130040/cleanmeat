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
        String sql = """
            select f.*, u.name as user_name, u.avatar, i.name as item_name
            from feedback f
            join user u on f.user_id = u.id
            join item i on f.item_id = i.id
            order by f.created_at desc
            """;
        List<Feedback> feedbacks = new ArrayList<>();
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Feedback feedback = FeedbackMapper.map(rs);
                feedback.setName(rs.getString("user_name"));
                feedback.setAvatar(rs.getString("avatar"));
                feedback.setItem_name(rs.getString("item_name"));
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
    @Override
    public List<Feedback> findByItemId(int itemId) {
        String sql = """
            select f.*, u.name, u.avatar
            from feedback f
            join user u on f.user_id = u.id
            where f.item_id = ?
            order by f.created_at desc
            """;

        List<Feedback> list = new ArrayList<>();

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, itemId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Feedback f = FeedbackMapper.map(rs);
                    f.setName(rs.getString("name"));
                    f.setAvatar(rs.getString("avatar"));
                    list.add(f);
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return list;
    }
}
