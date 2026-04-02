package cleanmeat.cleanmeat.dao;

import cleanmeat.cleanmeat.model.Transport;

import java.util.List;

public interface TransportDAO {
    Transport findById(int id);
    List<Transport> findAll();
    boolean insert(Transport transport);
    boolean update(Transport transport);
    boolean delete(int id);
    boolean updateStatus(int id, boolean status);
}
