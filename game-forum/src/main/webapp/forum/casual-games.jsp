<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>休闲游戏 - 游戏论坛</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<%@ include file="/include/header.jsp" %>

<div class="container main-content">
    <div class="content">
        <h2>休闲游戏</h2>

        <div class="posts-list">
            <c:if test="${not empty posts}">
                <c:forEach items="${posts}" var="post">
                    <div class="post-item">
                        <h3><a href="${pageContext.request.contextPath}/user/postDetail.jsp?postId=${post.postId}">${post.title}</a></h3>
                        <p>
                                ${post.content.length() > 50 ? post.content.substring(0, 50) : post.content}
                                ${post.content.length() > 50 ? '...' : ''}
                        </p>
                        <div class="post-meta">
                            <span>作者: ${post.username}</span>
                            <span>发布时间: ${post.createdAt}</span>
                        </div>
                    </div>
                </c:forEach>
            </c:if>

            <c:if test="${empty posts}">
                <p>暂无休闲游戏帖子，快来发表第一个帖子吧！</p>
            </c:if>
        </div>
    </div>

    <div class="sidebar">
        <div class="widget">
            <h3>话题</h3>
            <ul>
                <li><a href="#">轻松娱乐</a></li>
                <li><a href="#">社交互动</a></li>
                <li><a href="#">休闲时光</a></li>
            </ul>
        </div>
    </div>
</div>

<%@ include file="/include/footer.jsp" %>
</body>
</html>