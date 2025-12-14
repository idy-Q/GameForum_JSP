// src/main/java/com/forum/servlet/UserManagerServlet.java
package com.forum.servlet;

import com.forum.dao.UserDAO;
import com.forum.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/admin/userAction")
public class UserManagerServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");

        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

        // 检查用户是否已登录且为管理员
        if (currentUser == null || !currentUser.getRole().equals("admin")) {
            response.setStatus(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        String action = request.getParameter("action");
        PrintWriter out = response.getWriter();

        try {
            if ("deleteUser".equals(action)) {
                handleDeleteUser(request, out, currentUser);
            } else if ("changeRole".equals(action)) {
                handleChangeRole(request, out, currentUser);
            } else {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"success\":false,\"message\":\"服务器内部错误\"}");
        }
    }

    private void handleDeleteUser(HttpServletRequest request, PrintWriter out, User currentUser)
            throws IOException {
        int userId = Integer.parseInt(request.getParameter("userId"));

        // 防止管理员删除自己
        if (userId == currentUser.getUserId()) {
            out.print("{\"success\":false,\"message\":\"不能删除自己\"}");
            return;
        }

        if (userDAO.deleteUser(userId)) {
            out.print("{\"success\":true,\"message\":\"用户删除成功\"}");
        } else {
            out.print("{\"success\":false,\"message\":\"用户删除失败\"}");
        }
    }

    private void handleChangeRole(HttpServletRequest request, PrintWriter out, User currentUser)
            throws IOException {
        int userId = Integer.parseInt(request.getParameter("userId"));
        String role = request.getParameter("role");

        // 验证角色值
        if (!"user".equals(role) && !"admin".equals(role)) {
            out.print("{\"success\":false,\"message\":\"无效的角色值\"}");
            return;
        }

        // 防止修改自己的角色
        if (userId == currentUser.getUserId()) {
            out.print("{\"success\":false,\"message\":\"不能修改自己的角色\"}");
            return;
        }

        if (userDAO.updateUserRole(userId, role)) {
            out.print("{\"success\":true,\"message\":\"角色更新成功\"}");
        } else {
            out.print("{\"success\":false,\"message\":\"角色更新失败\"}");
        }
    }
}
