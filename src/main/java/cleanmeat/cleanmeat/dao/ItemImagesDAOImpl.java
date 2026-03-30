package cleanmeat.cleanmeat.dao;

import cleanmeat.cleanmeat.mapper.AddressMapper;
import cleanmeat.cleanmeat.mapper.CategoryMapper;
import cleanmeat.cleanmeat.mapper.ItemImagesMapper;
import cleanmeat.cleanmeat.model.Address;
import cleanmeat.cleanmeat.model.ItemImages;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ItemImagesDAOImpl extends BaseDAO implements ItemImagesDAO {
    @Override
    public ItemImages findById(int id) {
        String sql = "select * from item_image where id = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return ItemImagesMapper.map(rs);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return null;
    }

    @Override
    public List<ItemImages> findByItemId(int item_id) {
        List<ItemImages> list = new ArrayList<>();
        String sql = """
                select * from item_image where item_id = ?
                """;
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, item_id);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ItemImages itemImages = ItemImagesMapper.map(rs);
                    list.add(itemImages);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return list;
    }

    @Override
    public boolean insert(ItemImages image) {
        String sql = """
                insert into item_image (item_id, url, is_primary) values (?, ?, ?)
                """;
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, image.getItem_id());
            ps.setString(2, image.getUrl());
            ps.setBoolean(3, image.isIs_primary());
            if (ps.executeUpdate() >= 1) return true;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return false;
    }

    @Override
    public boolean delete(int id) {
        String sql = "delete from item_image where id = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            if (ps.executeUpdate() >= 1) return true;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return false;
    }

    @Override
    public String getPrimaryImageUrl(int item_id) {
        String sql = "select * from item_image where item_id = ? and is_primary = 1";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, item_id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return ItemImagesMapper.map(rs).getUrl();
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return null;
    }
}
