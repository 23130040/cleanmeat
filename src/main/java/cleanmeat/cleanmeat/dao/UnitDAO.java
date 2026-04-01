package cleanmeat.cleanmeat.dao;

import cleanmeat.cleanmeat.model.Unit;

import java.util.List;

public interface UnitDAO {
    public Unit findById(int id);

    public List<Unit> findAll();

    public Unit findByName(String name);

    public int insert(Unit unit);

    public boolean update(Unit unit);

    public boolean delete(int id);

    public String getPackage(int unitId);
}
