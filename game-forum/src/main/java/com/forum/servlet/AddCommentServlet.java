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
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        String content = request.getParameter("content");
        int postId = Integer.parseInt(request.getParameter("postId"));
        
        Comment comment = new Comment(content, user.getUserId(), postId);
        CommentDAO commentDAO = new CommentDAO();
        
        if (commentDAO.addComment(comment)) {
            response.sendRedirect("postDetail.jsp?postId=" + postId);
        } else {
            response.sendRedirect("postDetail.jsp?postId=" + postId + "&error=评论失败");
        }
    }
}
