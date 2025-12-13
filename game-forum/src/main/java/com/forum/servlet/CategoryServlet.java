// CategoryServlet.java
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

@WebServlet("/admin/category")
public class CategoryServlet extends HttpServlet {
    private CategoryDAO categoryDAO = new CategoryDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("delete".equals(action)) {
            deleteCategory(request, response);
        } else {
            listCategories(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 设置请求和响应的字符编码
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String action = request.getParameter("action");

        if ("add".equals(action)) {
            addCategory(request, response);
        } else {
            listCategories(request, response);
        }
    }

    private void listCategories(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Category> categories = categoryDAO.getAllCategories();
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("/WEB-INF/jsp/admin/manageCategories.jsp").forward(request, response);
    }

    private void addCategory(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String categoryName = request.getParameter("categoryName");
        String description = request.getParameter("description");

        Category category = new Category(categoryName, description);
        boolean success = categoryDAO.addCategory(category);

        if (success) {
            response.sendRedirect(request.getContextPath() + "/admin/category");
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/category?error=添加失败");
        }
    }

    private void deleteCategory(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            int categoryId = Integer.parseInt(request.getParameter("id"));
            boolean success = categoryDAO.deleteCategory(categoryId);

            if (success) {
                response.sendRedirect(request.getContextPath() + "/admin/category");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/category?error=删除失败");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/category?error=无效的分类ID");
        }
    }
}
