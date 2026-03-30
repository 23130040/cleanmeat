package cleanmeat.cleanmeat.model;

import java.io.Serializable;
import java.time.LocalDateTime;

public class StockHistory implements Serializable {
    private int id;
    private int item_id;
    private String type;
    private double quantity;
    private LocalDateTime created_day;
    private int created_by;

    private String item_name;
    private String user_name;

    public StockHistory() {}

    public StockHistory(int id, int item_id, String type, double quantity, LocalDateTime created_day, int created_by) {
        this.id = id;
        this.item_id = item_id;
        this.type = type;
        this.quantity = quantity;
        this.created_day = created_day;
        this.created_by = created_by;
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

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public double getQuantity() {
        return quantity;
    }

    public void setQuantity(double quantity) {
        this.quantity = quantity;
    }

    public LocalDateTime getCreated_day() {
        return created_day;
    }

    public void setCreated_day(LocalDateTime created_day) {
        this.created_day = created_day;
    }

    public int getCreated_by() {
        return created_by;
    }

    public void setCreated_by(int created_by) {
        this.created_by = created_by;
    }
    
    public String getItem_name() { return item_name; }
    
    public void setItem_name(String item_name) { this.item_name = item_name; }
    
    public String getUser_name() { return user_name; }
    
    public void setUser_name(String user_name) { this.user_name = user_name; }
}
