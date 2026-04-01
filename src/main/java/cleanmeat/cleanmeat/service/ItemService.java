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

    public List<Item> getItemsByPage(int limit, int offset, int categoryId) {
        return itemDAO.findAll(limit, offset, categoryId);
    }

    public List<Item> getItemsByPage(int limit, int offset, int categoryId, String keyword) {
        return itemDAO.findAll(limit, offset, categoryId, keyword);
    }

    public int countAllItems() {
        return itemDAO.countAll();
    }

    public int countAllItems(int categoryId) {
        return itemDAO.countAll(categoryId);
    }

    public int countAllItems(int categoryId, String keyword) {
        return itemDAO.countAll(categoryId, keyword);
    }

    public int countLowStockItems() {
        return itemDAO.countLowStockItems();
    }

    public List<Item> getTopSellingItems(int limit) {
        return itemDAO.getTopSellingItems(limit);
    }

    public int insert(Item item) {
        return itemDAO.insert(item);
    }

    public boolean delete(int id) {
        return itemDAO.delete(id);
    }

    public boolean update(Item item) {
        return itemDAO.update(item);
    }
}
