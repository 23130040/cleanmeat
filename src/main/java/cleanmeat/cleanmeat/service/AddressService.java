package cleanmeat.cleanmeat.service;

import cleanmeat.cleanmeat.dao.AddressDAO;
import cleanmeat.cleanmeat.dao.AddressDAOImpl;
import cleanmeat.cleanmeat.model.Address;

import java.util.List;

public class AddressService {
    private AddressDAO addressDAO = new AddressDAOImpl();

    public List<Address> getAddressesByUserId(int userId) {
        return addressDAO.findByUserId(userId);
    }

    public boolean addAddress(int user_id, String addressStr, boolean isDefault) {
        Address address = new Address();
        address.setUser_id(user_id);
        address.setAddress(addressStr);
        address.setIs_Default(isDefault);
        return addressDAO.insert(address) > 0;
    }

    public boolean setDefaultAddress(int userId, int addressId) {
        return addressDAO.setDefault(userId, addressId);
    }

    public boolean deleteAddress(int id) {
        Address address = addressDAO.findById(id);
        if (address != null && !address.isIs_Default()) {
            return addressDAO.delete(id);
        }
        return false;
    }
}
