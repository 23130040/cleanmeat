package cleanmeat.cleanmeat.mapper;

import cleanmeat.cleanmeat.model.Contact;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

public class ContactMapper {
    public static Contact map(ResultSet rs) throws SQLException {
        Contact contact = new Contact();
        contact.setId(rs.getInt("id"));
        contact.setFull_name(rs.getString("full_name"));
        contact.setEmail(rs.getString("email"));
        contact.setSubject(rs.getString("subject"));
        contact.setMessage(rs.getString("message"));
        contact.setStatus(rs.getString("status"));
        
        Timestamp created = rs.getTimestamp("created_at");
        if (created != null) contact.setCreated_at(created.toLocalDateTime());
        
        Timestamp updated = rs.getTimestamp("updated_at");
        if (updated != null) contact.setUpdated_at(updated.toLocalDateTime());
        
        int handled = rs.getInt("handled_by");
        if (!rs.wasNull()) contact.setHandled_by(handled);
        
        return contact;
    }
}
