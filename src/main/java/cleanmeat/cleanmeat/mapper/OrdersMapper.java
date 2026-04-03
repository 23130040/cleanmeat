package cleanmeat.cleanmeat.mapper;

import cleanmeat.cleanmeat.model.Orders;

import java.sql.ResultSet;
import java.sql.SQLException;

public class OrdersMapper {
    public static Orders map(ResultSet rs) throws SQLException {
        Orders orders = new Orders();
        orders.setId(rs.getInt("id"));
        orders.setUser_id(rs.getInt("user_id"));
        orders.setTotal_price(rs.getDouble("total_price"));
        orders.setStatus(rs.getString("status"));
        java.sql.Timestamp createdAtTs = rs.getTimestamp("created_at");
        orders.setCreated_at(createdAtTs != null ? createdAtTs.toLocalDateTime() : null);
        java.sql.Timestamp updatedAtTs = rs.getTimestamp("updated_at");
        orders.setUpdated_at(updatedAtTs != null ? updatedAtTs.toLocalDateTime() : null);
        orders.setAddress_id(rs.getInt("address_id"));
        orders.setTransport_id(rs.getInt("transport_id"));
        orders.setPayment_id(rs.getInt("payment_id"));
        
        try { orders.setUser_name(rs.getString("user_name")); } catch (SQLException ignored) {}
        try { orders.setUser_email(rs.getString("user_email")); } catch (SQLException ignored) {}
        try { orders.setPayment_method(rs.getString("payment_method")); } catch (SQLException ignored) {}
        try { orders.setTransport_method(rs.getString("transport_method")); } catch (SQLException ignored) {}
        
        return orders;
    }
}
