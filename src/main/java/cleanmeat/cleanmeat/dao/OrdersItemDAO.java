package cleanmeat.cleanmeat.dao;

import cleanmeat.cleanmeat.model.OrdersItem;

import java.util.List;

public interface OrdersItemDAO {

    public List<OrdersItem> findByOrdersId(int orders_id);

    public boolean insert(OrdersItem orderItem);

}
