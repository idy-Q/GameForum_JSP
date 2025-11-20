<!-- rpg-games.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>角色扮演 - 游戏论坛</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <%@ include file="/include/header.jsp" %>
    
    <div class="container main-content">
        <div class="content">
            <h2>角色扮演</h2>
            
            <div class="posts-list">
                <!-- 这里将从数据库获取RPG相关的帖子 -->
                <div class="post-item">
                    <h3><a href="#">《最终幻想16》角色分析</a></h3>
                    <p>深入分析《最终幻想16》主要角色的性格发展...</p>
                    <div class="post-meta">
                        <span>作者: FF粉丝</span>
                        <span>发布时间: 2023-01-03</span>
                    </div>
                </div>
                
                <div class="post-item">
                    <h3><a href="#">《博德之门3》多人联机心得</a></h3>
                    <p>分享《博德之门3》多人合作模式的游戏体验...</p>
                    <div class="post-meta">
                        <span>作者: DND爱好者</span>
                        <span>发布时间: 2023-01-04</span>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="sidebar">
            <div class="widget">
                <h3>热门话题</h3>
                <ul>
                    <li><a href="#">角色培养</a></li>
                    <li><a href="#">剧情讨论</a></li>
                    <li><a href="#">装备收集</a></li>
                </ul>
            </div>
        </div>
    </div>
    
    <%@ include file="/include/footer.jsp" %>
</body>
</html>
