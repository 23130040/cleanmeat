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

    public Orders getOrderDetail(int orderId) {
        Orders order = ordersDAO.findById(orderId);
        if (order != null) {
            cleanmeat.cleanmeat.dao.OrdersItemDAO ordersItemDAO = new cleanmeat.cleanmeat.dao.OrdersItemDAOImpl();
            order.setItems(ordersItemDAO.findByOrdersId(orderId));
            
            cleanmeat.cleanmeat.dao.AddressDAO addressDAO = new cleanmeat.cleanmeat.dao.AddressDAOImpl();
            order.setAddress(addressDAO.findById(order.getAddress_id()));
        }
        return order;
    }

    public List<Orders> getOrdersDetailedByUserId(int userId) {
        List<Orders> orders = ordersDAO.findByUserId(userId);
        cleanmeat.cleanmeat.dao.OrdersItemDAO ordersItemDAO = new cleanmeat.cleanmeat.dao.OrdersItemDAOImpl();
        for (Orders order : orders) {
            order.setItems(ordersItemDAO.findByOrdersId(order.getId()));
        }
        return orders;
    }

    public List<Orders> findByStatus(String status, int user_id) {
        return ordersDAO.findByStatus(status, user_id);
    }

    public List<Orders> getOrdersByPage(int limit, int offset) {
        return ordersDAO.findAll(limit, offset);
    }

    public int countAllOrders() {
        return ordersDAO.countAll();
    }

    public int countOrdersByStatus(String status) {
        return ordersDAO.countByStatus(status);
    }

    public double sumTotalRevenue() {
        return ordersDAO.sumTotalRevenue();
    }

    public int countTodayOrders() {
        return ordersDAO.countTodayOrders();
    }

    public double sumTodayRevenue() {
        return ordersDAO.sumTodayRevenue();
    }

    public double calculateOrderGrowth() {
        return ordersDAO.calculateOrderGrowth();
    }

    public double calculateRevenueGrowth() {
        return ordersDAO.calculateRevenueGrowth();
    }
}
