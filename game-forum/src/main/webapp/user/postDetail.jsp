<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>帖子详情 - 游戏论坛</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">

    <script src="https://cdn.jsdelivr.net/npm/marked/marked.min.js"></script>

    <style>
        /* 简单的 Markdown 内容样式优化 */
        .markdown-body {
            line-height: 1.8;
            font-size: 16px;
        }
        .markdown-body h1, .markdown-body h2 { border-bottom: 1px solid #eaecef; padding-bottom: .3em; }
        .markdown-body blockquote { border-left: 4px solid #dfe2e5; color: #6a737d; padding-left: 1em; margin-left: 0; }
        .markdown-body code { background-color: rgba(27,31,35,.05); border-radius: 3px; padding: .2em .4em; }
        .markdown-body img { max-width: 100%; border-radius: 4px; }
        .markdown-body pre { background: #f6f8fa; padding: 16px; border-radius: 4px; overflow: auto; }
    </style>
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
                    fetch('${pageContext.request.contextPath}/likePost?postId=' + postId, { method: 'POST' })
                        .then(response => response.text())
                        .then(newCount => {
                            document.getElementById('likeCountDisplay').innerText = '❤ 热度: ' + newCount;
                        })
                        .catch(error => console.error('Error:', error));
                }
            </script>
        </div>

        <div class="post-content">
            <textarea id="raw-content" style="display:none;">${post.content}</textarea>

            <div id="display-content" class="markdown-body"></div>
        </div>
    </div>

    <div class="comments-section">
        <h3>评论 (${comments.size()})</h3>

        <div id="comments-list">
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
        </div>

        <c:if test="${empty comments}">
            <p id="no-comment-tip">暂无评论</p>
        </c:if>

        <c:if test="${sessionScope.user != null}">
            <div class="comment-form" style="margin-top: 20px;">
                <h4>发表评论</h4>
                <form id="commentForm">
                    <input type="hidden" id="commentPostId" name="postId" value="${param.postId}">
                    <div class="form-group">
                        <textarea id="commentContent" name="content" rows="4" placeholder="请输入您的评论..." required></textarea>
                    </div>
                    <div class="form-group">
                        <button type="button" onclick="submitComment()">发表评论</button>
                    </div>
                </form>
            </div>
        </c:if>

        <c:if test="${sessionScope.user == null}">
            <p><a href="login.jsp">登录</a> 后可以发表评论</p>
        </c:if>
    </div>

    <script>
        function submitComment() {
            var content = document.getElementById("commentContent").value;
            var postId = document.getElementById("commentPostId").value;

            if (!content.trim()) {
                alert("请输入评论内容！");
                return;
            }

            // 使用 fetch 发送 AJAX 请求
            fetch('${pageContext.request.contextPath}/addComment', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                // 拼接表单数据
                body: 'postId=' + encodeURIComponent(postId) + '&content=' + encodeURIComponent(content)
            })
                .then(response => response.text())
                .then(result => {
                    if (result === 'success') {
                        // 1. 清空输入框
                        document.getElementById("commentContent").value = '';

                        // 2. 隐藏"暂无评论"提示
                        var noCommentTip = document.getElementById("no-comment-tip");
                        if (noCommentTip) noCommentTip.style.display = 'none';

                        // 3. 动态创建一个新评论的 HTML 元素并追加到列表底部
                        var commentsList = document.getElementById("comments-list");
                        var newCommentDiv = document.createElement("div");
                        newCommentDiv.className = "comment-item";

                        // 获取当前时间
                        // var now = new Date().toLocaleString();
                        // 获取当前用户名 (JSP渲染时填入)
                        var username = "${sessionScope.user.username}";

                        newCommentDiv.innerHTML =
                            '<div class="comment-header">' +
                            '<strong>' + username + '</strong>' +
                            // '<span class="comment-date">' + now + '</span>' +
                            '</div>' +
                            '<div class="comment-content">' +
                            '<p>' + content.replace(/</g, "&lt;").replace(/>/g, "&gt;") + '</p>' + // 简单防注入
                            '</div>';

                        commentsList.appendChild(newCommentDiv);

                    } else if (result === 'need_login') {
                        alert("请先登录！");
                        window.location.href = 'login.jsp';
                    } else {
                        alert("评论失败，请重试");
                    }
                })
                .catch(error => console.error('Error:', error));
        }
    </script>
</div>

<%@ include file="/include/footer.jsp" %>

<script>
    // 获取原始 Markdown 内容
    var rawContent = document.getElementById('raw-content').value;
    // 使用 marked 库进行转换
    var htmlContent = marked.parse(rawContent);
    // 注入到显示区域
    document.getElementById('display-content').innerHTML = htmlContent;
</script>

</body>
</html>