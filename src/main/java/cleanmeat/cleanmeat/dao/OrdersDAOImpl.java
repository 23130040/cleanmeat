package cleanmeat.cleanmeat.dao;

import cleanmeat.cleanmeat.mapper.CategoryMapper;
import cleanmeat.cleanmeat.mapper.OrdersMapper;
import cleanmeat.cleanmeat.model.Category;
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
        String sql = "select * from orders where id = ?";
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
    public boolean insert(Orders order) {
        String sql = """
                insert into orders (user_id, total_price, status, address_id, transport_id, payment_id) 
                values (?, ?, ?, ?, ?, ?)
                """;
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, order.getUser_id());
            ps.setDouble(2, order.getTotal_price());
            ps.setString(3, order.getStatus());
            ps.setInt(4, order.getAddress_id());
            ps.setInt(5, order.getTransport_id());
            ps.setInt(6, order.getPayment_id());
            if (ps.executeUpdate() >= 1) return true;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return false;
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
}
