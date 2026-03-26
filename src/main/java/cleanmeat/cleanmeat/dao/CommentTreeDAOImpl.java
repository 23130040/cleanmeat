package cleanmeat.cleanmeat.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CommentTreeDAOImpl extends BaseDAO implements CommentTreeDAO {
    @Override
    public void insertRelation(int ancestor_id, int descendant_id, int depth) {
        String sql = """
                insert into comment_tree (ancestor_id, descendant_id, depth) values (?, ?, ?)
                """;
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, ancestor_id);
            ps.setInt(2, descendant_id);
            ps.setInt(3, depth);
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<Integer> findDescendantIds(int ancestor_id) {
        List<Integer> list = new ArrayList<>();
        String sql = """
                select descendant_id from comment_tree where ancestor_id = ? and depth > 0;
                """;
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, ancestor_id);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next())
                    list.add(rs.getInt("descendant_id"));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return list;
    }

    @Override
    public List<Integer> findDirectChildrenIds(int ancestor_id) {
        List<Integer> list = new ArrayList<>();
        String sql = "select descendant_id from comment_tree where ancestor_id = ? and depth = 1;";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, ancestor_id);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next())
                    list.add(rs.getInt("descendant_id"));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return list;
    }

    @Override
    public List<Integer> findAncestorIds(int descendant_id) {
        List<Integer> list = new ArrayList<>();
        String sql = """
                select ancestor_id
                from comment_tree
                where descendant_id = ?
                and depth > 0
                order by depth asc;
                """;
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, descendant_id);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(rs.getInt("ancestor_id"));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return list;
    }

    @Override
    public boolean deleteByDescendant(int descendantId) {
        String sql = """
            delete from comment_tree
            where descendant_id = ?
            """;
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, descendantId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public boolean deleteSubtree(int ancestorId) {
        String sql = """
            delete from comment_tree
            where descendant_id in (
                select descendant_id
                from comment_tree
                where ancestor_id = ?
            )
            """;
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, ancestorId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
