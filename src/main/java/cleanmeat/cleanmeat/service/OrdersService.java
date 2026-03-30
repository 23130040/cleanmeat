package cleanmeat.cleanmeat.service;

import cleanmeat.cleanmeat.dao.OrdersDAO;
import cleanmeat.cleanmeat.dao.OrdersDAOImpl;
import cleanmeat.cleanmeat.model.Orders;

import java.util.List;

public class OrdersService {
    private OrdersDAO ordersDAO = new OrdersDAOImpl();

    public List<Orders> findAll() {
        return ordersDAO.findAll();
    }

    public Orders findById(int id) {
        return ordersDAO.findById(id);
    }

    public List<Orders> findByUserId(int user_id) {
        return ordersDAO.findByUserId(user_id);
    }

    public List<Orders> findByStatus(String status, int user_id) {
        return ordersDAO.findByStatus(status, user_id);
    }
}
