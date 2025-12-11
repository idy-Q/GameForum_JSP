// SearchServlet.java
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

@WebServlet("/search")
public class SearchServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. 设置编码，防止中文乱码
        request.setCharacterEncoding("UTF-8");

        // 2. 获取用户输入的关键字
        String keyword = request.getParameter("keyword");

        // 3. 如果关键字为空，直接回首页
        if (keyword == null || keyword.trim().isEmpty()) {
            response.sendRedirect("index.jsp");
            return;
        }

        // 4. 调用 DAO 进行搜索
        PostDAO postDAO = new PostDAO();
        List<Post> searchResults = postDAO.searchPosts(keyword);

        // 5. 将结果和关键字存入 request，转发给结果页面
        request.setAttribute("posts", searchResults);
        request.setAttribute("searchKeyword", keyword); // 用于在页面上显示“搜索：xxx 的结果”

        request.getRequestDispatcher("/searchResult.jsp").forward(request, response);
    }
}