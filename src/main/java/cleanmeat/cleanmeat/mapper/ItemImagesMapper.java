package cleanmeat.cleanmeat.mapper;

import cleanmeat.cleanmeat.model.ItemImages;

import java.sql.ResultSet;
import java.sql.SQLException;

public class ItemImagesMapper {
    public static ItemImages map(ResultSet rs) throws SQLException {
        ItemImages itemImages = new ItemImages();
        itemImages.setId(rs.getInt("id"));
        itemImages.setItem_id(rs.getInt("item_id"));
        itemImages.setUrl(rs.getString("url"));
        itemImages.setIs_primary(rs.getBoolean("is_primary"));
        itemImages.setCreated_at(rs.getTimestamp("created_at").toLocalDateTime());
        return itemImages;
    }
}
