// src/main/java/com/forum/servlet/admin/ManagePostsServlet.java
package com.forum.servlet;

import com.forum.dao.PostDAO;
import com.forum.model.Post;
import com.forum.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/posts")
public class ManagePostsServlet extends HttpServlet {
    private PostDAO postDAO = new PostDAO();
    private static final int PAGE_SIZE = 10; // 每页显示10条记录

    // 更新 ManagePostsServlet.java 中的 doGet 方法
// 修改分页获取帖子的方法，按postId降序排列
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 检查用户权限
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

        if (currentUser == null || !currentUser.getRole().equals("admin")) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "权限不足");
            return;
        }

        int totalPosts = 0;
        int currentPage = 0;
        int pageSize = 0;
        List<Post> posts = null;
        int totalPages = 0;
        try {
            // 获取当前页码，默认为第1页
            currentPage = 1;
            String pageParam = request.getParameter("page");
            if (pageParam != null && !pageParam.isEmpty()) {
                currentPage = Integer.parseInt(pageParam);
                if (currentPage < 1) {
                    currentPage = 1;
                }
            }

            // 每页显示记录数 - 修改这里的数值来改变每页显示的帖子数量
            pageSize = 20;

            // 获取分页数据（按postId降序排列）
            posts = postDAO.getAllPostsOrderedById(currentPage, pageSize);
            totalPosts = postDAO.getTotalPostCount();
            totalPages = (int) Math.ceil((double) totalPosts / pageSize);

            request.setAttribute("posts", posts);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("totalPosts", totalPosts);

            request.getRequestDispatcher("/WEB-INF/jsp/admin/managePosts.jsp").forward(request, response);
            System.out.println("成功转发到 JSP 页面");
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("ManagePostsServlet 出现异常: " + e.getMessage());
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "服务器内部错误");
        }

    }


}
