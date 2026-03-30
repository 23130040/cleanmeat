package cleanmeat.cleanmeat.service;

import cleanmeat.cleanmeat.dao.UnitDAO;
import cleanmeat.cleanmeat.dao.UnitDAOImpl;

public class UnitService {
    private UnitDAO unitDAO = new UnitDAOImpl();

    public String getPackage(int unit_id) {
        return unitDAO.getPackage(unit_id);
    }
}
