package cleanmeat.cleanmeat.model;

import java.io.Serializable;

public class CartItem implements Serializable {
    private int itemId;
    private String productName;
    private double price;
    private String unit;
    private String productImage;
    private int quantity;

    public CartItem() {}

    public CartItem(int itemId, String productName, double price, String unit, String productImage, int quantity) {
        this.itemId = itemId;
        this.productName = productName;
        this.price = price;
        this.unit = unit;
        this.productImage = productImage;
        this.quantity = quantity;
    }

    public int getItemId() { return itemId; }
    public void setItemId(int itemId) { this.itemId = itemId; }

    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public String getUnit() { return unit; }
    public void setUnit(String unit) { this.unit = unit; }

    public String getProductImage() { return productImage; }
    public void setProductImage(String productImage) { this.productImage = productImage; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
}
