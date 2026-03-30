package cleanmeat.cleanmeat.service;

import cleanmeat.cleanmeat.dao.OrdersItemDAO;
import cleanmeat.cleanmeat.dao.OrdersItemDAOImpl;
import cleanmeat.cleanmeat.model.OrdersItem;

import java.util.List;

public class OrderItemService {
    private OrdersItemDAO ordersItemDAO = new OrdersItemDAOImpl();

    public List<OrdersItem> findByOrderId(int order_id) {
        return ordersItemDAO.findByOrdersId(order_id);
    }

}
