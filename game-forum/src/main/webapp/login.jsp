<!-- login.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>登录 - 游戏论坛</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
<%@ include file="include/header.jsp" %>

<div class="container">
    <div class="form-container">
        <h2>用户登录</h2>

        <c:if test="${param.error != null}">
            <div class="alert alert-error">${param.error}</div>
        </c:if>

        <form action="login" method="post">
            <div class="form-group">
                <label for="username">用户名:</label>
                <input type="text" id="username" name="username" required>
            </div>

            <div class="form-group">
                <label for="password">密码:</label>
                <input type="password" id="password" name="password" required>
            </div>

            <div class="form-group">
                <button type="submit">登录</button>
            </div>
        </form>

        <p>还没有账号? <a href="register.jsp">立即注册</a></p>
    </div>
</div>

<%@ include file="include/footer.jsp" %>
</body>
</html>
