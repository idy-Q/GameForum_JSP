// LikePostServlet.java
package com.forum.servlet;

import com.forum.dao.PostDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/likePost")
public class LikePostServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String postIdStr = request.getParameter("postId");
        if (postIdStr != null) {
            int postId = Integer.parseInt(postIdStr);

            PostDAO postDAO = new PostDAO();
            // 1. 执行点赞 +1
            postDAO.increaseLike(postId);

            // 2. 获取最新的点赞数 (为了确保数据准确，我们重新查一次数据库)
            int newLikes = postDAO.getPostById(postId).getLikes();

            // 3. 关键点：不再使用 sendRedirect 跳转页面
            // 而是设置返回类型为纯文本，直接把“数字”返回给浏览器
            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().write(String.valueOf(newLikes));
        }
    }
}