package cleanmeat.cleanmeat.dao;

import cleanmeat.cleanmeat.model.SystemConfig;

public interface SystemConfigDAO {
    public SystemConfig get();

    public boolean update(SystemConfig config);

    public boolean insert(SystemConfig config);
}
