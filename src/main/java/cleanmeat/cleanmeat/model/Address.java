package cleanmeat.cleanmeat.model;

import java.io.Serializable;
import java.time.LocalDateTime;

public class Address implements Serializable {
    private int id;
    private int user_id;
    private String address;
    private boolean is_Default;
    private LocalDateTime created_at;
    private LocalDateTime updated_at;

    public Address() {
    }

    public Address(int id, int user_id, String address, boolean is_Default, LocalDateTime created_at, LocalDateTime updated_at) {
        this.id = id;
        this.user_id = user_id;
        this.address = address;
        this.is_Default = is_Default;
        this.created_at = created_at;
        this.updated_at = updated_at;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public boolean isIs_Default() {
        return is_Default;
    }

    public void setIs_Default(boolean is_Default) {
        this.is_Default = is_Default;
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
}
