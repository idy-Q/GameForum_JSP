// ActionGamesServlet.java
package com.forum.servlet;

import com.forum.dao.PostDAO;
import com.forum.model.Post;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/forum/action-games")
public class ActionGamesServlet extends HttpServlet {
    private PostDAO postDAO;

    @Override
    public void init() throws ServletException {
        postDAO = new PostDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. 定义分页参数
        int page = 1; // 默认第1页
        int pageSize = 5; // 每页显示5条 (为了测试效果，你可以改成10)

        // 2. 尝试从请求中获取页码
        String pageParam = request.getParameter("page");
        if (pageParam != null && !pageParam.isEmpty()) {
            try {
                page = Integer.parseInt(pageParam);
            } catch (NumberFormatException e) {
                page = 1; // 如果参数乱填，强制回第1页
            }
        }

        // 3. 这里的 categoryId 是 1 (动作游戏)
        int categoryId = 1;

        // 4. 获取当前页的数据
        List<Post> posts = postDAO.getPostsByCategory(categoryId, page, pageSize);

        // 5. 获取热搜数据 (保持不变)
        List<Post> trendingPosts = postDAO.getTrendingPostsByCategory(categoryId, 5);

        // 6. 计算总页数
        int totalPosts = postDAO.getPostCountByCategory(categoryId);
        int totalPages = (int) Math.ceil((double) totalPosts / pageSize);

        // 7. 将所有数据传递给 JSP
        request.setAttribute("posts", posts);
        request.setAttribute("trendingPosts", trendingPosts);

        // 分页相关数据
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);

        request.getRequestDispatcher("/forum/action-games.jsp").forward(request, response);
    }
}