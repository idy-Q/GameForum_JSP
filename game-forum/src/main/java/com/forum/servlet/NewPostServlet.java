// NewPostServlet.java
package com.forum.servlet;

import com.forum.dao.CategoryDAO;
import com.forum.model.Category;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/newPost")
public class NewPostServlet extends HttpServlet {
    private CategoryDAO categoryDAO = new CategoryDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 获取所有分类
        List<Category> categories = categoryDAO.getAllCategories();

        // 将分类数据设置到请求属性中
        request.setAttribute("categories", categories);

        // 转发到新帖子页面
        request.getRequestDispatcher("/user/newPost.jsp").forward(request, response);
    }
}
