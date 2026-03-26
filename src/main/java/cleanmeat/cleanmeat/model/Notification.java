package cleanmeat.cleanmeat.model;

import java.io.Serializable;
import java.time.LocalDateTime;

public class Notification implements Serializable {
    private int id;
    private int user_id;
    private String content;
    private String email;
    private String url;
    private String type;
    private boolean is_read;
    private LocalDateTime created_at;

    public Notification() {}

    public Notification(int id, int user_id, String content, String email, String url, String type, boolean is_read, LocalDateTime created_at) {
        this.id = id;
        this.user_id = user_id;
        this.content = content;
        this.email = email;
        this.url = url;
        this.type = type;
        this.is_read = is_read;
        this.created_at = created_at;
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

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public boolean isIs_read() {
        return is_read;
    }

    public void setIs_read(boolean is_read) {
        this.is_read = is_read;
    }

    public LocalDateTime getCreated_at() {
        return created_at;
    }

    public void setCreated_at(LocalDateTime created_at) {
        this.created_at = created_at;
    }
}
