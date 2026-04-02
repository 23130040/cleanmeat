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
        
        java.sql.Timestamp createdDay = rs.getTimestamp("created_day");
        if (createdDay != null) {
            payment.setCreated_at(createdDay.toLocalDateTime());
        }
        
        java.sql.Timestamp updatedDay = rs.getTimestamp("updated_day");
        if (updatedDay != null) {
            payment.setUpdated_at(updatedDay.toLocalDateTime());
        }
        return payment;
    }
}
