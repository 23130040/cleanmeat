package cleanmeat.cleanmeat.model;

import java.io.Serializable;
import java.time.LocalDateTime;

public class Product implements Serializable{
    private int id;
    private String name;
    private String category;
    private String description;
    private double price;
    private double discount;
    private String image;
    private String unit;

    public Product(int id, String name, String category, String description,
                   double price, double discount, String image, String unit) {
        this.id = id;
        this.name = name;
        this.category = category;
        this.description = description;
        this.price = price;
        this.discount = discount;
        this.image = image;
        this.unit = unit;
    }

    public int getId() { return id; }
    public String getName() { return name; }
    public String getCategory() { return category; }
    public String getDescription() { return description; }
    public double getPrice() { return price; }
    public double getDiscount() { return discount; }
    public String getImage() { return image; }
    public String getUnit() { return unit; }
}