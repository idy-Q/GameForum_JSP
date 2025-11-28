<!-- include/header.jsp -->
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
                    <li><a href="newPost">发表帖子</a></li>
                    <c:if test="${sessionScope.user.role == 'admin'}">
                        <li><a href="<%= request.getContextPath() %>/admin/">管理员面板</a></li>
                    </c:if>
                </c:if>
            </ul>
        </nav>
        <div class="user-info">
            <c:choose>
                <c:when test="${sessionScope.user != null}">
                    欢迎，${sessionScope.user.username} |
                    <a href="logout">退出</a>
                </c:when>
                <c:otherwise>
                    <a href="login.jsp">登录</a> |
                    <a href="register.jsp">注册</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>
