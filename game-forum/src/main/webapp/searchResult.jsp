<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>搜索结果: ${searchKeyword} - 游戏论坛</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
<%@ include file="include/header.jsp" %>

<div class="container main-content">
    <div class="content">
        <h2>🔍 搜索结果: "${searchKeyword}"</h2>

        <div class="posts-list">
            <c:if test="${not empty posts}">
                <c:forEach items="${posts}" var="post">
                    <div class="post-item">
                        <h3><a href="${pageContext.request.contextPath}/postDetail?postId=${post.postId}">${post.title}</a></h3>
                        <p>
                                ${post.content.length() > 100 ? post.content.substring(0, 100) : post.content}
                                ${post.content.length() > 100 ? '...' : ''}
                        </p>
                        <div class="post-meta">
                            <span>作者: ${post.username}</span>
                            <span>发布时间: ${post.createdAt}</span>
                            <span style="color: #ff6b6b;">❤ 热度: ${post.likes}</span>
                        </div>
                    </div>
                </c:forEach>
            </c:if>

            <c:if test="${empty posts}">
                <div style="padding: 40px; text-align: center; color: #666;">
                    <p>没有找到与 "<strong>${searchKeyword}</strong>" 相关的帖子。</p>
                    <p>试试其他关键字？</p>
                </div>
            </c:if>
        </div>
    </div>

    <div class="sidebar">
        <div class="widget">
            <h3>快捷导航</h3>
            <ul>
                <li><a href="index.jsp">返回首页</a></li>
                <li><a href="newPost">发表新帖</a></li>
            </ul>
        </div>
    </div>
</div>

<%@ include file="include/footer.jsp" %>
</body>
</html>