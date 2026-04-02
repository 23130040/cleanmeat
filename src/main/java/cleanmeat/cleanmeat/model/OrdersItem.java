package cleanmeat.cleanmeat.model;

import java.io.Serializable;
import java.time.LocalDateTime;

public class OrdersItem implements Serializable {
    private int order_id;
    private int item_id;
    private double price;
    private int weight;
    private double quantity;
    private LocalDateTime created_at;
    
    private String itemName;
    private String itemImage;
    private String unitName;

    public OrdersItem() {}

    public OrdersItem(int order_id, int item_id, double price, int weight, double quantity, LocalDateTime created_at) {
        this.order_id = order_id;
        this.item_id = item_id;
        this.price = price;
        this.weight = weight;
        this.quantity = quantity;
        this.created_at = created_at;
    }

    public int getWeight() {
        return weight;
    }

    public void setWeight(int weight) {
        this.weight = weight;
    }

    public int getOrder_id() {
        return order_id;
    }

    public void setOrder_id(int order_id) {
        this.order_id = order_id;
    }

    public int getItem_id() {
        return item_id;
    }

    public void setItem_id(int item_id) {
        this.item_id = item_id;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public double getQuantity() {
        return quantity;
    }

    public void setQuantity(double quantity) {
        this.quantity = quantity;
    }

    public LocalDateTime getCreated_at() {
        return created_at;
    }

    public void setCreated_at(LocalDateTime created_at) {
        this.created_at = created_at;
    }

    public String getItemName() { return itemName; }
    public void setItemName(String itemName) { this.itemName = itemName; }

    public String getItemImage() { return itemImage; }
    public void setItemImage(String itemImage) { this.itemImage = itemImage; }

    public String getUnitName() { return unitName; }
    public void setUnitName(String unitName) { this.unitName = unitName; }
}
