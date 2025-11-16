<!-- user/dashboard.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>用户中心 - 游戏论坛</title>
    <link rel="stylesheet" type="text/css" href="../css/style.css">
</head>
<body>
    <%@ include file="../include/header.jsp" %>
    
    <div class="container">
        <h2>用户中心</h2>
        
        <c:if test="${sessionScope.user == null}">
            <div class="alert alert-error">请先登录</div>
            <script>
                setTimeout(function() {
                    window.location.href = '../login.jsp';
                }, 2000);
            </script>
        </c:if>
        
        <c:if test="${sessionScope.user != null}">
            <div class="user-dashboard">
                <h3>个人信息</h3>
                <table class="user-info-table">
                    <tr>
                        <td>用户名:</td>
                        <td>${sessionScope.user.username}</td>
                    </tr>
                    <tr>
                        <td>邮箱:</td>
                        <td>${sessionScope.user.email}</td>
                    </tr>
                    <tr>
                        <td>角色:</td>
                        <td>${sessionScope.user.role}</td>
                    </tr>
                    <tr>
                        <td>注册时间:</td>
                        <td>${sessionScope.user.createdAt}</td>
                    </tr>
                </table>
                
                <h3>我的帖子</h3>
                <div class="my-posts">
                    <!-- 这里将显示用户的帖子 -->
                    <p>您还没有发布任何帖子。</p>
                </div>
            </div>
        </c:if>
    </div>
    
    <%@ include file="../include/footer.jsp" %>
</body>
</html>
