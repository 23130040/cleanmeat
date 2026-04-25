package cleanmeat.cleanmeat.mapper;

import cleanmeat.cleanmeat.model.OrdersStatusHistory;
import java.sql.ResultSet;
import java.sql.SQLException;

public class OrdersStatusHistoryMapper {
    public static OrdersStatusHistory map(ResultSet rs) throws SQLException {
        OrdersStatusHistory history = new OrdersStatusHistory();
        history.setId(rs.getInt("id"));
        history.setOrder_id(rs.getInt("order_id"));
        history.setStatus_from(rs.getString("status_from"));
        history.setStatus_to(rs.getString("status_to"));
        history.setChanged_by(rs.getString("changed_by"));
        java.sql.Timestamp changedAtTs = rs.getTimestamp("changed_at");
        history.setChanged_at(changedAtTs != null ? changedAtTs.toLocalDateTime() : null);
        history.setNote(rs.getString("note"));
        return history;
    }
}
