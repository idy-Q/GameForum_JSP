// AdminServlet.java
package com.forum.servlet;

import com.forum.dao.CategoryDAO;
import com.forum.dao.PostDAO;
import com.forum.dao.UserDAO;
import com.forum.model.Category;
import com.forum.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/*")
public class AdminServlet extends HttpServlet {
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null || !"admin".equals(user.getRole())) {
            response.sendRedirect("../login.jsp");
            return;
        }
        
        String action = request.getPathInfo();
        if (action == null) action = "";
        
        switch (action) {
            case "/dashboard":
                showDashboard(request, response);
                break;
            case "/users":
                showUsers(request, response);
                break;
            case "/categories":
                showCategories(request, response);
                break;
            case "/posts":
                showPosts(request, response);
                break;
            default:
                showDashboard(request, response);
                break;
        }
    }
    
    private void showDashboard(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("/admin/adminDashboard.jsp").forward(request, response);
    }
    
    private void showUsers(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        UserDAO userDAO = new UserDAO();
        List<User> users = userDAO.getAllUsers();
        request.setAttribute("users", users);
        request.getRequestDispatcher("/admin/manageUsers.jsp").forward(request, response);
    }
    
    private void showCategories(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        CategoryDAO categoryDAO = new CategoryDAO();
        List<Category> categories = categoryDAO.getAllCategories();
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("/admin/manageCategories.jsp").forward(request, response);
    }
    
    private void showPosts(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        PostDAO postDAO = new PostDAO();
        List<com.forum.model.Post> posts = postDAO.getAllPosts();
        request.setAttribute("posts", posts);
        request.getRequestDispatcher("/admin/managePosts.jsp").forward(request, response);
    }
}
