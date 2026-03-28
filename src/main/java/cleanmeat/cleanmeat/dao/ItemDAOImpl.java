package cleanmeat.cleanmeat.dao;

import cleanmeat.cleanmeat.mapper.CategoryMapper;
import cleanmeat.cleanmeat.mapper.ItemMapper;
import cleanmeat.cleanmeat.model.Category;
import cleanmeat.cleanmeat.model.Item;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ItemDAOImpl extends BaseDAO implements ItemDAO {

    @Override
    public Item findById(int id) {
        String sql = "select * from item where id = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return ItemMapper.map(rs);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return null;
    }

    @Override
    public List<Item> findAll() {
        String sql = """
    SELECT i.*, 
           c.name AS category_name,
           u.name AS unit_name,
           img.url AS image
    FROM item i
    LEFT JOIN category c ON i.category_id = c.id
    LEFT JOIN unit u ON i.unit_id = u.id
    LEFT JOIN item_image img 
        ON i.id = img.item_id AND img.is_primary = 1
    """;;
        List<Item> items = new ArrayList<>();
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Item item = ItemMapper.map(rs);
                items.add(item);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return items;
    }

    @Override
    public boolean insert(Item item) {
        String sql = """
                insert into item 
                (name, short_description, long_description, category_id, origin_id, unit_id, price, discount, current_stock, min_stock) 
                values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?) 
                """;
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, item.getName());
            ps.setString(2, item.getShort_description());
            ps.setString(3, item.getLong_description());
            ps.setInt(4, item.getCategory_id());
            ps.setInt(5, item.getOrigin_id());
            ps.setInt(6, item.getUnit_id());
            ps.setDouble(7, item.getPrice());
            ps.setDouble(8, item.getDiscount());
            ps.setDouble(9, item.getCurrent_stock());
            ps.setDouble(10, item.getMin_stock());
            if (ps.executeUpdate() >= 1) return true;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return false;
    }

    @Override
    public boolean update(Item item) {
        String sql = """
                update item
                set name = ?, short_description = ?,
                    long_description = ?, category_id = ?,
                    origin_id = ?, unit_id = ?, price = ?, discount = ?,
                    current_stock = ?, min_stock = ?,
                    updated_at = NOW()
                where id = ?
                """;
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, item.getName());
            ps.setString(2, item.getShort_description());
            ps.setString(3, item.getLong_description());
            ps.setInt(4, item.getCategory_id());
            ps.setInt(5, item.getOrigin_id());
            ps.setInt(6, item.getUnit_id());
            ps.setDouble(7, item.getPrice());
            ps.setDouble(8, item.getDiscount());
            ps.setDouble(9, item.getCurrent_stock());
            ps.setDouble(10, item.getMin_stock());
            ps.setInt(11, item.getId());
            if (ps.executeUpdate() >= 1) return true;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return false;
    }

    @Override
    public boolean delete(int id) {
        String sql = "delete from item where id = ?";
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
