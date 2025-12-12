<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>发表帖子 - 游戏论坛</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/simplemde/latest/simplemde.min.css">
    <style>
        /* 微调编辑器样式，让它和我们的表单更融合 */
        .CodeMirror, .CodeMirror-scroll {
            min-height: 300px;
            max-height: 500px;
        }
    </style>
</head>
<body>
<%@ include file="../include/header.jsp" %>

<div class="container">
    <c:if test="${sessionScope.user == null}">
        <div class="alert alert-error">请先登录</div>
        <script>
            setTimeout(function() {
                window.location.href = 'login.jsp';
            }, 2000);
        </script>
    </c:if>

    <c:if test="${sessionScope.user != null}">
        <div class="form-container" style="max-width: 800px;"> <h2>发表新帖子</h2>

            <c:if test="${param.error != null}">
                <div class="alert alert-error">${param.error}</div>
            </c:if>

            <form action="${pageContext.request.contextPath}/createPost" method="post">
                <div class="form-group">
                    <label for="title">标题:</label>
                    <input type="text" id="title" name="title" required placeholder="请输入引人注目的标题">
                </div>

                <div class="form-group">
                    <label for="categoryId">选择板块:</label>
                    <select id="categoryId" name="categoryId" required>
                        <option value="">请选择板块</option>
                        <c:forEach var="category" items="${categories}">
                            <option value="${category.categoryId}">${category.categoryName}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="form-group">
                    <label for="content">内容 (支持 Markdown):</label>
                    <textarea id="content" name="content"></textarea>
                </div>

                <div class="form-group">
                    <button type="submit">发表帖子</button>
                    <button type="button" onclick="window.history.back()" style="background-color: #6c757d; margin-top: 10px;">取消</button>
                </div>
            </form>
        </div>
    </c:if>
</div>

<%@ include file="/include/footer.jsp" %>

<script src="https://cdn.jsdelivr.net/simplemde/latest/simplemde.min.js"></script>
<script>
    // 3. 初始化编辑器
    var simplemde = new SimpleMDE({
        element: document.getElementById("content"),
        placeholder: "在这里输入内容... 支持 **加粗**、列表、引用等 Markdown 语法",
        spellChecker: false, // 关掉英文拼写检查，避免中文一片红线
        status: false, // 隐藏底部状态栏
        autosave: {
            enabled: true,
            uniqueId: "MyUniqueID",
            delay: 1000,
        },
    });
</script>
</body>
</html>