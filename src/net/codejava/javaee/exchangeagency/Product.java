package net.codejava.javaee.exchangeagency;

import java.util.Base64;

public class Product {
    private int id;
    private String category;
    private String name;
    private String brand;
    private String model;
    private String description;
    private float price;
    private byte[] image;
    private String base64Image;

    public Product(int id, String category, String name, String brand, String model, String description, float price, byte[] image) {
        this.id = id;
        this.category = category;
        this.name = name;
        this.brand = brand;
        this.model = model;
        this.description = description;
        this.price = price;
        this.image = image;
    }

    public Product(String category, String name, String brand, String model, String description, float price, byte[] image) {
        this.category = category;
        this.name = name;
        this.brand = brand;
        this.model = model;
        this.description = description;
        this.price = price;
        this.image = image;
    }

    // Constructor with only id
    public Product(int id) {
        this.id = id;
    }

    // Default constructor
    public Product() {}

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCategory() {
        return category;
    }

    public String getName() {
        return name;
    }

    public String getBrand() {
        return brand;
    }

    public String getModel() {
        return model;
    }

    public String getDescription() {
        return description;
    }

    public float getPrice() {
        return price;
    }

    public byte[] getImage() {
        return image;
    }

    public void setImage(byte[] image) {
        this.image = image;
    }

    // Method to get Base64 encoded image string
    public String getBase64Image() {
        if (image != null) {
            return Base64.getEncoder().encodeToString(image);
        }
        return null;
    }
    
    @Override
    public String toString() {
        return "Product [id=" + id + ", category=" + category + ", name=" + name + ", brand=" + brand + ", model="
                + model + ", description=" + description + ", price=" + price + "]";
    }
}
