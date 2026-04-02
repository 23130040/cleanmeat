package cleanmeat.cleanmeat.dao;

import cleanmeat.cleanmeat.model.Contact;
import java.util.List;

public interface ContactDAO {
    List<Contact> findAll();
    Contact findById(int id);
    boolean updateStatus(int id, String status, int adminId);
    boolean delete(int id);
}
