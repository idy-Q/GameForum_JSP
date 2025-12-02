<!-- newPost.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>发表帖子 - 游戏论坛</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
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

        <c:if test="${param.success != null}">
            <div class="alert alert-success">发表成功！即将跳转到帖子列表页面...</div>
            <script>
                setTimeout(function() {
                    window.location.href = "postList.jsp";
                }, 3000);
            </script>
        </c:if>
        
        <c:if test="${sessionScope.user != null}">
            <div class="form-container">
                <h2>发表新帖子</h2>
                
                <c:if test="${param.error != null}">
                    <div class="alert alert-error">${param.error}</div>
                </c:if>
                
                <form action="createPost" method="post">
                    <div class="form-group">
                        <label for="title">标题:</label>
                        <input type="text" id="title" name="title" required>
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
                        <label for="content">内容:</label>
                        <textarea class="no-resize" id="content" name="content" rows="10" cols="63" required></textarea>
                    </div>
                    
                    <div class="form-group">
                        <button type="submit">发表帖子</button>
                        <button type="button" onclick="window.history.back()">取消</button>
                    </div>
                </form>
            </div>
        </c:if>
    </div>
    
    <%@ include file="/include/footer.jsp" %>
</body>
</html>
