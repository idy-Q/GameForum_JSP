<!-- strategy-guide.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>攻略分享 - 游戏论坛</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<%@ include file="/include/header.jsp" %>

<div class="container main-content">
    <div class="content">
        <h2>攻略分享</h2>

        <div class="posts-list">
            <div class="post-item">
                <h3><a href="#">《艾尔登法环》全BOSS打法攻略</a></h3>
                <p>详细解析FromSoftware经典作品中每个BOSS的打法技巧...</p>
                <div class="post-meta">
                    <span>作者: 法环大师</span>
                    <span>发布时间: 2023-01-15</span>
                </div>
            </div>

            <div class="post-item">
                <h3><a href="#">《原神》须弥地区解谜全攻略</a></h3>
                <p>为旅行者们整理了须弥地区的所有解谜要素和收集路线...</p>
                <div class="post-meta">
                    <span>作者: 原神攻略组</span>
                    <span>发布时间: 2023-01-12</span>
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
                <li><a href="${pageContext.request.contextPath}/post/game-reviews.jsp">游戏评测</a></li>
            </ul>
        </div>
    </div>
</div>

<%@ include file="/include/footer.jsp" %>
</body>
</html>
