package cleanmeat.cleanmeat.dao;

import cleanmeat.cleanmeat.model.Item;

import java.util.List;

public interface ItemDAO {
    public Item findById(int id);

    public List<Item> findAll();

    public boolean insert(Item item);

    public boolean update(Item item);

    public boolean delete(int id);
}
