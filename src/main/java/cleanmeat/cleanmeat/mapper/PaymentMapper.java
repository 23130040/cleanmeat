package cleanmeat.cleanmeat.mapper;

import cleanmeat.cleanmeat.model.Payment;

import java.sql.ResultSet;
import java.sql.SQLException;

public class PaymentMapper {
    public static Payment map(ResultSet rs) throws SQLException {
        Payment payment = new Payment();
        payment.setId(rs.getInt("id"));
        payment.setName(rs.getString("name"));
        payment.setStatus(rs.getBoolean("status"));
        payment.setCreated_at(rs.getTimestamp("created_day").toLocalDateTime());
        payment.setUpdated_at(rs.getTimestamp("updated_day").toLocalDateTime());
        return payment;
    }
}
