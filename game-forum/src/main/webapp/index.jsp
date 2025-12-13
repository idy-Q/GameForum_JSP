<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
    // 后端逻辑保持不变
    com.forum.dao.CategoryDAO categoryDAO = new com.forum.dao.CategoryDAO();
    java.util.List<com.forum.model.Category> categories = categoryDAO.getAllCategories();
    request.setAttribute("categories", categories);

    com.forum.dao.PostDAO postDAO = new com.forum.dao.PostDAO();
    java.util.List<com.forum.model.Post> latestPosts = postDAO.getAllPosts();
    request.setAttribute("latestPosts", latestPosts);
%>

<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>游戏论坛 - 首页</title>
</head>
<body>
<%@ include file="include/header.jsp" %>

<div class="container">
    <c:if test="${param.success != null}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <i class="fas fa-check-circle"></i> ${param.success}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <div class="row">
        <div class="col-md-8">
            <h4 class="mb-4"><i class="fas fa-clock text-primary"></i> 最新动态</h4>

            <c:forEach var="post" items="${latestPosts}">
                <div class="card mb-3">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-center mb-2">
                            <span class="badge bg-secondary">${post.categoryName}</span>
                            <small class="text-muted"><fmt:formatDate value="${post.createdAt}" pattern="yyyy-MM-dd HH:mm"/></small>
                        </div>
                        <h5 class="card-title">
                            <a href="${pageContext.request.contextPath}/postDetail?postId=${post.postId}" class="text-white">
                                    ${post.title}
                            </a>
                        </h5>
                        <p class="card-text text-muted">
                                ${post.content.length() > 100 ? post.content.substring(0, 100).concat('...') : post.content}
                        </p>
                        <div class="d-flex justify-content-between align-items-center mt-3">
                            <div class="d-flex align-items-center">
                                <div class="bg-primary rounded-circle d-flex justify-content-center align-items-center text-white me-2" style="width: 30px; height: 30px;">
                                        ${post.username.substring(0,1).toUpperCase()}
                                </div>
                                <small class="text-muted">${post.username}</small>
                            </div>
                            <div>
                                <span class="text-danger me-2"><i class="fas fa-heart"></i> ${post.likes}</span>
                                <a href="${pageContext.request.contextPath}/postDetail?postId=${post.postId}" class="btn btn-sm btn-outline-primary">
                                    阅读全文
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>

            <c:if test="${empty latestPosts}">
                <div class="text-center py-5 text-muted">
                    <i class="fas fa-inbox fa-3x mb-3"></i>
                    <p>暂无任何帖子，快来抢沙发！</p>
                </div>
            </c:if>
        </div>

        <div class="col-md-4">
            <div class="card widget">
                <div class="card-header">
                    <i class="fas fa-th-large"></i> 游戏板块
                </div>
                <ul class="list-group list-group-flush bg-transparent">
                    <c:forEach var="category" items="${categories}">
                        <li class="list-group-item bg-transparent text-white border-secondary">
                            <a href="forum/<c:choose><c:when test="${category.categoryId == 1}">action-games</c:when><c:when test="${category.categoryId == 2}">rpg-games</c:when><c:when test="${category.categoryId == 3}">strategy-games</c:when><c:when test="${category.categoryId == 4}">casual-games</c:when><c:otherwise>#</c:otherwise></c:choose>" class="d-flex justify-content-between align-items-center">
                                    ${category.categoryName}
                                <span class="badge bg-primary rounded-pill"><i class="fas fa-chevron-right"></i></span>
                            </a>
                        </li>
                    </c:forEach>
                </ul>
            </div>

            <div class="card bg-primary text-white mt-4">
                <div class="card-body text-center">
                    <h5><i class="fas fa-bullhorn"></i> 何意味？</h5>
                    <p class="small">只是让它看起来没那么单调罢了</p>
                    <a href="${pageContext.request.contextPath}/newPost" class="btn btn-light btn-sm w-100 fw-bold text-primary">去发帖</a>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="include/footer.jsp" %>
</body>
</html>