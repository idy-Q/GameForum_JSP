// CommentDAO.java
package com.forum.dao;

import com.forum.model.Comment;
import com.forum.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CommentDAO {
    
    public List<Comment> getCommentsByPost(int postId) {
        List<Comment> comments = new ArrayList<>();
        String sql = "SELECT c.*, u.username FROM comments c JOIN users u ON c.user_id=u.user_id WHERE c.post_id=? ORDER BY c.created_at ASC";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, postId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Comment comment = new Comment();
                comment.setCommentId(rs.getInt("comment_id"));
                comment.setContent(rs.getString("content"));
                comment.setUserId(rs.getInt("user_id"));
                comment.setPostId(rs.getInt("post_id"));
                comment.setCreatedAt(rs.getTimestamp("created_at"));
                comment.setUsername(rs.getString("username"));
                comments.add(comment);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return comments;
    }
    
    public boolean addComment(Comment comment) {
        String sql = "INSERT INTO comments(content, user_id, post_id) VALUES(?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, comment.getContent());
            stmt.setInt(2, comment.getUserId());
            stmt.setInt(3, comment.getPostId());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
