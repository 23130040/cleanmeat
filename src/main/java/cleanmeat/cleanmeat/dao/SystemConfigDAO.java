package cleanmeat.cleanmeat.dao;

import cleanmeat.cleanmeat.model.SystemConfig;

public interface SystemConfigDAO {
    SystemConfig getConfig();
    boolean updateConfig(SystemConfig config);
}
