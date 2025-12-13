<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>登录 - 游戏论坛</title>
</head>
<body>
<%@ include file="include/header.jsp" %>

<div class="container">
    <div class="card login-card">
        <div class="card-body">
            <div class="text-center mb-4">
                <i class="fas fa-gamepad fa-3x text-primary mb-2"></i>
                <h3>欢迎回来</h3>
                <p class="text-muted">登录账号开始畅聊</p>
            </div>

            <c:if test="${param.error != null}">
                <div class="alert alert-danger text-center p-2">${param.error}</div>
            </c:if>

            <form action="login" method="post">
                <div class="mb-3">
                    <label for="username" class="form-label">用户名</label>
                    <div class="input-group">
                        <span class="input-group-text bg-dark border-secondary text-muted"><i class="fas fa-user"></i></span>
                        <input type="text" class="form-control bg-dark text-white border-secondary" id="username" name="username" required>
                    </div>
                </div>

                <div class="mb-4">
                    <label for="password" class="form-label">密码</label>
                    <div class="input-group">
                        <span class="input-group-text bg-dark border-secondary text-muted"><i class="fas fa-lock"></i></span>
                        <input type="password" class="form-control bg-dark text-white border-secondary" id="password" name="password" required>
                    </div>
                </div>

                <div class="d-grid gap-2">
                    <button type="submit" class="btn btn-primary btn-lg">登录</button>
                </div>
            </form>

            <div class="text-center mt-3">
                <p class="text-muted small">还没有账号? <a href="register.jsp">立即注册</a></p>
            </div>
        </div>
    </div>
</div>

<%@ include file="include/footer.jsp" %>
</body>
</html>