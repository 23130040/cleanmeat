package cleanmeat.cleanmeat.mapper;

import cleanmeat.cleanmeat.model.Category;

import java.sql.ResultSet;
import java.sql.SQLException;

public class CategoryMapper {
    public static Category map(ResultSet rs) throws SQLException {
        Category category = new Category();
        category.setId(rs.getInt("id"));
        category.setName(rs.getString("name"));
        category.setDescription(rs.getString("description"));
        category.setCreated_at(rs.getTimestamp("created_at").toLocalDateTime());
        category.setUpdated_at(rs.getTimestamp("updated_at").toLocalDateTime());
        return category;
    }
}
