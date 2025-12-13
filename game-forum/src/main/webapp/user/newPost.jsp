<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>发表新帖 - 游戏论坛</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/simplemde/latest/simplemde.min.css">

    <style>
        /* === SimpleMDE 编辑器深色模式深度适配 === */

        /* 1. 工具栏背景变深 */
        .editor-toolbar {
            background-color: #24272b;
            border-color: #343a40;
            opacity: 1;
        }

        /* 2. 工具栏图标颜色变亮 */
        .editor-toolbar a {
            color: #adb5bd !important;
        }
        .editor-toolbar a:hover, .editor-toolbar a.active {
            background-color: #343a40;
            border-color: #343a40;
            color: #fff !important;
        }

        /* 3. 编辑区域黑底白字 */
        .CodeMirror {
            background-color: #16191d;
            border-color: #343a40;
            color: #e9ecef;
            min-height: 450px;
            font-size: 16px;
            line-height: 1.6;
        }

        /* === 核心修复：彻底“删除”（隐藏）所有滚动条 === */
        .CodeMirror-scroll {
            /* 1. 强制隐藏水平滚动条 */
            overflow-x: hidden !important;
            margin-bottom: 0 !important;
            padding-bottom: 0 !important;

            /* 2. 针对 Firefox 隐藏滚动条 */
            scrollbar-width: none !important;

            /* 3. 针对 IE/Edge 旧版隐藏 */
            -ms-overflow-style: none !important;
        }

        /* 4. 针对 Chrome/Safari/Edge 新版隐藏滚动条 */
        .CodeMirror-scroll::-webkit-scrollbar {
            display: none !important; /* 彻底移除，不占空间 */
            width: 0 !important;
            height: 0 !important;
        }

        /* 额外保险：如果 CodeMirror 使用了模拟滚动条，也强制隐藏 */
        .CodeMirror-vscrollbar, .CodeMirror-hscrollbar {
            display: none !important;
        }

        /* 5. 底部状态栏 */
        .editor-statusbar {
            color: #6c757d;
            border-top: 1px solid #343a40;
            background-color: #24272b;
        }

        /* 6. 预览模式下的背景 */
        .editor-preview {
            background-color: #24272b;
            color: #e9ecef;
            border-color: #343a40;
        }
        .editor-preview-side {
            background-color: #24272b;
            color: #e9ecef;
            border-color: #343a40;
        }

        /* 7. 光标颜色 */
        .CodeMirror-cursor {
            border-left: 1px solid #fff !important;
        }

        /* 8. 全屏模式层级修正 */
        .editor-toolbar.fullscreen, .CodeMirror-fullscreen {
            z-index: 1050;
        }
    </style>
</head>
<body>
<%@ include file="../include/header.jsp" %>

<div class="container">
    <c:if test="${sessionScope.user == null}">
        <div class="alert alert-danger text-center my-5">
            <i class="fas fa-exclamation-triangle me-2"></i> 请先登录后再发帖
        </div>
        <script>
            setTimeout(function() {
                window.location.href = 'login.jsp';
            }, 2000);
        </script>
    </c:if>

    <c:if test="${sessionScope.user != null}">
        <div class="row justify-content-center">
            <div class="col-lg-10">

                <div class="card shadow-lg border-0" style="background-color: var(--bg-card);">
                    <div class="card-body p-4">
                        <div class="d-flex align-items-center mb-4 pb-3 border-bottom border-secondary">
                            <i class="fas fa-pen-nib fa-2x text-primary me-3"></i>
                            <div>
                                <h3 class="mb-0 text-white">发布新主题</h3>
                                <small class="text-muted">分享你的游戏心得、攻略或趣事</small>
                            </div>
                        </div>

                        <c:if test="${param.error != null}">
                            <div class="alert alert-danger mb-4">${param.error}</div>
                        </c:if>

                        <form action="${pageContext.request.contextPath}/createPost" method="post">
                            <div class="mb-4">
                                <label for="title" class="form-label text-muted small text-uppercase fw-bold">帖子标题</label>
                                <input type="text" id="title" name="title" class="form-control form-control-lg bg-dark text-white border-secondary fw-bold"
                                       placeholder="请输入一个引人注目的标题..." required style="font-size: 1.25rem;">
                            </div>

                            <div class="mb-4">
                                <label for="categoryId" class="form-label text-muted small text-uppercase fw-bold">选择板块</label>
                                <select id="categoryId" name="categoryId" class="form-select bg-dark text-white border-secondary" required>
                                    <option value="" selected disabled>请选择归属板块...</option>
                                    <c:forEach var="category" items="${categories}">
                                        <option value="${category.categoryId}">${category.categoryName}</option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="mb-4">
                                <label for="content" class="form-label text-muted small text-uppercase fw-bold">内容 (支持 Markdown)</label>
                                <textarea id="content" name="content"></textarea>
                            </div>

                            <div class="d-flex justify-content-between align-items-center mt-4">
                                <button type="button" onclick="window.history.back()" class="btn btn-outline-secondary px-4">
                                    <i class="fas fa-arrow-left me-1"></i> 取消
                                </button>
                                <button type="submit" class="btn btn-primary btn-lg px-5">
                                    <i class="fas fa-paper-plane me-2"></i> 发布帖子
                                </button>
                            </div>
                        </form>
                    </div>
                </div>

                <div class="text-center mt-3 text-muted small">
                    <i class="fab fa-markdown"></i> 本编辑器支持 Markdown 语法
                </div>

            </div>
        </div>
    </c:if>
</div>

<%@ include file="/include/footer.jsp" %>

<script src="https://cdn.jsdelivr.net/simplemde/latest/simplemde.min.js"></script>
<script>
    var simplemde = new SimpleMDE({
        element: document.getElementById("content"),
        placeholder: "在这里开始你的创作... \n\n支持 **加粗**、列表、引用等 Markdown 语法",
        spellChecker: false,
        status: ["lines", "words"],
        autosave: {
            enabled: true,
            uniqueId: "NewPost_Draft",
            delay: 1000,
        },
    });
</script>
</body>
</html>