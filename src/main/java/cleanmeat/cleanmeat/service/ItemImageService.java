package cleanmeat.cleanmeat.service;

import cleanmeat.cleanmeat.dao.ItemImagesDAO;
import cleanmeat.cleanmeat.dao.ItemImagesDAOImpl;

public class ItemImageService {
    private ItemImagesDAO itemImagesDAO = new ItemImagesDAOImpl();

    public String getPrimaryImageUrl(int item_id) {
        return itemImagesDAO.getPrimaryImageUrl(item_id);
    }
}
