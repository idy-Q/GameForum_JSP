// PostDAO.java
package com.forum.dao;

import com.forum.model.Post;
import com.forum.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PostDAO {

    /**
     * 根据分类ID获取帖子列表（用于普通展示，按时间倒序）
     */
    public List<Post> getPostsByCategory(int categoryId) {
        List<Post> posts = new ArrayList<>();
        // 注意：这里 SQL 增加了 likes 字段
        String sql = "SELECT p.*, u.username FROM posts p JOIN users u ON p.user_id=u.user_id WHERE p.category_id=? ORDER BY p.created_at DESC";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, categoryId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                posts.add(mapResultSetToPost(rs)); // 使用提取出来的通用方法封装对象
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return posts;
    }

    /**
     * 获取所有帖子
     */
    public List<Post> getAllPosts() {
        List<Post> posts = new ArrayList<>();
        String sql = "SELECT p.*, u.username, c.category_name FROM posts p JOIN users u ON p.user_id=u.user_id JOIN categories c ON p.category_id=c.category_id ORDER BY p.created_at DESC";

        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Post post = mapResultSetToPost(rs);
                post.setCategoryName(rs.getString("category_name"));
                posts.add(post);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return posts;
    }

    /**
     * 根据ID获取单个帖子详情
     */
    public Post getPostById(int postId) {
        String sql = "SELECT p.*, u.username FROM posts p JOIN users u ON p.user_id=u.user_id WHERE p.post_id=?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, postId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return mapResultSetToPost(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * 创建新帖子
     */
    public boolean createPost(Post post) {
        // 注意：SQL 插入时不需要插入 likes，因为数据库默认是 0
        String sql = "INSERT INTO posts(title, content, user_id, category_id, created_at, updated_at) VALUES(?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setString(1, post.getTitle());
            stmt.setString(2, post.getContent());
            stmt.setInt(3, post.getUserId());
            stmt.setInt(4, post.getCategoryId());
            stmt.setTimestamp(5, new Timestamp(post.getCreatedAt().getTime()));
            stmt.setTimestamp(6, new Timestamp(post.getUpdatedAt().getTime()));

            int result = stmt.executeUpdate();

            if (result > 0) {
                ResultSet generatedKeys = stmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    post.setPostId(generatedKeys.getInt(1));
                }
                return true;
            }
            return false;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deletePost(int postId) {
        String sql = "DELETE FROM posts WHERE post_id=?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, postId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public int getPostCount() {
        String sql = "SELECT COUNT(*) FROM posts";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // ================== 以下是本次新增的核心功能 ==================

    /**
     * 新增：给帖子点赞（点赞数 +1）
     */
    public boolean increaseLike(int postId) {
        String sql = "UPDATE posts SET likes = likes + 1 WHERE post_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, postId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * 新增：获取某板块下的“热搜”帖子（按点赞数倒序排列，取前5名）
     */
    public List<Post> getTrendingPostsByCategory(int categoryId, int limit) {
        List<Post> posts = new ArrayList<>();
        // 核心逻辑：ORDER BY likes DESC (按点赞倒序)
        String sql = "SELECT p.*, u.username FROM posts p JOIN users u ON p.user_id=u.user_id WHERE p.category_id=? ORDER BY p.likes DESC LIMIT ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, categoryId);
            stmt.setInt(2, limit); // 限制返回的数量，比如前5名
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                posts.add(mapResultSetToPost(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return posts;
    }

    /**
     * 新增：全站搜索功能
     * 根据标题进行模糊查询 (LIKE %keyword%)
     */
    public List<Post> searchPosts(String keyword) {
        List<Post> posts = new ArrayList<>();
        // 使用 LIKE 关键字进行模糊匹配
        String sql = "SELECT p.*, u.username FROM posts p JOIN users u ON p.user_id=u.user_id WHERE p.title LIKE ? ORDER BY p.created_at DESC";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            // 拼接 % 符号，实现“包含”查询
            stmt.setString(1, "%" + keyword + "%");
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                // 复用之前的映射方法
                posts.add(mapResultSetToPost(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return posts;
    }

    /**
     * 辅助方法：将 ResultSet 映射为 Post 对象，避免代码重复
     * 并且确保读取了 likes 字段
     */
    private Post mapResultSetToPost(ResultSet rs) throws SQLException {
        Post post = new Post();
        post.setPostId(rs.getInt("post_id"));
        post.setTitle(rs.getString("title"));
        post.setContent(rs.getString("content"));
        post.setUserId(rs.getInt("user_id"));
        post.setCategoryId(rs.getInt("category_id"));
        post.setCreatedAt(rs.getTimestamp("created_at"));
        post.setUpdatedAt(rs.getTimestamp("updated_at"));
        post.setUsername(rs.getString("username"));
        post.setLikes(rs.getInt("likes")); // 这里读取数据库中的 likes
        return post;
    }

    // ================== 分页功能新增方法 ==================

    /**
     * 新增：分页获取某板块下的帖子
     * @param categoryId 板块ID
     * @param page 当前页码 (1, 2, 3...)
     * @param pageSize 每页显示多少条
     */
    public List<Post> getPostsByCategory(int categoryId, int page, int pageSize) {
        List<Post> posts = new ArrayList<>();
        // 计算偏移量：(当前页 - 1) * 每页数量
        int offset = (page - 1) * pageSize;

        // SQL: LIMIT 限制返回数量, OFFSET 指定跳过多少行
        String sql = "SELECT p.*, u.username FROM posts p JOIN users u ON p.user_id=u.user_id " +
                "WHERE p.category_id=? ORDER BY p.created_at DESC LIMIT ? OFFSET ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, categoryId);
            stmt.setInt(2, pageSize);
            stmt.setInt(3, offset);

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                posts.add(mapResultSetToPost(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return posts;
    }

    /**
     * 新增：统计某板块下的帖子总数 (用于计算总页数)
     */
    public int getPostCountByCategory(int categoryId) {
        String sql = "SELECT COUNT(*) FROM posts WHERE category_id=?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, categoryId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    /**
     * 分页获取所有帖子
     */
    public List<Post> getAllPosts(int page, int pageSize) {
        List<Post> posts = new ArrayList<>();
        int offset = (page - 1) * pageSize;

        String sql = "SELECT p.*, u.username, c.category_name FROM posts p JOIN users u ON p.user_id=u.user_id JOIN categories c ON p.category_id=c.category_id ORDER BY p.created_at DESC LIMIT ? OFFSET ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, pageSize);
            stmt.setInt(2, offset);

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Post post = mapResultSetToPost(rs);
                post.setCategoryName(rs.getString("category_name"));
                posts.add(post);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return posts;
    }

    /**
     * 获取帖子总数
     */
    public int getTotalPostCount() {
        String sql = "SELECT COUNT(*) FROM posts";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    /**
     * 分页获取所有帖子，按postId降序排列（最新的帖子在前面）
     */
    public List<Post> getAllPostsOrderedById(int page, int pageSize) {
        List<Post> posts = new ArrayList<>();
        int offset = (page - 1) * pageSize;

        // 按postId降序排列（DESC），最新的帖子显示在前面
        String sql = "SELECT p.*, u.username, c.category_name FROM posts p JOIN users u ON p.user_id=u.user_id JOIN categories c ON p.category_id=c.category_id ORDER BY p.post_id DESC LIMIT ? OFFSET ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, pageSize);
            stmt.setInt(2, offset);

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Post post = mapResultSetToPost(rs);
                post.setCategoryName(rs.getString("category_name"));
                posts.add(post);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return posts;
    }


}