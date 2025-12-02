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

        // 获取角色扮演游戏分类下的帖子 (角色扮演游戏的category_id为2)
        List<Post> posts = postDAO.getPostsByCategory(2);

        // 设置到request作用域
        request.setAttribute("posts", posts);

        // 转发到视图
        request.getRequestDispatcher("/forum/rpg-games.jsp").forward(request, response);
    }
}
