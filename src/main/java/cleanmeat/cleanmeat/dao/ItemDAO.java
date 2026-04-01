package cleanmeat.cleanmeat.dao;

import cleanmeat.cleanmeat.model.Item;

import java.util.List;

public interface ItemDAO {
    public Item findById(int id);

    public List<Item> findAll();

    public List<Item> findAll(int limit, int offset);

    public int countAll();

    public boolean insert(Item item);

    public boolean update(Item item);

    public boolean delete(int id);

    public int countItems();

    public List<Item> getItemsByPage(int page, int pageSize, String category, String price, String sort);

    public List<Item> findBestSellers(int limit);
}
