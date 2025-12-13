<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <title>搜索结果: ${searchKeyword} - 游戏论坛</title>
</head>
<body>
<%@ include file="include/header.jsp" %>

<div class="container">
    <div class="row">
        <div class="col-lg-8">
            <div class="mb-4 pb-2 border-bottom border-secondary">
                <h4 class="text-white mb-0">
                    <i class="fas fa-search text-primary me-2"></i> 搜索结果:
                    <span class="text-warning fw-bold">"${searchKeyword}"</span>
                </h4>
                <small class="text-muted">共找到 ${posts.size()} 条相关结果</small>
            </div>

            <div class="posts-list">
                <c:if test="${not empty posts}">
                    <c:forEach items="${posts}" var="post">
                        <div class="card mb-3">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-center mb-2">
                                    <span class="badge bg-dark border border-secondary text-muted">
                                        帖子
                                    </span>
                                    <small class="text-muted"><fmt:formatDate value="${post.createdAt}" pattern="yyyy-MM-dd HH:mm"/></small>
                                </div>
                                <h5 class="card-title">
                                    <a href="${pageContext.request.contextPath}/postDetail?postId=${post.postId}" class="text-white text-decoration-none stretched-link">
                                            ${post.title}
                                    </a>
                                </h5>
                                <p class="card-text text-muted small mb-3">
                                        ${post.content.length() > 100 ? post.content.substring(0, 100).concat('...') : post.content}
                                </p>
                                <div class="d-flex justify-content-between align-items-center">
                                    <div class="d-flex align-items-center">
                                        <div class="bg-secondary rounded-circle d-flex justify-content-center align-items-center text-white me-2" style="width: 24px; height: 24px; font-size: 12px;">
                                                ${post.username.substring(0,1).toUpperCase()}
                                        </div>
                                        <small class="text-secondary">${post.username}</small>
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
                    <div class="card border-0 bg-transparent text-center py-5">
                        <div class="card-body">
                            <i class="fas fa-search-minus fa-4x text-muted mb-4" style="opacity: 0.3;"></i>
                            <h5 class="text-white">未找到相关内容</h5>
                            <p class="text-muted">抱歉，我们没有找到与 "<strong>${searchKeyword}</strong>" 相关的帖子。</p>
                            <div class="mt-4">
                                <a href="index.jsp" class="btn btn-outline-secondary btn-sm me-2">返回首页</a>
                                <a href="newPost" class="btn btn-primary btn-sm">发布新帖</a>
                            </div>
                        </div>
                    </div>
                </c:if>
            </div>
        </div>

        <div class="col-lg-4">
            <div class="card widget mb-4">
                <div class="card-header bg-transparent border-secondary">
                    <h5 class="mb-0 text-white"><i class="fas fa-compass text-info me-2"></i> 快捷导航</h5>
                </div>
                <ul class="list-group list-group-flush">
                    <li class="list-group-item bg-transparent border-secondary">
                        <a href="index.jsp" class="d-block text-muted py-1">
                            <i class="fas fa-home me-2"></i> 返回首页
                        </a>
                    </li>
                    <li class="list-group-item bg-transparent border-secondary">
                        <a href="newPost" class="d-block text-muted py-1">
                            <i class="fas fa-pen-fancy me-2"></i> 发布新帖
                        </a>
                    </li>
                </ul>
            </div>

            <div class="card bg-dark border-secondary">
                <div class="card-body">
                    <h6 class="text-white mb-3"><i class="far fa-lightbulb text-warning me-2"></i> 搜索小贴士</h6>
                    <ul class="text-muted small ps-3 mb-0">
                        <li class="mb-1">检查输入的关键字是否有错别字</li>
                        <li class="mb-1">尝试使用更通用的词汇</li>
                        <li>可以是游戏名、攻略关键词等</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="include/footer.jsp" %>
</body>
</html>