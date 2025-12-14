<!-- admin/managePosts.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>帖子管理 - 游戏论坛</title>
    <link rel="stylesheet" type="text/css" href="../../../css/style.css">
    <style>
        .pagination {
            margin: 20px 0;
            text-align: center;
        }
        .pagination a, .pagination span {
            display: inline-block;
            padding: 8px 16px;
            margin: 0 4px;
            text-decoration: none;
            border: 1px solid #ddd;
            color: #007cba;
        }
        .pagination a:hover {
            background-color: #f5f5f5;
        }
        .pagination .current {
            background-color: #007cba;
            color: white;
            border: 1px solid #007cba;
        }
        .pagination .disabled {
            color: #ccc;
            cursor: not-allowed;
        }
    </style>
</head>
<body>
<%@ include file="../../../include/header.jsp" %>

<div class="admin-container">
    <c:if test="${sessionScope.user == null || sessionScope.user.role != 'admin'}">
        <div class="alert alert-error">权限不足</div>
        <script>
            setTimeout(function() {
                window.location.href = '../../../index.jsp';
            }, 2000);
        </script>
    </c:if>

    <c:if test="${sessionScope.user != null && sessionScope.user.role == 'admin'}">
        <h2 class="admin-heading">帖子管理</h2>

        <!-- 添加显示总帖子数 -->
        <div style="margin-bottom: 15px; padding: 10px; background-color: var(--bg-card);
             border: 1px solid var(--border-color); border-radius: 4px;">
            <strong>总帖子数:</strong> ${totalPosts} 篇
        </div>

        <!-- 显示操作结果消息 -->
        <c:if test="${not empty param.message}">
            <div class="alert alert-success">${param.message}</div>
        </c:if>
        <c:if test="${not empty param.error}">
            <div class="alert alert-error">${param.error}</div>
        </c:if>

        <table class="admin-table">
            <thead>
            <tr>
                <th>ID</th>
                <th>标题</th>
                <th>作者</th>
                <th>板块</th>
                <th>发布时间</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="post" items="${posts}">
                <tr>
                    <td>${post.postId}</td>
                    <td><a href="<%= request.getContextPath() %>/postDetail?postId=${post.postId}" target="_blank">${post.title}</a></td>
                    <td>${post.username}</td>
                    <td>${post.categoryName}</td>
                    <td>${post.createdAt}</td>
                    <td>
                        <a href="#" onclick="deletePost(${post.postId})" style="color: red;">删除</a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>

        <!-- 分页导航 -->
        <c:if test="${totalPages > 1}">
            <div class="pagination">
                <c:if test="${currentPage > 1}">
                    <a href="?page=1">&laquo; 首页</a>
                    <a href="?page=${currentPage - 1}">&lt; 上一页</a>
                </c:if>
                <c:if test="${currentPage <= 1}">
                    <span class="disabled">&laquo; 首页</span>
                    <span class="disabled">&lt; 上一页</span>
                </c:if>

                <c:forEach var="i" begin="1" end="${totalPages}">
                    <c:choose>
                        <c:when test="${i == currentPage}">
                            <span class="current">${i}</span>
                        </c:when>
                        <c:otherwise>
                            <a href="?page=${i}">${i}</a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>

                <c:if test="${currentPage < totalPages}">
                    <a href="?page=${currentPage + 1}">下一页 &gt;</a>
                    <a href="?page=${totalPages}">末页 &raquo;</a>
                </c:if>
                <c:if test="${currentPage >= totalPages}">
                    <span class="disabled">下一页 &gt;</span>
                    <span class="disabled">末页 &raquo;</span>
                </c:if>

                <span>共 ${totalPages} 页</span>
            </div>
        </c:if>
    </c:if>
</div>

<script>
    function deletePost(postId) {
        if (confirm('确定要删除该帖子吗？此操作不可恢复！')) {
            // 创建表单并通过POST请求提交删除请求
            const form = document.createElement('form');
            form.method = 'POST';
            form.action = '<%= request.getContextPath() %>/admin/deletePost';

            const input = document.createElement('input');
            input.type = 'hidden';
            input.name = 'postId';
            input.value = postId;

            form.appendChild(input);
            document.body.appendChild(form);
            form.submit();
        }
    }
</script>

<%@ include file="../../../include/footer.jsp" %>
</body>
</html>
