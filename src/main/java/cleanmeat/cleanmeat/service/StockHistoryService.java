package cleanmeat.cleanmeat.service;

import cleanmeat.cleanmeat.dao.StockHistoryDAO;
import cleanmeat.cleanmeat.dao.StockHistoryDAOImpl;
import cleanmeat.cleanmeat.model.StockHistory;

import java.util.List;

public class StockHistoryService {
    private StockHistoryDAO stockHistoryDAO = new StockHistoryDAOImpl();

    public List<StockHistory> getHistoryByPage(int limit, int offset) {
        return stockHistoryDAO.findAll(limit, offset);
    }

    public int countAllHistory() {
        return stockHistoryDAO.countAll();
    }

    public int getSumQuantityByType(String type) {
        return stockHistoryDAO.sumQuantityByType(type);
    }
}
