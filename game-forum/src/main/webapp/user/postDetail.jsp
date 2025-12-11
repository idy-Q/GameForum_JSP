<!-- postDetail.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>帖子详情 - 游戏论坛</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
<%@ include file="/include/header.jsp" %>

<div class="container">
    <c:if test="${param.error != null}">
        <div class="alert alert-error">${param.error}</div>
    </c:if>

    <div class="post-detail">
        <h2>${post.title}</h2>
        <div class="post-meta">
            <span>作者: ${post.username}</span>
            <span>发布时间: <fmt:formatDate value="${post.createdAt}" pattern="yyyy-MM-dd HH:mm:ss"/></span>

            <span id="likeCountDisplay" style="margin-left: 20px; color: #ff6b6b; font-weight: bold;">
                ❤ 热度: ${post.likes}
            </span>

            <button type="button" onclick="updateLike(${post.postId})"
                    style="margin-left: 10px; padding: 2px 8px; cursor: pointer; background: #ff6b6b; color: white; border: none; border-radius: 4px;">
                👍 点赞
            </button>

            <script>
                function updateLike(postId) {
                    // 使用 fetch 发送异步 POST 请求
                    fetch('${pageContext.request.contextPath}/likePost?postId=' + postId, {
                        method: 'POST'
                    })
                        .then(response => response.text()) // 接收后端传回来的纯文本（新的点赞数）
                        .then(newCount => {
                            // 找到显示数字的 span，直接修改它的文字内容
                            document.getElementById('likeCountDisplay').innerText = '❤ 热度: ' + newCount;
                        })
                        .catch(error => console.error('Error:', error));
                }
            </script>
        </div>
        <div class="post-content">
            <p>${post.content}</p>
        </div>
    </div>

    <div class="comments-section">
        <h3>评论 (${comments.size()})</h3>

        <c:forEach var="comment" items="${comments}">
            <div class="comment-item">
                <div class="comment-header">
                    <strong>${comment.username}</strong>
                    <span class="comment-date"><fmt:formatDate value="${comment.createdAt}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
                </div>
                <div class="comment-content">
                    <p>${comment.content}</p>
                </div>
            </div>
        </c:forEach>

        <c:if test="${empty comments}">
            <p>暂无评论</p>
        </c:if>

        <c:if test="${sessionScope.user != null}">
            <div class="comment-form">
                <h4>发表评论</h4>
                <form action="addComment" method="post">
                    <input type="hidden" name="postId" value="${param.postId}">
                    <div class="form-group">
                        <textarea name="content" rows="4" placeholder="请输入您的评论..." required></textarea>
                    </div>
                    <div class="form-group">
                        <button type="submit">发表评论</button>
                    </div>
                </form>
            </div>
        </c:if>

        <c:if test="${sessionScope.user == null}">
            <p><a href="login.jsp">登录</a> 后可以发表评论</p>
        </c:if>
    </div>
</div>

<%@ include file="/include/footer.jsp" %>
</body>
</html>
