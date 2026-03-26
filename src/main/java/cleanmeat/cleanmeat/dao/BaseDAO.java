package cleanmeat.cleanmeat.dao;

import cleanmeat.cleanmeat.utils.DBUtil;

import java.sql.Connection;
import java.sql.SQLException;

public abstract class BaseDAO {
    protected Connection getConnection() throws SQLException {
        return DBUtil.getConnection();
    }
}
