<!-- posts.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>帖子列表 - 游戏论坛</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
    <%@ include file="include/header.jsp" %>
    
    <div class="container main-content">
        <div class="content">
            <h2>所有帖子</h2>
            
            <c:if test="${param.categoryId != null}">
                <h3>${param.categoryName} 板块</h3>
            </c:if>
            
            <div class="posts-list">
                <c:forEach var="post" items="${posts}">
                    <div class="post-item">
                        <h3><a href="postDetail.jsp?postId=${post.postId}">${post.title}</a></h3>
                        <p>${post.content.substring(0, Math.min(post.content.length(), 100))}${post.content.length() > 100 ? '...' : ''}</p>
                        <div class="post-meta">
                            <span>作者: ${post.username}</span>
                            <span>发布时间: ${post.createdAt}</span>
                            <span>板块: ${post.categoryName}</span>
                        </div>
                    </div>
                </c:forEach>
                
                <c:if test="${empty posts}">
                    <p>暂无帖子</p>
                </c:if>
            </div>
        </div>
        
        <div class="sidebar">
            <div class="widget">
                <h3>游戏板块</h3>
                <ul>
                    <c:forEach var="category" items="${categories}">
                        <li><a href="posts.jsp?categoryId=${category.categoryId}&categoryName=${category.categoryName}">${category.categoryName}</a></li>
                    </c:forEach>
                </ul>
            </div>
        </div>
    </div>
    
    <%@ include file="include/footer.jsp" %>
</body>
</html>
