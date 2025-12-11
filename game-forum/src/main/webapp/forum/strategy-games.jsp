<!-- src/main/webapp/forum/strategy-games.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>策略游戏 - 游戏论坛</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<%@ include file="/include/header.jsp" %>

<div class="container main-content">
    <div class="content">
        <h2>策略游戏</h2>

        <div class="posts-list">
            <c:if test="${not empty posts}">
                <c:forEach items="${posts}" var="post">
                    <div class="post-item">
                        <h3><a href="${pageContext.request.contextPath}/postDetail?postId=${post.postId}">${post.title}</a></h3>
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
                <p>暂无策略游戏帖子，快来发表第一个帖子吧！</p>
            </c:if>

            <div class="posts-list">
                <c:if test="${not empty posts}">
                </c:if>

                <c:if test="${empty posts}">
                    <p>暂无帖子，快来发表第一个帖子吧！</p>
                </c:if>

                <%@ include file="/include/pagination.jsp" %>

            </div>
        </div>
    </div>

    <div class="sidebar">
        <div class="widget">
            <h3>🔥 本版热搜 (Top 5)</h3>
            <ul>
                <c:choose>
                    <c:when test="${not empty trendingPosts}">
                        <c:forEach items="${trendingPosts}" var="trend">
                            <li style="margin-bottom: 8px; border-bottom: 1px dashed #eee; padding-bottom: 5px;">
                                <a href="${pageContext.request.contextPath}/postDetail?postId=${trend.postId}" style="display: flex; justify-content: space-between;">
                                    <span style="overflow: hidden; text-overflow: ellipsis; white-space: nowrap; max-width: 180px;">
                                            ${trend.title}
                                    </span>
                                    <span style="color: #ff6b6b; font-size: 0.9em;">🔥 ${trend.likes}</span>
                                </a>
                            </li>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <li>暂无热搜数据</li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>

</div>

<%@ include file="/include/footer.jsp" %>
</body>
</html>
