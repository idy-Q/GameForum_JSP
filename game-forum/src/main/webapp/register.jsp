<!-- register.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>注册 - 游戏论坛</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
    <%@ include file="include/header.jsp" %>
    
    <div class="container">
        <div class="form-container">
            <h2>用户注册</h2>

            <c:if test="${param.error != null}">
                <div class="alert alert-error">${param.error}</div>
            </c:if>

            <form action="register" method="post">
                <div class="form-group">
                    <label for="username">用户名:</label>
                    <input type="text" id="username" name="username" required>
                </div>
                
                <div class="form-group">
                    <label for="password">密码:</label>
                    <input type="password" id="password" name="password" required>
                </div>
                
                <div class="form-group">
                    <label for="email">邮箱:</label>
                    <input type="email" id="email" name="email" required>
                </div>
                
                <div class="form-group">
                    <button type="submit">注册</button>
                </div>
            </form>
            
            <p>已有账号? <a href="login.jsp">立即登录</a></p>
        </div>
    </div>
    
</body>
</html>
