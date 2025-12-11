// RpgGamesServlet.java
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

@WebServlet("/forum/rpg-games")
public class RpgGamesServlet extends HttpServlet {
    private PostDAO postDAO;

    @Override
    public void init() throws ServletException {
        postDAO = new PostDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int page = 1; // 默认第1页
        int pageSize = 5; // 每页显示5条 (为了测试效果，你可以改成10)

        String pageParam = request.getParameter("page");
        if (pageParam != null && !pageParam.isEmpty()) {
            try {
                page = Integer.parseInt(pageParam);
            } catch (NumberFormatException e) {
                page = 1; // 如果参数乱填，强制回第1页
            }
        }

        int categoryId = 2;

        List<Post> posts = postDAO.getPostsByCategory(categoryId, page, pageSize);
        List<Post> trendingPosts = postDAO.getTrendingPostsByCategory(categoryId, 5); // 获取热搜

        int totalPosts = postDAO.getPostCountByCategory(categoryId);
        int totalPages = (int) Math.ceil((double) totalPosts / pageSize);

        request.setAttribute("posts", posts);
        request.setAttribute("trendingPosts", trendingPosts);

        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);

        request.getRequestDispatcher("/forum/rpg-games.jsp").forward(request, response);
    }
}