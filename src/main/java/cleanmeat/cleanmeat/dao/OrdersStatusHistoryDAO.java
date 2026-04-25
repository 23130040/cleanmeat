package cleanmeat.cleanmeat.dao;

import cleanmeat.cleanmeat.model.OrdersStatusHistory;
import java.util.List;

public interface OrdersStatusHistoryDAO {
    void insert(OrdersStatusHistory history);
    List<OrdersStatusHistory> findByOrderId(int orderId);
}
