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
        if (rs.getTimestamp("created_at") != null) {
            item.setCreated_at(rs.getTimestamp("created_at").toLocalDateTime());
        }

        if (rs.getTimestamp("updated_at") != null) {
            item.setUpdated_at(rs.getTimestamp("updated_at").toLocalDateTime());
        }
        try {
            item.setCategory_name(rs.getString("category_name"));
        } catch (SQLException ignored) {}

        try {
            item.setUnit_name(rs.getString("unit_name"));
        } catch (SQLException ignored) {}

        try {
            item.setOrigin_name(rs.getString("origin_name"));
        } catch (SQLException ignored) {}

        try {
            item.setImage(rs.getString("image"));
        } catch (SQLException ignored) {}
<<<<<<< HEAD
        try {
            item.setOrigin_name(rs.getString("origin_name"));
        } catch (SQLException ignored) {}
        
        try {
            item.setTotal_sold(rs.getInt("total_sold"));
        } catch (SQLException ignored) {}
=======
>>>>>>> main

        return item;
    }
}
