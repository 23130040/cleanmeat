package cleanmeat.cleanmeat.mapper;

import cleanmeat.cleanmeat.model.Item;

import java.sql.ResultSet;
import java.sql.SQLException;

public class ItemMapper {
    public static Item map(ResultSet rs) throws SQLException {
        Item item = new Item();
        item.setId(rs.getInt("id"));
        item.setName(rs.getString("name"));
        item.setShort_description(rs.getString("short_description"));
        item.setLong_description(rs.getString("long_description"));
        item.setCategory_id(rs.getInt("category_id"));
        item.setOrigin_id(rs.getInt("origin_id"));
        item.setUnit_id(rs.getInt("unit_id"));
        item.setPrice(rs.getDouble("price"));
        item.setDiscount(rs.getDouble("discount"));
        item.setCurrent_stock(rs.getInt("current_stock"));
        item.setMin_stock(rs.getInt("min_stock"));
        item.setCreated_at(rs.getTimestamp("created_at").toLocalDateTime());
        item.setUpdated_at(rs.getTimestamp("updated_at").toLocalDateTime());
        return item;
    }
}
