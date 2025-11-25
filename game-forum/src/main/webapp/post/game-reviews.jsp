<!-- game-reviews.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>游戏评测 - 游戏论坛</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<%@ include file="/include/header.jsp" %>

<div class="container main-content">
    <div class="content">
        <h2>游戏评测</h2>

        <div class="posts-list">
            <div class="post-item">
                <h3><a href="#">《艾伦·韦克2》深度评测：黑暗中的光芒</a></h3>
                <p>Remedy Entertainment带来的这部心理恐怖续作究竟表现如何...</p>
                <div class="post-meta">
                    <span>作者: 恐怖游戏专家</span>
                    <span>发布时间: 2023-01-10</span>
                </div>
            </div>

            <div class="post-item">
                <h3><a href="#">《漫威蜘蛛侠2》PS5版全面评测</a></h3>
                <p>Insomniac Games为我们带来了更加成熟的蜘蛛侠故事...</p>
                <div class="post-meta">
                    <span>作者: 超级英雄迷</span>
                    <span>发布时间: 2023-01-08</span>
                </div>
            </div>
        </div>
    </div>

    <div class="sidebar">
        <div class="widget">
            <h3>游戏分类</h3>
            <ul>
                <li><a href="${pageContext.request.contextPath}/forum/action-games.jsp">动作游戏</a></li>
                <li><a href="${pageContext.request.contextPath}/post/upcoming-games.jsp">新游预告</a></li>
                <li><a href="${pageContext.request.contextPath}/post/upcoming-games.jsp">攻略分享</a></li>
            </ul>
        </div>
    </div>
</div>

<%@ include file="/include/footer.jsp" %>
</body>
</html>
