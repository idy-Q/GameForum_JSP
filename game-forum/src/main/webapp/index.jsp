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

    com.forum.dao.PostDAO postDAO = new com.forum.dao.PostDAO();
    java.util.List<com.forum.model.Post> latestPosts = postDAO.getAllPosts();
    request.setAttribute("latestPosts", latestPosts);
%>


<div class="container main-content">
    <div class="content">
        <h2>最新帖子</h2>
        <c:if test="${param.success != null}">
            <div class="alert alert-success">${param.success}</div>
        </c:if>

        <div class="posts-list">
            <c:forEach var="post" items="${latestPosts}" begin="0" end="1">
                <div class="post-item">
                    <h3><a href="post?postId=${post.postId}">${post.title}</a></h3>
                    <p>${post.content}</p>
                    <div class="post-meta">
                        <span>作者: ${post.username}</span>
                        <span>发布时间: ${post.createdAt}</span>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>

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
