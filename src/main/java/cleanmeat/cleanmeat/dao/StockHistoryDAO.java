package cleanmeat.cleanmeat.dao;

import cleanmeat.cleanmeat.model.StockHistory;

import java.util.List;

public interface StockHistoryDAO {

    public boolean insert(StockHistory history);

    public List<StockHistory> findByItemId(int itemId);

    public List<StockHistory> findByType(String type);

    public List<StockHistory> findAll();

    public List<StockHistory> findAll(int limit, int offset);

    public int countAll();

    public int sumQuantityByType(String type);

    public boolean delete(int id);

    public boolean deleteAll();

}
