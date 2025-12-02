<!-- index.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>游戏论坛 - 首页</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
<%@ include file="include/header.jsp" %>

<%
    com.forum.dao.CategoryDAO categoryDAO = new com.forum.dao.CategoryDAO();
    java.util.List<com.forum.model.Category> categories = categoryDAO.getAllCategories();
    request.setAttribute("categories", categories);
%>


<div class="container main-content">
    <div class="content">
        <h2>最新帖子</h2>
        <c:if test="${param.success != null}">
            <div class="alert alert-success">${param.success}</div>
        </c:if>

        <div class="posts-list">
            <!-- 这里将从数据库获取帖子列表 -->
            <div class="post-item">
                <h3><a href="#">欢迎来到游戏论坛</a></h3>
                <p>这是论坛的第一个帖子...</p>
                <div class="post-meta">
                    <span>作者: 管理员</span>
                    <span>发布时间: 2023-01-01</span>
                </div>
            </div>
        </div>
    </div>

<%--    <div class="sidebar">--%>
<%--        <div class="widget">--%>
<%--            <h3>游戏板块</h3>--%>
<%--            <ul>--%>
<%--                <li><a href="forum/action-games">动作游戏</a></li>--%>
<%--                <li><a href="forum/rpg-games.jsp">角色扮演</a></li>--%>
<%--                <li><a href="forum/strategy-games.jsp">策略游戏</a></li>--%>
<%--                <li><a href="forum/casual-games.jsp">休闲游戏</a></li>--%>
<%--            </ul>--%>
<%--        </div>--%>
<%--    </div>--%>

    <div class="sidebar">
        <div class="widget">
            <h3>游戏板块</h3>
            <ul>
                <c:forEach var="category" items="${categories}">
                    <c:choose>
                        <c:when test="${category.categoryId == 1}">
                            <li><a href="forum/action-games">${category.categoryName}</a></li>
                        </c:when>
                        <c:when test="${category.categoryId == 2}">
                            <li><a href="forum/rpg-games">${category.categoryName}</a></li>
                        </c:when>
                        <c:when test="${category.categoryId == 3}">
                            <li><a href="forum/strategy-games">${category.categoryName}</a></li>
                        </c:when>
                        <c:when test="${category.categoryId == 4}">
                            <li><a href="forum/casual-games">${category.categoryName}</a></li>
                        </c:when>
                        <c:otherwise>
                            <li><a href="forum?action-games.jsp?categoryId=${category.categoryId}">${category.categoryName}</a></li>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </ul>
        </div>
    </div>

</div>

<%@ include file="include/footer.jsp" %>
</body>
</html>
