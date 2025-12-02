// Category.java
package com.forum.model;

import java.sql.Timestamp;

public class Category {
    private int categoryId;
    private String categoryName;
    private String description;
    private java.sql.Timestamp createdAt;
    // Constructors
    public Category() {
        this.createdAt = new java.sql.Timestamp(System.currentTimeMillis());
    }

    public Category(String categoryName, String description) {
        this.categoryName = categoryName;
        this.description = description;
        this.createdAt = new java.sql.Timestamp(System.currentTimeMillis());
    }
    
    // Getters and Setters
    public int getCategoryId() { return categoryId; }
    public void setCategoryId(int categoryId) { this.categoryId = categoryId; }
    
    public String getCategoryName() { return categoryName; }
    public void setCategoryName(String categoryName) { this.categoryName = categoryName; }
    
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public Timestamp getCreatedAt() {
        return createdAt;
    }
    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
}
