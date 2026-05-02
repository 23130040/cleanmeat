package cleanmeat.cleanmeat.utils;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import java.sql.Connection;

public class DBUtil {

    public static Connection getConnection() {
        try {
            Context ctx = new InitialContext();
            DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/MyDB");
            return ds.getConnection();
        } catch (Exception e) {
            throw new RuntimeException("DB connection failed", e);
        }
    }
}