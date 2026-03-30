package cleanmeat.cleanmeat.dao;

import cleanmeat.cleanmeat.model.ItemImages;

import java.util.List;

public interface ItemImagesDAO {
    public ItemImages findById(int id);

    public List<ItemImages> findByItemId(int item_id);

    public boolean insert(ItemImages image);

    public boolean delete(int id);

    public String getPrimaryImageUrl(int item_id);
}

