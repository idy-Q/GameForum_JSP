// AddCommentServlet.java
package com.forum.servlet;

import com.forum.dao.CommentDAO;
import com.forum.model.Comment;
import com.forum.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/addComment")
public class AddCommentServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. 设置请求和响应的编码
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/plain;charset=UTF-8");

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        // 如果未登录，返回特定字符串让前端处理
        if (user == null) {
            response.getWriter().write("need_login");
            return;
        }

        String content = request.getParameter("content");
        String postIdStr = request.getParameter("postId");

        if (postIdStr == null || postIdStr.isEmpty() || content == null || content.trim().isEmpty()) {
            response.getWriter().write("empty_content");
            return;
        }

        int postId = Integer.parseInt(postIdStr);

        Comment comment = new Comment(content, user.getUserId(), postId);
        CommentDAO commentDAO = new CommentDAO();

        if (commentDAO.addComment(comment)) {
            // 2. 成功时只返回 "success" 字符串，不再重定向
            response.getWriter().write("success");
        } else {
            response.getWriter().write("fail");
        }
    }
}