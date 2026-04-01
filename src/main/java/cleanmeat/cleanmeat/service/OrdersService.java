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
