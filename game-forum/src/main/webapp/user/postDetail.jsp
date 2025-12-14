<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <title>帖子详情 - 游戏论坛</title>
    <script src="https://cdn.jsdelivr.net/npm/marked/marked.min.js"></script>
    <style>
        /* 针对详情页的额外微调 */
        .post-content {
            font-size: 1.1rem; /* 正文稍微大一点，阅读更舒服 */
            line-height: 1.8;
            color: #e9ecef;    /* 确保正文内容也是亮色 */
        }
        /* 增加引用块的样式 */
        .post-content blockquote {
            border-left: 4px solid #5c9eff;
            padding-left: 1rem;
            color: #adb5bd;
            background-color: rgba(255,255,255,0.05);
            padding: 10px;
            border-radius: 4px;
        }
    </style>
</head>
<body>
<%@ include file="/include/header.jsp" %>

<div class="container">
    <c:if test="${param.error != null}">
        <div class="alert alert-danger my-4">${param.error}</div>
    </c:if>

    <div class="row justify-content-center">
        <div class="col-lg-10">
            <div class="card mb-4 mt-4">
                <div class="card-body p-4">
                    <h1 class="card-title display-6 mb-3 text-white fw-bold">${post.title}</h1>

                    <div class="d-flex align-items-center mb-4 text-muted border-bottom border-secondary pb-3">
                        <div class="bg-secondary rounded-circle d-flex justify-content-center align-items-center text-white me-2" style="width: 40px; height: 40px;">
                            ${post.username.substring(0,1).toUpperCase()}
                        </div>
                        <div class="me-auto">
                            <span class="d-block text-white fw-bold">${post.username}</span>
                            <small class="text-secondary"><i class="far fa-clock"></i> <fmt:formatDate value="${post.createdAt}" pattern="yyyy-MM-dd HH:mm"/></small>
                        </div>

                        <div class="text-end">
                            <button type="button" onclick="updateLike(${post.postId})" class="btn btn-outline-danger btn-sm">
                                <i class="fas fa-heart"></i> <span id="likeCountDisplay">${post.likes}</span>
                            </button>
                        </div>
                    </div>

                    <textarea id="raw-content" style="display:none;">${post.content}</textarea>
                    <div id="display-content" class="markdown-body post-content"></div>
                </div>
            </div>

            <div class="card mb-5">
                <div class="card-header bg-transparent border-secondary text-white">
                    <h5 class="mb-0"><i class="fas fa-comments text-primary me-2"></i> 评论 (${comments.size()})</h5>
                </div>
                <div class="card-body" id="comments-section">

                    <div id="comments-list">
                        <c:forEach var="comment" items="${comments}">
                            <div class="d-flex mb-3 border-bottom border-secondary pb-3 comment-item">
                                <div class="flex-shrink-0">
                                    <div class="bg-dark border border-secondary rounded-circle d-flex justify-content-center align-items-center text-muted" style="width: 35px; height: 35px;">
                                            ${comment.username.substring(0,1).toUpperCase()}
                                    </div>
                                </div>
                                <div class="flex-grow-1 ms-3">
                                    <div class="d-flex justify-content-between">
                                        <h6 class="mt-0 mb-1 text-primary fw-bold">${comment.username}</h6>
                                        <small class="text-muted"><fmt:formatDate value="${comment.createdAt}" pattern="yyyy-MM-dd HH:mm"/></small>
                                    </div>
                                    <p class="mb-0 text-light">${comment.content}</p>
                                </div>
                            </div>
                        </c:forEach>
                    </div>

                    <c:if test="${empty comments}">
                        <div id="no-comment-tip" class="text-center text-muted py-4">
                            <i class="far fa-comment-dots fa-2x mb-2"></i>
                            <p>暂无评论，来做第一个发言的人吧！</p>
                        </div>
                    </c:if>

                    <c:if test="${sessionScope.user != null}">
                        <div class="mt-4">
                            <form id="commentForm">
                                <input type="hidden" id="commentPostId" name="postId" value="${post.postId}">
                                <div class="mb-3">
                                    <textarea class="form-control bg-dark text-white border-secondary" id="commentContent" name="content" rows="3" placeholder="发表你的高见..." required></textarea>
                                </div>
                                <div class="text-end">
                                    <button type="button" onclick="submitComment()" class="btn btn-primary px-4">
                                        <i class="fas fa-paper-plane me-2"></i> 发送评论
                                    </button>
                                </div>
                            </form>
                        </div>
                    </c:if>

                    <c:if test="${sessionScope.user == null}">
                        <div class="alert alert-secondary mt-3 text-center bg-dark border-secondary text-muted">
                            <a href="login.jsp" class="fw-bold text-primary">登录</a> 后参与讨论
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="/include/footer.jsp" %>

<script>
    // 点赞脚本
    function updateLike(postId) {
        fetch('${pageContext.request.contextPath}/likePost?postId=' + postId, { method: 'POST' })
            .then(response => response.text())
            .then(newCount => {
                document.getElementById('likeCountDisplay').innerText = newCount;
                const btn = document.querySelector('.btn-outline-danger');
                btn.classList.add('active');
                setTimeout(() => btn.classList.remove('active'), 200);
            })
            .catch(error => console.error('Error:', error));
    }

    // 评论脚本
    function submitComment() {
        var content = document.getElementById("commentContent").value;
        var postId = document.getElementById("commentPostId").value;

        if (!content.trim()) {
            alert("请输入评论内容！");
            return;
        }

        fetch('${pageContext.request.contextPath}/addComment', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: 'postId=' + encodeURIComponent(postId) + '&content=' + encodeURIComponent(content)
        })
            .then(response => response.text())
            .then(result => {
                if (result === 'success') {
                    // 1. 清空输入框
                    document.getElementById("commentContent").value = '';
                    var noCommentTip = document.getElementById("no-comment-tip");
                    if (noCommentTip) noCommentTip.style.display = 'none';

                    // 2. 准备插入数据
                    var commentsList = document.getElementById("comments-list");
                    var username = "${sessionScope.user.username}";

                    // --- 核心修改：生成当前时间字符串 (yyyy-MM-dd HH:mm) ---
                    var now = new Date();
                    var timeStr = now.getFullYear() + "-" +
                        String(now.getMonth() + 1).padStart(2, '0') + "-" +
                        String(now.getDate()).padStart(2, '0') + " " +
                        String(now.getHours()).padStart(2, '0') + ":" +
                        String(now.getMinutes()).padStart(2, '0');
                    // ------------------------------------------------

                    // 3. 构建 HTML
                    var newHtml = `
                    <div class="d-flex mb-3 border-bottom border-secondary pb-3 comment-item">
                        <div class="flex-shrink-0">
                            <div class="bg-dark border border-secondary rounded-circle d-flex justify-content-center align-items-center text-muted" style="width: 35px; height: 35px;">
                                ` + username.substring(0,1).toUpperCase() + `
                            </div>
                        </div>
                        <div class="flex-grow-1 ms-3">
                            <div class="d-flex justify-content-between">
                                <h6 class="mt-0 mb-1 text-primary fw-bold">` + username + `</h6>
                                <%-- 使用生成的 timeStr 替换 '刚刚' --%>
                                <small class="text-muted">` + timeStr + `</small>
                            </div>
                            <p class="mb-0 text-light">` + content.replace(/</g, "&lt;").replace(/>/g, "&gt;") + `</p>
                        </div>
                    </div>
                `;

                    commentsList.insertAdjacentHTML('beforeend', newHtml);
                } else if (result === 'need_login') {
                    alert("请先登录！");
                    window.location.href = 'login.jsp';
                } else {
                    alert("评论失败");
                }
            })
            .catch(error => console.error('Error:', error));
    }

    // Markdown 渲染
    var rawContent = document.getElementById('raw-content').value;
    var htmlContent = marked.parse(rawContent);
    document.getElementById('display-content').innerHTML = htmlContent;
</script>

</body>
</html>