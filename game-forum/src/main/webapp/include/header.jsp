<%-- src/main/webapp/include/header.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">

<nav class="navbar navbar-expand-lg navbar-dark fixed-top">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/index.jsp">
            <i class="fas fa-gamepad"></i> 游戏论坛
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/index.jsp"><i class="fas fa-home"></i> 首页</a>
                </li>
                <c:if test="${sessionScope.user != null}">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/newPost"><i class="fas fa-edit"></i> 发帖</a>
                    </li>
                    <c:if test="${sessionScope.user.role == 'admin'}">
                        <li class="nav-item">
                            <a class="nav-link text-warning" href="${pageContext.request.contextPath}/admin/"><i class="fas fa-shield-alt"></i> 管理面板</a>
                        </li>
                    </c:if>
                </c:if>
            </ul>

            <form class="d-flex me-3" action="${pageContext.request.contextPath}/search" method="get">
                <div class="input-group">
                    <input type="text" name="keyword" class="form-control search-input" placeholder="搜索帖子..." required>
                    <button class="btn btn-outline-primary" type="submit"><i class="fas fa-search"></i></button>
                </div>
            </form>

            <%-- src/main/webapp/include/header.jsp 的一部分 --%>
            <ul class="navbar-nav align-items-center"> <c:choose>
                <c:when test="${sessionScope.user != null}">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-bs-toggle="dropdown">
                            <i class="fas fa-user-circle"></i> ${sessionScope.user.username}
                        </a>
                        <ul class="dropdown-menu dropdown-menu-dark dropdown-menu-end">
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/user/dashboard.jsp">个人中心</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/logout">退出登录</a></li>
                        </ul>
                    </li>
                </c:when>
                <c:otherwise>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/login.jsp">登录</a>
                    </li>
                    <li class="nav-item">
                        <a class="btn btn-primary btn-sm ms-3" href="${pageContext.request.contextPath}/register.jsp" style="padding: 0.375rem 1rem;">注册</a>
                    </li>
                </c:otherwise>
            </c:choose>
            </ul>
        </div>
    </div>
</nav>

<div style="height: 20px;"></div>