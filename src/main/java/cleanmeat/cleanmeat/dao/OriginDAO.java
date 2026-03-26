package cleanmeat.cleanmeat.dao;

import cleanmeat.cleanmeat.model.Origin;

import java.util.List;

public interface OriginDAO {
    public Origin findById(int id);

    public List<Origin> findAll();

    public boolean insert(Origin origin);

    public boolean update(Origin origin);

    public boolean delete(int id);

}
