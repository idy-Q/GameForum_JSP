// Comment.java
package com.forum.model;

import java.util.Date;

public class Comment {
    private int commentId;
    private String content;
    private int userId;
    private int postId;
    private Date createdAt;
    private String username; // For display purposes
    
    // Constructors
    public Comment() {}
    
    public Comment(String content, int userId, int postId) {
        this.content = content;
        this.userId = userId;
        this.postId = postId;
        this.createdAt = new Date();
    }
    
    // Getters and Setters
    public int getCommentId() { return commentId; }
    public void setCommentId(int commentId) { this.commentId = commentId; }
    
    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
    
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    
    public int getPostId() { return postId; }
    public void setPostId(int postId) { this.postId = postId; }
    
    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }
    
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
}
