package cleanmeat.cleanmeat.mapper;

import cleanmeat.cleanmeat.model.OrdersItem;

import java.sql.ResultSet;
import java.sql.SQLException;

public class OrdersItemMapper {
    public static OrdersItem map(ResultSet rs) throws SQLException {
        OrdersItem ordersItem = new OrdersItem();
        ordersItem.setOrder_id(rs.getInt("order_id"));
        ordersItem.setItem_id(rs.getInt("item_id"));
        ordersItem.setPrice(rs.getDouble("price"));
        ordersItem.setWeight(rs.getInt("weight"));
        ordersItem.setQuantity(rs.getDouble("quantity"));
        ordersItem.setCreated_at(rs.getTimestamp("created_at").toLocalDateTime());
        return ordersItem;
    }
}
