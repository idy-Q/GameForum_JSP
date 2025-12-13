<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="com.forum.dao.PostDAO" %>
<%@ page import="com.forum.model.Post" %>
<%@ page import="com.forum.model.User" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>

<%
    // 简单的逻辑：获取所有帖子，然后在前端筛选出属于当前用户的（无需修改后端代码即可实现展示）
    User currentUser = (User) session.getAttribute("user");
    List<Post> myPosts = new ArrayList<>();

    if (currentUser != null) {
        PostDAO postDAO = new PostDAO();
        List<Post> allPosts = postDAO.getAllPosts();
        for (Post p : allPosts) {
            if (p.getUserId() == currentUser.getUserId()) {
                myPosts.add(p);
            }
        }
    }
    request.setAttribute("myPosts", myPosts);
%>

<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <title>用户中心 - 游戏论坛</title>
</head>
<body>
<%@ include file="../include/header.jsp" %>

<div class="container">
    <c:if test="${sessionScope.user == null}">
        <div class="alert alert-danger text-center my-5">
            <i class="fas fa-exclamation-circle"></i> 请先登录查看个人中心
        </div>
        <script>
            setTimeout(function() { window.location.href = '../login.jsp'; }, 2000);
        </script>
    </c:if>

    <c:if test="${sessionScope.user != null}">
        <div class="row">
            <div class="col-md-4 mb-4">
                <div class="card widget h-100">
                    <div class="card-body text-center py-5">
                        <div class="bg-primary rounded-circle d-flex justify-content-center align-items-center text-white mx-auto mb-3 shadow-lg"
                             style="width: 100px; height: 100px; font-size: 40px; border: 4px solid #2c3036;">
                                ${sessionScope.user.username.substring(0,1).toUpperCase()}
                        </div>

                        <h3 class="card-title text-white mb-1">${sessionScope.user.username}</h3>
                        <p class="text-muted mb-4">${sessionScope.user.role == 'admin' ? '<span class="badge bg-warning text-dark"><i class="fas fa-shield-alt"></i> 管理员</span>' : '<span class="badge bg-secondary">普通用户</span>'}</p>

                        <hr class="border-secondary my-4">

                        <div class="text-start px-3">
                            <div class="mb-3">
                                <small class="text-muted d-block text-uppercase fw-bold mb-1">电子邮箱</small>
                                <div class="text-light"><i class="fas fa-envelope text-primary me-2"></i> ${sessionScope.user.email}</div>
                            </div>
                            <div>
                                <small class="text-muted d-block text-uppercase fw-bold mb-1">发帖统计</small>
                                <div class="text-light"><i class="fas fa-pen text-primary me-2"></i> 共发布 ${myPosts.size()} 篇帖子</div>
                            </div>
                        </div>

                        <div class="mt-5">
                            <a href="${pageContext.request.contextPath}/newPost" class="btn btn-primary w-100 mb-2">
                                <i class="fas fa-plus"></i> 发布新帖
                            </a>
                            <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-danger w-100">
                                <i class="fas fa-sign-out-alt"></i> 退出登录
                            </a>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-8">
                <div class="card widget mb-4">
                    <div class="card-header bg-transparent border-secondary d-flex justify-content-between align-items-center">
                        <h5 class="mb-0 text-white"><i class="fas fa-history text-success me-2"></i> 我的发帖记录</h5>
                    </div>
                </div>

                <c:if test="${not empty myPosts}">
                    <div class="posts-list">
                        <c:forEach var="post" items="${myPosts}">
                            <div class="card mb-3">
                                <div class="card-body">
                                    <div class="d-flex justify-content-between align-items-center mb-2">
                                        <span class="badge bg-dark border border-secondary text-muted">${post.categoryName}</span>
                                        <small class="text-muted"><fmt:formatDate value="${post.createdAt}" pattern="yyyy-MM-dd HH:mm"/></small>
                                    </div>
                                    <h5 class="card-title">
                                        <a href="${pageContext.request.contextPath}/postDetail?postId=${post.postId}" class="text-white text-decoration-none stretched-link">
                                                ${post.title}
                                        </a>
                                    </h5>
                                    <p class="card-text text-muted small">
                                            ${post.content.length() > 80 ? post.content.substring(0, 80).concat('...') : post.content}
                                    </p>
                                    <div class="d-flex justify-content-end">
                                        <span class="text-danger small"><i class="fas fa-heart"></i> ${post.likes}</span>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:if>

                <c:if test="${empty myPosts}">
                    <div class="card border-0 bg-transparent text-center py-5">
                        <div class="card-body">
                            <i class="fas fa-scroll fa-4x text-muted mb-3" style="opacity: 0.3;"></i>
                            <h5 class="text-white">暂无发帖记录</h5>
                            <p class="text-muted">你还没有发布过任何内容，去分享你的第一篇帖子吧！</p>
                            <a href="${pageContext.request.contextPath}/newPost" class="btn btn-outline-primary mt-2">
                                去创作
                            </a>
                        </div>
                    </div>
                </c:if>
            </div>
        </div>
    </c:if>
</div>

<%@ include file="../include/footer.jsp" %>
</body>
</html>