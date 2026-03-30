package cleanmeat.cleanmeat.service;

import cleanmeat.cleanmeat.dao.ItemDAO;
import cleanmeat.cleanmeat.dao.ItemDAOImpl;
import cleanmeat.cleanmeat.model.Item;

public class ItemService {
    private ItemDAO itemDAO = new ItemDAOImpl();

    public Item findById(int id) {
        return itemDAO.findById(id);
    }

}
