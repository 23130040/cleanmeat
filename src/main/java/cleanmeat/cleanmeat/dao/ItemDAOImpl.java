package cleanmeat.cleanmeat.dao;

import cleanmeat.cleanmeat.mapper.ItemMapper;
import cleanmeat.cleanmeat.model.Item;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ItemDAOImpl extends BaseDAO implements ItemDAO {

    @Override
    public Item findById(int id) {
        String sql = """
                    SELECT i.*,
                           c.name AS category_name,
                           u.name AS unit_name,
                           o.name AS origin_name,
                           img.url AS image
                    FROM item i
                    LEFT JOIN category c ON i.category_id = c.id
                    LEFT JOIN unit u ON i.unit_id = u.id
                    LEFT JOIN origin o ON i.origin_id = o.id
                    LEFT JOIN item_image img
                        ON i.id = img.item_id AND img.is_primary = 1
                    WHERE i.id = ?
                """;

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next())
                    return ItemMapper.map(rs);
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
                """;
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
    public List<Item> findAll(int limit, int offset) {
        return findAll(limit, offset, 0, null);
    }

    @Override
    public List<Item> findAll(int limit, int offset, int categoryId) {
        return findAll(limit, offset, categoryId, null);
    }

    @Override
    public List<Item> findAll(int limit, int offset, int categoryId, String keyword) {
        StringBuilder sql = new StringBuilder("""
                SELECT i.*,
                       c.name AS category_name,
                       u.name AS unit_name,
                       o.name AS origin_name,
                       img.url AS image
                FROM item i
                LEFT JOIN category c ON i.category_id = c.id
                LEFT JOIN unit u ON i.unit_id = u.id
                LEFT JOIN origin o ON i.origin_id = o.id
                LEFT JOIN item_image img
                    ON i.id = img.item_id AND img.is_primary = 1
                WHERE 1=1
                """);
        
        if (categoryId > 0) {
            sql.append(" AND i.category_id = ? ");
        }
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND i.name LIKE ? ");
        }
        
        sql.append(" ORDER BY i.id DESC LIMIT ? OFFSET ?");
        
        List<Item> items = new ArrayList<>();
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            
            int paramIndex = 1;
            if (categoryId > 0) {
                ps.setInt(paramIndex++, categoryId);
            }
            if (keyword != null && !keyword.trim().isEmpty()) {
                ps.setString(paramIndex++, "%" + keyword.trim() + "%");
            }
            ps.setInt(paramIndex++, limit);
            ps.setInt(paramIndex, offset);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Item item = ItemMapper.map(rs);
                    items.add(item);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return items;
    }

    @Override
    public int countAll() {
        return countAll(0, null);
    }

    @Override
    public int countAll(int categoryId) {
        return countAll(categoryId, null);
    }

    @Override
    public int countAll(int categoryId, String keyword) {
        String sql = "SELECT COUNT(*) FROM item WHERE 1=1";
        if (categoryId > 0) {
            sql += " AND category_id = ?";
        }
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql += " AND name LIKE ?";
        }
        
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            int index = 1;
            if (categoryId > 0) {
                ps.setInt(index++, categoryId);
            }
            if (keyword != null && !keyword.trim().isEmpty()) {
                ps.setString(index++, "%" + keyword.trim() + "%");
            }
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next())
                    return rs.getInt(1);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return 0;
    }

    @Override
    public int insert(Item item) {
        String sql = """
                insert into item
                (name, short_description, long_description, category_id, origin_id, unit_id, price, discount, current_stock, min_stock, packaging)
                values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
                """;
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
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
            ps.setString(11, item.getPackaging());
            
            if (ps.executeUpdate() >= 1) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        return rs.getInt(1);
                    }
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return 0;
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
            if (ps.executeUpdate() >= 1)
                return true;
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
            if (ps.executeUpdate() >= 1)
                return true;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return false;
    }

    @Override
    public int countItems() {
        String sql = "SELECT COUNT(*) FROM item";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return 0;
    }

    @Override
    public int countLowStockItems() {
        String sql = "SELECT COUNT(*) FROM item WHERE current_stock <= min_stock";
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
    public List<Item> getTopSellingItems(int limit) {
        String sql = """
            SELECT i.*, 
                   c.name AS category_name,
                   u.name AS unit_name,
                   o_ref.name AS origin_name,
                   img.url AS image,
                   SUM(oi.quantity) AS total_sold
            FROM item i
            JOIN orders_item oi ON i.id = oi.item_id
            JOIN orders o ON oi.order_id = o.id
            LEFT JOIN category c ON i.category_id = c.id
            LEFT JOIN unit u ON i.unit_id = u.id
            LEFT JOIN origin o_ref ON i.origin_id = o_ref.id
            LEFT JOIN item_image img ON i.id = img.item_id AND img.is_primary = 1
            WHERE o.status = 'Hoàn thành'
            GROUP BY i.id
            ORDER BY total_sold DESC
            LIMIT ?
        """;
        List<Item> items = new ArrayList<>();
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, limit);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Item item = ItemMapper.map(rs);
                    items.add(item);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return items;
    }

    @Override
    public List<Item> getItemsByPage(int page, int pageSize, String category, String price, String sort) {

        StringBuilder sql = new StringBuilder("""
                    SELECT i.*,
                           c.name AS category_name,
                           u.name AS unit_name,
                           img.url AS image
                    FROM item i
                    JOIN (
                        SELECT MIN(id) as id
                        FROM item
                        GROUP BY name
                    ) t ON i.id = t.id
                    LEFT JOIN unit u ON i.unit_id = u.id
                    LEFT JOIN category c ON i.category_id = c.id
                    LEFT JOIN item_image img 
                        ON i.id = img.item_id AND img.is_primary = 1
                    WHERE 1=1
                """);

        if (category != null && !category.isEmpty()) {
            sql.append(" AND c.id = ?");
        }

        if ("1".equals(price)) {
            sql.append(" AND i.price < 200000");
        } else if ("2".equals(price)) {
            sql.append(" AND i.price BETWEEN 200000 AND 500000");
        } else if ("3".equals(price)) {
            sql.append(" AND i.price > 500000");
        }

        if ("asc".equals(sort)) {
            sql.append(" ORDER BY i.price ASC");
        } else if ("desc".equals(sort)) {
            sql.append(" ORDER BY i.price DESC");
        } else {
            sql.append(" ORDER BY i.created_at DESC");
        }

        sql.append(" LIMIT ? OFFSET ?");

        List<Item> items = new ArrayList<>();

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            int index = 1;

            if (category != null && !category.isEmpty()) {
                ps.setInt(index++, Integer.parseInt(category));
            }

            ps.setInt(index++, pageSize);
            ps.setInt(index, (page - 1) * pageSize);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                items.add(ItemMapper.map(rs));
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return items;
    }

    @Override
    public List<Item> findBestSellers(int limit) {
        String sql = """
                    SELECT i.*,
                           c.name AS category_name,
                           u.name AS unit_name,
                           o.name AS origin_name,
                           img.url AS image
                    FROM item i
                    LEFT JOIN category c ON i.category_id = c.id
                    LEFT JOIN unit u ON i.unit_id = u.id
                    LEFT JOIN origin o ON i.origin_id = o.id
                    LEFT JOIN item_image img
                        ON i.id = img.item_id AND img.is_primary = 1
                    ORDER BY i.current_stock DESC
                    LIMIT ?
                """;
        List<Item> items = new ArrayList<>();
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, limit);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    items.add(ItemMapper.map(rs));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return items;
    }
}
