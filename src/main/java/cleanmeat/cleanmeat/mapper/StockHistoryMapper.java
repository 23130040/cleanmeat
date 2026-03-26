package cleanmeat.cleanmeat.mapper;

import cleanmeat.cleanmeat.model.StockHistory;

import java.sql.ResultSet;
import java.sql.SQLException;

public class StockHistoryMapper {
    public static StockHistory map(ResultSet rs) throws SQLException {
        StockHistory stockHistory = new StockHistory();
        stockHistory.setId(rs.getInt("id"));
        stockHistory.setItem_id(rs.getInt("item_id"));
        stockHistory.setType(rs.getString("type"));
        stockHistory.setQuantity(rs.getDouble("quantity"));
        stockHistory.setCreated_day(rs.getTimestamp("created_at").toLocalDateTime());
        stockHistory.setCreated_by(rs.getInt("created_by"));
        return stockHistory;
    }
}
