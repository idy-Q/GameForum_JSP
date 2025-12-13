<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <title>角色扮演 - 游戏论坛</title>
</head>
<body>
<%@ include file="/include/header.jsp" %>

<div class="container">
    <div class="row">
        <div class="col-lg-8">
            <div class="d-flex align-items-center mb-4 pb-2 border-bottom border-secondary">
                <h3 class="text-white mb-0"><i class="fas fa-dragon text-warning me-2"></i> 角色扮演</h3>
                <span class="ms-3 badge bg-dark border border-secondary text-muted">RPG Games</span>
            </div>

            <div class="posts-list">
                <c:if test="${not empty posts}">
                    <c:forEach items="${posts}" var="post">
                        <div class="card mb-3">
                            <div class="card-body">
                                <h5 class="card-title">
                                    <a href="${pageContext.request.contextPath}/postDetail?postId=${post.postId}" class="text-white text-decoration-none stretched-link">
                                            ${post.title}
                                    </a>
                                </h5>
                                <p class="card-text text-muted small mb-3">
                                        ${post.content.length() > 120 ? post.content.substring(0, 120).concat('...') : post.content}
                                </p>
                                <div class="d-flex justify-content-between align-items-center">
                                    <div class="d-flex align-items-center">
                                        <div class="bg-secondary rounded-circle d-flex justify-content-center align-items-center text-white me-2" style="width: 24px; height: 24px; font-size: 12px;">
                                                ${post.username.substring(0,1).toUpperCase()}
                                        </div>
                                        <small class="text-secondary">${post.username} · <fmt:formatDate value="${post.createdAt}" pattern="yyyy-MM-dd"/></small>
                                    </div>
                                    <div>
                                        <span class="badge bg-transparent text-danger border border-danger">
                                            <i class="fas fa-fire-alt"></i> ${post.likes}
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:if>

                <c:if test="${empty posts}">
                    <div class="text-center py-5">
                        <i class="fas fa-ghost fa-3x text-muted mb-3"></i>
                        <p class="text-muted">暂无 RPG 相关帖子，快来发表第一个吧！</p>
                        <a href="${pageContext.request.contextPath}/newPost" class="btn btn-primary btn-sm">去发帖</a>
                    </div>
                </c:if>

                <%@ include file="/include/pagination.jsp" %>
            </div>
        </div>

        <div class="col-lg-4">
            <div class="card widget mb-4">
                <div class="card-header bg-transparent border-secondary">
                    <h5 class="mb-0 text-white"><i class="fas fa-fire text-danger me-2"></i> 本版热搜</h5>
                </div>
                <ul class="list-group list-group-flush">
                    <c:choose>
                        <c:when test="${not empty trendingPosts}">
                            <c:forEach items="${trendingPosts}" var="trend" varStatus="status">
                                <li class="list-group-item bg-transparent border-secondary d-flex justify-content-between align-items-center px-3 py-3">
                                    <div class="d-flex align-items-center text-truncate" style="max-width: 80%;">
                                        <span class="badge ${status.index < 3 ? 'bg-warning text-dark' : 'bg-secondary'} me-2 rounded-pill" style="width: 25px;">${status.index + 1}</span>
                                        <a href="${pageContext.request.contextPath}/postDetail?postId=${trend.postId}" class="text-light text-decoration-none text-truncate">
                                                ${trend.title}
                                        </a>
                                    </div>
                                    <small class="text-danger fw-bold"><i class="fas fa-heart small"></i> ${trend.likes}</small>
                                </li>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <li class="list-group-item bg-transparent border-secondary text-muted text-center py-3">
                                暂无热搜数据
                            </li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>

            <div class="card bg-dark border-secondary">
                <div class="card-body text-center">
                    <h6 class="text-white mb-2">分享你的 RPG 冒险经历</h6>
                    <a href="${pageContext.request.contextPath}/newPost" class="btn btn-outline-primary w-100">
                        <i class="fas fa-plus"></i> 发布新帖
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="/include/footer.jsp" %>
</body>
</html>