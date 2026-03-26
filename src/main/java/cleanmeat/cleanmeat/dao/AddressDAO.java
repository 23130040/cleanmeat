package cleanmeat.cleanmeat.dao;

import cleanmeat.cleanmeat.model.Address;

import java.util.List;

public interface AddressDAO {
    public Address findById(int id);

    public List<Address> findByUserId(int user_id);

    public boolean insert(Address address);

    public boolean update(Address address);

    public boolean delete(int id);
}
