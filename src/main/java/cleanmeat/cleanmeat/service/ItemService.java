package cleanmeat.cleanmeat.service;

import cleanmeat.cleanmeat.dao.ItemDAO;
import cleanmeat.cleanmeat.dao.ItemDAOImpl;
import cleanmeat.cleanmeat.model.Item;
import java.util.List;

public class ItemService {
    private ItemDAO itemDAO = new ItemDAOImpl();

    public Item findById(int id) {
        return itemDAO.findById(id);
    }

    public List<Item> getAllItems() {
        return itemDAO.findAll();
    }

    public List<Item> getItemsByPage(int limit, int offset) {
        return itemDAO.findAll(limit, offset);
    }

    public int countAllItems() {
        return itemDAO.countAll();
    }

    public int countLowStockItems() {
        return itemDAO.countLowStockItems();
    }

    public List<Item> getTopSellingItems(int limit) {
        return itemDAO.getTopSellingItems(limit);
    }
}
