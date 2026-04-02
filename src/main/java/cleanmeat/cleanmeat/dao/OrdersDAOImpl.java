package cleanmeat.cleanmeat.dao;

import cleanmeat.cleanmeat.mapper.OrdersMapper;
import cleanmeat.cleanmeat.model.Orders;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class OrdersDAOImpl extends BaseDAO implements OrdersDAO {
    @Override
    public Orders findById(int id) {
        String sql = """
            SELECT o.*, u.name as user_name, u.email as user_email, 
                   p.name as payment_method, t.name as transport_method 
            FROM orders o 
            LEFT JOIN user u ON o.user_id = u.id 
            LEFT JOIN payment p ON o.payment_id = p.id 
            LEFT JOIN transport t ON o.transport_id = t.id 
            WHERE o.id = ?
        """;
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return OrdersMapper.map(rs);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return null;
    }

    @Override
    public List<Orders> findAll() {
        String sql = "select * from orders";
        List<Orders> orders = new ArrayList<>();
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Orders order = OrdersMapper.map(rs);
                orders.add(order);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return orders;
    }

    @Override
    public List<Orders> findAll(int limit, int offset) {
        String sql = """
            SELECT o.*, u.name as user_name, u.email as user_email, 
                   p.name as payment_method, t.name as transport_method 
            FROM orders o 
            LEFT JOIN user u ON o.user_id = u.id 
            LEFT JOIN payment p ON o.payment_id = p.id 
            LEFT JOIN transport t ON o.transport_id = t.id 
            ORDER BY o.id DESC 
            LIMIT ? OFFSET ?
        """;
        List<Orders> orders = new ArrayList<>();
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, limit);
            ps.setInt(2, offset);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Orders order = OrdersMapper.map(rs);
                    orders.add(order);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return orders;
    }

    @Override
    public int countAll() {
        String sql = "SELECT COUNT(*) FROM orders";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return 0;
    }

    @Override
    public int countByStatus(String status) {
        String sql = "SELECT COUNT(*) FROM orders WHERE status = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return 0;
    }

    @Override
    public double sumTotalRevenue() {
        String sql = "SELECT SUM(total_price) FROM orders WHERE status = 'Hoàn thành'";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getDouble(1);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return 0.0;
    }

    @Override
    public int countTodayOrders() {
        String sql = "SELECT COUNT(*) FROM orders WHERE DATE(created_at) = CURDATE()";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return 0;
    }

    @Override
    public double sumTodayRevenue() {
        String sql = "SELECT SUM(total_price) FROM orders WHERE DATE(created_at) = CURDATE() AND status = 'Hoàn thành'";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getDouble(1);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return 0.0;
    }

    @Override
    public double calculateOrderGrowth() {
        String sql = """
            SELECT 
                COUNT(CASE WHEN MONTH(created_at) = MONTH(CURRENT_DATE()) AND YEAR(created_at) = YEAR(CURRENT_DATE()) THEN 1 END) as current_month,
                COUNT(CASE WHEN MONTH(created_at) = MONTH(DATE_SUB(CURRENT_DATE(), INTERVAL 1 MONTH)) AND YEAR(created_at) = YEAR(DATE_SUB(CURRENT_DATE(), INTERVAL 1 MONTH)) THEN 1 END) as last_month
            FROM orders;
        """;
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                int currentMonth = rs.getInt("current_month");
                int lastMonth = rs.getInt("last_month");
                if (lastMonth == 0) return currentMonth > 0 ? 100.0 : 0.0;
                return ((double) (currentMonth - lastMonth) / lastMonth) * 100.0;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return 0.0;
    }

    @Override
    public double calculateRevenueGrowth() {
        String sql = """
            SELECT 
                SUM(CASE WHEN MONTH(created_at) = MONTH(CURRENT_DATE()) AND YEAR(created_at) = YEAR(CURRENT_DATE()) AND status = 'Hoàn thành' THEN total_price ELSE 0 END) as current_month,
                SUM(CASE WHEN MONTH(created_at) = MONTH(DATE_SUB(CURRENT_DATE(), INTERVAL 1 MONTH)) AND YEAR(created_at) = YEAR(DATE_SUB(CURRENT_DATE(), INTERVAL 1 MONTH)) AND status = 'Hoàn thành' THEN total_price ELSE 0 END) as last_month
            FROM orders;
        """;
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                double currentMonth = rs.getDouble("current_month");
                double lastMonth = rs.getDouble("last_month");
                if (lastMonth == 0) return currentMonth > 0 ? 100.0 : 0.0;
                return ((currentMonth - lastMonth) / lastMonth) * 100.0;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return 0.0;
    }

    @Override
    public int insert(Orders order) {
        String sql = """
                insert into orders (user_id, total_price, status, address_id, transport_id, payment_id) 
                values (?, ?, ?, ?, ?, ?)
                """;
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, java.sql.Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, order.getUser_id());
            ps.setDouble(2, order.getTotal_price());
            ps.setString(3, order.getStatus());
            ps.setInt(4, order.getAddress_id());
            ps.setInt(5, order.getTransport_id());
            ps.setInt(6, order.getPayment_id());
            
            int affectedRows = ps.executeUpdate();
            if (affectedRows == 0) return -1;

            try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    return generatedKeys.getInt(1);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return -1;
    }

    @Override
    public boolean update(Orders order) {
        String sql = """
                update orders
                set status = ?, address_id = ?, transport_id = ?, payment_id = ?, updated_at = NOW()
                where id = ?
                """;
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, order.getStatus());
            ps.setInt(2, order.getAddress_id());
            ps.setInt(3, order.getTransport_id());
            ps.setInt(4, order.getPayment_id());
            ps.setInt(5, order.getId());
            if (ps.executeUpdate() >= 1) return true;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return false;
    }

    @Override
    public boolean delete(int id) {
        String sql = "delete from orders where id = ?";
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
    public List<Orders> findByUserId(int user_id) {
        String sql = "select * from orders where user_id = ?";
        List<Orders> orders = new ArrayList<>();
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, user_id);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Orders order = OrdersMapper.map(rs);
                    orders.add(order);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return orders;
    }

    @Override
    public List<Orders> findByStatus(String status, int user_id) {
        String sql = "select * from orders where user_id = ? and status = ?";
        List<Orders> orders = new ArrayList<>();
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, user_id);
            ps.setString(2, status);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Orders order = OrdersMapper.map(rs);
                    orders.add(order);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return orders;
    }
}
