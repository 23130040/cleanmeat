package cleanmeat.cleanmeat.dao;

import cleanmeat.cleanmeat.mapper.StockHistoryMapper;
import cleanmeat.cleanmeat.model.StockHistory;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class StockHistoryDAOImpl extends BaseDAO implements StockHistoryDAO {
    @Override
    public boolean insert(StockHistory history) {
        String sql = "insert into stock_history (item_id, type, quantity, created_by) values (?, ?, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, history.getItem_id());
            ps.setString(2, history.getType());
            ps.setDouble(3, history.getQuantity());
            ps.setInt(4, history.getCreated_by());
            if (ps.executeUpdate() >= 1) return true;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return false;
    }

    @Override
    public List<StockHistory> findByItemId(int itemId) {
        String sql = "select * from stock_history where item_id = ?";
        List<StockHistory> list = new ArrayList<>();
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, itemId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    StockHistory history = StockHistoryMapper.map(rs);
                    list.add(history);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return list;
    }

    @Override
    public List<StockHistory> findByType(String type) {
        String sql = "select * from stock_history where type = ?";
        List<StockHistory> list = new ArrayList<>();
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, type);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    StockHistory history = StockHistoryMapper.map(rs);
                    list.add(history);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return list;
    }

    @Override
    public List<StockHistory> findAll() {
        String sql = "select * from stock_history";
        List<StockHistory> list = new ArrayList<>();
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                StockHistory history = StockHistoryMapper.map(rs);
                list.add(history);
            }
        } catch (SQLException ex) {
            throw new RuntimeException(ex);
        }
        return list;
    }

    @Override
    public boolean delete(int id) {
        String sql = "delete from stock_history where id = ?";
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
    public boolean deleteAll() {
        String sql = "delete from stock_history";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            if (ps.executeUpdate() >= 1) return true;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return false;
    }
}
