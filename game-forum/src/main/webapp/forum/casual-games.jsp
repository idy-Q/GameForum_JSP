<!-- casual-games.jsp -->
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
                <!-- 这里将从数据库获取休闲游戏相关的帖子 -->
                <div class="post-item">
                    <h3><a href="#">《原神》每日任务攻略</a></h3>
                    <p>每日委托任务快速完成指南，助你轻松获取原石...</p>
                    <div class="post-meta">
                        <span>作者: 旅行者</span>
                        <span>发布时间: 2023-01-07</span>
                    </div>
                </div>
                
                <div class="post-item">
                    <h3><a href="#">《糖豆人》新赛季皮肤推荐</a></h3>
                    <p>新赛季限定皮肤外观展示和获取方式介绍...</p>
                    <div class="post-meta">
                        <span>作者: 糖豆人专家</span>
                        <span>发布时间: 2023-01-08</span>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="sidebar">
            <div class="widget">
                <h3>热门话题</h3>
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
