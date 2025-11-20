<!-- action-games.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>动作游戏 - 游戏论坛</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<%@ include file="/include/header.jsp" %>

<div class="container main-content">
    <div class="content">
        <h2>动作游戏</h2>

        <div class="posts-list">
            <!-- 这里将从数据库获取动作游戏相关的帖子 -->
            <div class="post-item">
                <h3><a href="#">《鬼泣5》最新DLC发布</a></h3>
                <p>卡普空发布了《鬼泣5》的全新DLC内容...</p>
                <div class="post-meta">
                    <span>作者: 游戏达人</span>
                    <span>发布时间: 2023-01-01</span>
                </div>
            </div>

            <div class="post-item">
                <h3><a href="#">《战神：诸神黄昏》攻略分享</a></h3>
                <p>为大家带来最新的《战神：诸神黄昏》通关攻略...</p>
                <div class="post-meta">
                    <span>作者: 北欧神话迷</span>
                    <span>发布时间: 2023-01-02</span>
                </div>
            </div>
        </div>
    </div>

    <div class="sidebar">
        <div class="widget">
            <h3>热门话题</h3>
            <ul>
                <li><a href="#">新游预告</a></li>
                <li><a href="#">游戏评测</a></li>
                <li><a href="#">攻略分享</a></li>
            </ul>
        </div>
    </div>
</div>

<%@ include file="/include/footer.jsp" %>
</body>
</html>
