package cleanmeat.cleanmeat.dao;

import cleanmeat.cleanmeat.mapper.AddressMapper;
import cleanmeat.cleanmeat.mapper.CategoryMapper;
import cleanmeat.cleanmeat.mapper.OrdersItemMapper;
import cleanmeat.cleanmeat.model.Address;
import cleanmeat.cleanmeat.model.Category;
import cleanmeat.cleanmeat.model.OrdersItem;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class OrdersItemDAOImpl extends BaseDAO implements OrdersItemDAO {

    @Override
    public List<OrdersItem> findByOrdersId(int orders_id) {
        List<OrdersItem> list = new ArrayList<>();
        String sql = """
                select * from orders_item where order_id = ?
                """;
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orders_id);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    OrdersItem oi = OrdersItemMapper.map(rs);
                    list.add(oi);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return list;
    }

    @Override
    public boolean insert(OrdersItem orderItem) {
        String sql = """
                insert into orders_item (order_id, item_id, price, quantity)
                """;
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderItem.getOrder_id());
            ps.setInt(2, orderItem.getItem_id());
            ps.setDouble(3, orderItem.getPrice());
            ps.setDouble(4, orderItem.getQuantity());
            if (ps.executeUpdate() >= 1) return true;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return false;
    }

}
