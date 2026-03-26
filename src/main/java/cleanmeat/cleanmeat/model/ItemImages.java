package cleanmeat.cleanmeat.model;

import java.io.Serializable;
import java.time.LocalDateTime;

public class ItemImages implements Serializable {
    private int id;
    private int item_id;
    private String url;
    private boolean is_primary;
    private LocalDateTime created_at;

    public ItemImages() {}

    public ItemImages(int id, int item_id, String url, boolean is_primary, LocalDateTime created_at) {
        this.id = id;
        this.item_id = item_id;
        this.url = url;
        this.is_primary = is_primary;
        this.created_at = created_at;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getItem_id() {
        return item_id;
    }

    public void setItem_id(int item_id) {
        this.item_id = item_id;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public boolean isIs_primary() {
        return is_primary;
    }

    public void setIs_primary(boolean is_primary) {
        this.is_primary = is_primary;
    }

    public LocalDateTime getCreated_at() {
        return created_at;
    }

    public void setCreated_at(LocalDateTime created_at) {
        this.created_at = created_at;
    }
}
