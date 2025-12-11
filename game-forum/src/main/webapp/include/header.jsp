<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/style.css">

<div class="header">
    <div class="container">
        <h1><a href="<%= request.getContextPath() %>/index.jsp">游戏论坛</a></h1>
        <nav>
            <ul>
                <li><a href="<%= request.getContextPath() %>/index.jsp">首页</a></li>
                <c:if test="${sessionScope.user != null}">
                    <li><a href="<%= request.getContextPath() %>/newPost">发表帖子</a></li>
                    <c:if test="${sessionScope.user.role == 'admin'}">
                        <li><a href="<%= request.getContextPath() %>/admin/">管理员面板</a></li>
                    </c:if>
                </c:if>
            </ul>
        </nav>

        <div class="search-box" style="margin: 0 20px;">
            <form action="<%= request.getContextPath() %>/search" method="get" style="display: flex;">
                <input type="text" name="keyword" placeholder="搜索帖子..." required
                       style="padding: 5px 10px; border-radius: 4px 0 0 4px; border: 1px solid #ddd; border-right: none; outline: none;">
                <button type="submit"
                        style="padding: 5px 15px; border-radius: 0 4px 4px 0; border: 1px solid #ddd; background: #007bff; color: white; cursor: pointer;">
                    搜
                </button>
            </form>
        </div>

        <div class="user-info">
            <c:choose>
                <c:when test="${sessionScope.user != null}">
                    欢迎，${sessionScope.user.username} |
                    <a href="<%= request.getContextPath() %>/logout">退出</a>
                </c:when>
                <c:otherwise>
                    <a href="<%= request.getContextPath() %>/login.jsp">登录</a> |
                    <a href="<%= request.getContextPath() %>/register.jsp">注册</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>