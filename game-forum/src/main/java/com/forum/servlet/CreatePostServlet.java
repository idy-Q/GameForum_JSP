// CreatePostServlet.java
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

@WebServlet("/createPost")
public class CreatePostServlet extends HttpServlet {
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("/newPost.jsp").forward(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
        
        Post post = new Post(title, content, user.getUserId(), categoryId);
        PostDAO postDAO = new PostDAO();
        
        if (postDAO.createPost(post)) {
            response.sendRedirect("index.jsp?success=帖子发布成功");
        } else {
            request.setAttribute("error", "发布失败，请重试");
            request.getRequestDispatcher("/newPost.jsp").forward(request, response);
        }
    }
}
