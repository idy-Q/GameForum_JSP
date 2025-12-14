<!-- admin/adminDashboard.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    // 获取统计数据的逻辑
    com.forum.dao.UserDAO userDAO = new com.forum.dao.UserDAO();
    com.forum.dao.PostDAO postDAO = new com.forum.dao.PostDAO();
    com.forum.dao.CommentDAO commentDAO = new com.forum.dao.CommentDAO();

    int userCount = userDAO.getUserCount();
    int postCount = postDAO.getPostCount();
     int commentCount = commentDAO.getCommentCount();

    request.setAttribute("userCount", userCount);
    request.setAttribute("postCount", postCount);
    request.setAttribute("commentCount", commentCount);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>管理员面板 - 游戏论坛</title>
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
    <%@ include file="../../../include/header.jsp" %>

    <div class="admin-container">
        <c:if test="${sessionScope.user == null || sessionScope.user.role != 'admin'}">
            <div class="alert alert-error">权限不足</div>
            <script>
                setTimeout(function() {
                    window.location.href = '<%= request.getContextPath() %>/index.jsp';
                }, 2000);
            </script>
        </c:if>
        
        <c:if test="${sessionScope.user != null && sessionScope.user.role == 'admin'}">
            <h2>管理员控制面板</h2>

            <div class="admin-menu">
                <ul>
                    <li><a href="<%= request.getContextPath() %>/admin/users">用户管理</a></li>
                    <li><a href="<%= request.getContextPath() %>/admin/categories">板块管理</a></li>
                    <li><a href="<%= request.getContextPath() %>/admin/posts">帖子管理</a></li>
                </ul>
            </div>
            
            <div class="admin-stats">
                <h3>系统统计</h3>
                <div class="stats-grid">
                    <div class="stat-item">
                        <h4>用户总数</h4>
                        <p>${userCount}</p>
                    </div>
                    <div class="stat-item">
                        <h4>帖子总数</h4>
                        <p>${postCount}</p>
                    </div>
                    <div class="stat-item">
                        <h4>评论总数</h4>
                        <p>${commentCount}</p>
                    </div>
                </div>
            </div>
        </c:if>
    </div>
    
    <%@ include file="../../../include/footer.jsp" %>
</body>
</html>
