// PostDetailServlet.java
package com.forum.servlet;

import com.forum.dao.CommentDAO;
import com.forum.dao.PostDAO;
import com.forum.model.Comment;
import com.forum.model.Post;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/postDetail")
public class PostDetailServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String postIdStr = request.getParameter("postId");
        System.out.println("DEBUG: Received postId parameter: " + postIdStr);

        if (postIdStr == null || postIdStr.isEmpty()) {
            System.out.println("DEBUG: postId is null or empty");
            response.sendRedirect(request.getContextPath() + "/error.jsp?error=Invalid Post ID");
            return;
        }

        try {
            int postId = Integer.parseInt(postIdStr);
            System.out.println("DEBUG: Parsed postId: " + postId);

            PostDAO postDAO = new PostDAO();
            CommentDAO commentDAO = new CommentDAO();

            Post post = postDAO.getPostById(postId);
            System.out.println("DEBUG: Retrieved post object: " + post);

            if (post == null) {
                System.out.println("DEBUG: Post not found in database");
                response.sendRedirect(request.getContextPath() + "/error.jsp?error=Post Not Found");
                return;
            }

            List<Comment> comments = commentDAO.getCommentsByPostId(postId);
            System.out.println("DEBUG: Retrieved comments count: " + comments.size());

            request.setAttribute("post", post);
            request.setAttribute("comments", comments);

            RequestDispatcher dispatcher = request.getRequestDispatcher("/user/postDetail.jsp");
            dispatcher.forward(request, response);
        } catch (NumberFormatException e) {
            System.out.println("DEBUG: Number format exception: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/error.jsp?error=Invalid Post ID Format");
        }
    }

}
