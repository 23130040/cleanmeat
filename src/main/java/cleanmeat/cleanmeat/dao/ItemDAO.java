package cleanmeat.cleanmeat.dao;

import cleanmeat.cleanmeat.model.Item;

import java.util.List;

public interface ItemDAO {
    public Item findById(int id);

    public List<Item> findAll();

    public int countAll();

    public int countAll(int categoryId);

    public int countAll(int categoryId, String keyword);

    public List<Item> findAll(int limit, int offset);

    public List<Item> findAll(int limit, int offset, int categoryId);

    public List<Item> findAll(int limit, int offset, int categoryId, String keyword);

    public int insert(Item item);

    public boolean update(Item item);

    public boolean delete(int id);

    public int countItems();

    public int countLowStockItems();

    public List<Item> getTopSellingItems(int limit);

    public List<Item> getItemsByPage(int page, int pageSize, String category, String price, String sort);

    public List<Item> findBestSellers(int limit);
}
