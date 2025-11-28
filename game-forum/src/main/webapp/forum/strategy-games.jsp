<!-- strategy-games.jsp -->
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
                <!-- 这里将从数据库获取策略游戏相关的帖子 -->
                <div class="post-item">
                    <h3><a href="#">《文明7》开发进展报告</a></h3>
                    <p>官方公布了《文明7》的最新开发进展和特色功能...</p>
                    <div class="post-meta">
                        <span>作者: 文明系列粉丝</span>
                        <span>发布时间: 2023-01-05</span>
                    </div>
                </div>
                
                <div class="post-item">
                    <h3><a href="#">《全面战争：战锤3》战术分享</a></h3>
                    <p>高手玩家分享《全面战争：战锤3》的实战战术...</p>
                    <div class="post-meta">
                        <span>作者: 战术大师</span>
                        <span>发布时间: 2023-01-06</span>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="sidebar">
            <div class="widget">
                <h3>话题</h3>
                <ul>
                    <li><a href="#">战术研究</a></li>
                    <li><a href="#">MOD分享</a></li>
                    <li><a href="#">战役复盘</a></li>
                </ul>
            </div>
        </div>
    </div>
    
    <%@ include file="/include/footer.jsp" %>
</body>
</html>
