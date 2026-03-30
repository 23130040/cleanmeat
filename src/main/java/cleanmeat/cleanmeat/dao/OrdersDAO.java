package cleanmeat.cleanmeat.dao;

import cleanmeat.cleanmeat.model.Orders;

import java.util.List;

public interface OrdersDAO {

    public Orders findById(int id);

    public List<Orders> findAll();

    public List<Orders> findAll(int limit, int offset);

    public int countAll();

    public int countByStatus(String status);

    public boolean insert(Orders order);

    public boolean update(Orders order);

    public boolean delete(int id);

    public List<Orders> findByUserId(int user_id);

    public List<Orders> findByStatus(String status, int user_id);

}
