package cleanmeat.cleanmeat.dao;

import cleanmeat.cleanmeat.mapper.OrdersStatusHistoryMapper;
import cleanmeat.cleanmeat.model.OrdersStatusHistory;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class OrdersStatusHistoryDAOImpl extends BaseDAO implements OrdersStatusHistoryDAO {
    @Override
    public void insert(OrdersStatusHistory history) {
        String sql = "INSERT INTO orders_status_history (order_id, status_from, status_to, changed_by, note) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, history.getOrder_id());
            ps.setString(2, history.getStatus_from());
            ps.setString(3, history.getStatus_to());
            ps.setString(4, history.getChanged_by());
            ps.setString(5, history.getNote());
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<OrdersStatusHistory> findByOrderId(int orderId) {
        String sql = "SELECT * FROM orders_status_history WHERE order_id = ? ORDER BY changed_at DESC";
        List<OrdersStatusHistory> historyList = new ArrayList<>();
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    historyList.add(OrdersStatusHistoryMapper.map(rs));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return historyList;
    }
}
