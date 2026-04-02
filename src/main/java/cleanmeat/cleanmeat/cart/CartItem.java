package cleanmeat.cleanmeat.cart;

import cleanmeat.cleanmeat.model.Item;

import java.io.Serializable;

public class CartItem implements Serializable {
    private int id;
    private Item item;
    private int quantity;
    private int weight;
    public CartItem() {
    }

    public CartItem(int id, Item item, int quantity) {
        this(id, item, quantity, 250); // Default weight: 250g
    }

    public CartItem(int id, Item item, int quantity, int weight) {
        this.id = id;
        this.item = item;
        this.quantity = quantity;
        this.weight = weight;
    }

    public void quantityUp() {
        this.quantity++;
    }

    public void quantityDown() {
        if (this.quantity > 1) {
            this.quantity--;
        }
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Item getItem() {
        return item;
    }

    public void setItem(Item item) {
        this.item = item;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        if (quantity < 1) quantity = 1;
        this.quantity = quantity;
    }

    public int getWeight() {
        return weight;
    }

    public void setWeight(int weight) {
        this.weight = weight;
    }

    public double getUnitPrice() {
        return this.item.getPrice() * (this.weight / 250.0);
    }

    public double getOriginalPrice() {
        return (this.item.getPrice() + this.item.getDiscount()) * (this.weight / 250.0);
    }

    public double getSubTotal() {
        return this.quantity * getUnitPrice();
    }
}
