// RegisterServlet.java
package com.forum.servlet;

import com.forum.dao.UserDAO;
import com.forum.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/register.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");

        User user = new User(username, password, email);
        UserDAO userDAO = new UserDAO();

        if (userDAO.registerUser(user)) {
            // 修改这行：重定向回register.jsp并传递success参数
            response.sendRedirect("register.jsp?success=1");
        } else {
            request.setAttribute("error", "注册失败，请重试");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        }
    }
}
