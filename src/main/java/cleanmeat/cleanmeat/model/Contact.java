package cleanmeat.cleanmeat.model;

import java.io.Serializable;
import java.time.LocalDateTime;

public class Contact implements Serializable {
    private int id;
    private String full_name;
    private String email;
    private String subject;
    private String message;
    private String status;
    private LocalDateTime created_at;
    private LocalDateTime updated_at;
    private Integer handled_by;

    public Contact() {
    }

    public Contact(int id, String full_name, String email, String subject, String message, String status, LocalDateTime created_at, LocalDateTime updated_at, Integer handled_by) {
        this.id = id;
        this.full_name = full_name;
        this.email = email;
        this.subject = subject;
        this.message = message;
        this.status = status;
        this.created_at = created_at;
        this.updated_at = updated_at;
        this.handled_by = handled_by;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFull_name() {
        return full_name;
    }

    public void setFull_name(String full_name) {
        this.full_name = full_name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public LocalDateTime getCreated_at() {
        return created_at;
    }

    public void setCreated_at(LocalDateTime created_at) {
        this.created_at = created_at;
    }

    public LocalDateTime getUpdated_at() {
        return updated_at;
    }

    public void setUpdated_at(LocalDateTime updated_at) {
        this.updated_at = updated_at;
    }

    public Integer getHandled_by() {
        return handled_by;
    }

    public void setHandled_by(Integer handled_by) {
        this.handled_by = handled_by;
    }
}
