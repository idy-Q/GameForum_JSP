// src/main/java/com/forum/servlet/DeletePostServlet.java
package com.forum.servlet;

import com.forum.dao.PostDAO;
import com.forum.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

@WebServlet("/admin/deletePost")
public class DeletePostServlet extends HttpServlet {
    private PostDAO postDAO = new PostDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 检查用户权限
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

        if (currentUser == null || !currentUser.getRole().equals("admin")) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "权限不足");
            return;
        }

        try {
            // 获取帖子ID参数
            int postId = Integer.parseInt(request.getParameter("postId"));

            // 执行删除操作
            boolean success = postDAO.deletePost(postId);

            if (success) {
                String message = URLEncoder.encode("删除成功", StandardCharsets.UTF_8.toString());
                response.sendRedirect(request.getContextPath() + "/admin/posts?message=" + message);
            } else {
                String error = URLEncoder.encode("删除失败", StandardCharsets.UTF_8.toString());
                response.sendRedirect(request.getContextPath() + "/admin/posts?error=" + error);
            }
        } catch (NumberFormatException e) {
            String error = URLEncoder.encode("无效的帖子ID", StandardCharsets.UTF_8.toString());
            response.sendRedirect(request.getContextPath() + "/admin/posts?error=" + error);
        } catch (Exception e) {
            String error = URLEncoder.encode("删除过程中发生错误", StandardCharsets.UTF_8.toString());
            response.sendRedirect(request.getContextPath() + "/admin/posts?error=" + error);
        }
    }

    // 添加 doGet 方法，防止直接访问 URL 出现空白页面
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 直接重定向到帖子管理页面
        response.sendRedirect(request.getContextPath() + "/admin/posts");
    }
}
