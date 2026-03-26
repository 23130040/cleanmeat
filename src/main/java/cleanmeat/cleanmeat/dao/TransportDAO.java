package cleanmeat.cleanmeat.dao;

import cleanmeat.cleanmeat.model.Transport;

import java.util.List;

public interface TransportDAO {
    public Transport findById(int id);

    public List<Transport> findAll();

    public boolean insert(Transport transport);

    public boolean update(Transport transport);

    public boolean delete(int id);
}
