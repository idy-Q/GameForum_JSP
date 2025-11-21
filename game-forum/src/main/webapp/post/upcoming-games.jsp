<!-- upcoming-games.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>新游预告 - 游戏论坛</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<%@ include file="/include/header.jsp" %>

<div class="container main-content">
    <div class="content">
        <h2>新游预告</h2>

        <div class="posts-list">
            <div class="post-item">
                <h3><a href="#">《星空》最新预告片解析</a></h3>
                <p>Bethesda全新太空探索游戏《星空》发布了最新预告...</p>
                <div class="post-meta">
                    <span>作者: 星空爱好者</span>
                    <span>发布时间: 2023-01-05</span>
                </div>
            </div>

            <div class="post-item">
                <h3><a href="#">《塞尔达传说：王国之泪》发售倒计时</a></h3>
                <p>任天堂公布了《塞尔达传说：王国之泪》的发售日期...</p>
                <div class="post-meta">
                    <span>作者: 塞尔达粉丝</span>
                    <span>发布时间: 2023-01-03</span>
                </div>
            </div>
        </div>
    </div>

    <div class="sidebar">
        <div class="widget">
            <h3>游戏分类</h3>
            <ul>
                <li><a href="${pageContext.request.contextPath}/forum/action-games.jsp">动作游戏</a></li>
                <li><a href="${pageContext.request.contextPath}/post/game-reviews.jsp">游戏评测</a></li>
                <li><a href="${pageContext.request.contextPath}/post/upcoming-games.jsp">攻略分享</a></li>
            </ul>
        </div>
    </div>
</div>

<%@ include file="/include/footer.jsp" %>
</body>
</html>
