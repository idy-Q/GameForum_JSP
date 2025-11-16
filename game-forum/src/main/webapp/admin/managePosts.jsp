<!-- admin/managePosts.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>帖子管理 - 游戏论坛</title>
    <link rel="stylesheet" type="text/css" href="../css/style.css">
</head>
<body>
    <%@ include file="../include/header.jsp" %>
    
    <div class="container">
        <c:if test="${sessionScope.user == null || sessionScope.user.role != 'admin'}">
            <div class="alert alert-error">权限不足</div>
            <script>
                setTimeout(function() {
                    window.location.href = '../index.jsp';
                }, 2000);
            </script>
        </c:if>
        
        <c:if test="${sessionScope.user != null && sessionScope.user.role == 'admin'}">
            <h2>帖子管理</h2>
            
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
                            <td><a href="../postDetail.jsp?postId=${post.postId}" target="_blank">${post.title}</a></td>
                            <td>${post.username}</td>
                            <td>${post.categoryName}</td>
                            <td>${post.createdAt}</td>
                            <td>
                                <a href="#" style="color: red;">删除</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>
    </div>
    
    <%@ include file="../include/footer.jsp" %>
</body>
</html>
