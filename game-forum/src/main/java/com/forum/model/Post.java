// Post.java
package com.forum.model;

import java.sql.Timestamp;

public class Post {
    private int postId;
    private String title;
    private String content;
    private int userId;
    private int categoryId;
    private Timestamp createdAt;
    private Timestamp updatedAt;
    private String username; // For display purposes
    private String categoryName;
    private int likes; // 新增：点赞数

    // Constructors
    public Post() {}

    public Post(String title, String content, int userId, int categoryId) {
        this.title = title;
        this.content = content;
        this.userId = userId;
        this.categoryId = categoryId;
        this.createdAt = new Timestamp(System.currentTimeMillis());
        this.updatedAt = new Timestamp(System.currentTimeMillis());
        this.likes = 0; // 新帖子默认点赞为0
    }

    // Getters and Setters
    public int getPostId() { return postId; }
    public void setPostId(int postId) { this.postId = postId; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public int getCategoryId() { return categoryId; }
    public void setCategoryId(int categoryId) { this.categoryId = categoryId; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    public Timestamp getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Timestamp updatedAt) { this.updatedAt = updatedAt; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getCategoryName() { return categoryName; }
    public void setCategoryName(String categoryName) { this.categoryName = categoryName; }

    // 新增 likes 的 getter 和 setter
    public int getLikes() { return likes; }
    public void setLikes(int likes) { this.likes = likes; }
}