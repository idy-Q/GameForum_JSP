<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>注册 - 游戏论坛</title>
</head>
<body>
<%@ include file="include/header.jsp" %>

<div class="container">
    <div class="card login-card">
        <div class="card-body">
            <div class="text-center mb-4">
                <i class="fas fa-user-plus fa-3x text-primary mb-2"></i>
                <h3>创建账号</h3>
                <p class="text-muted">加入我们，探索游戏世界</p>
            </div>

            <c:if test="${param.error != null}">
                <div class="alert alert-danger text-center p-2 small">
                    <i class="fas fa-exclamation-circle"></i> ${param.error}
                </div>
            </c:if>

            <c:if test="${param.success != null}">
                <div class="alert alert-success text-center p-3">
                    <i class="fas fa-check-circle fa-2x mb-2"></i><br>
                    <strong>注册成功！</strong><br>
                    <a href="login.jsp" class="btn btn-sm btn-success mt-2">去登录</a>
                </div>
            </c:if>

            <c:if test="${param.success == null}">
                <form action="register" method="post">
                    <div class="mb-3">
                        <label for="username" class="form-label">用户名</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-user"></i></span>
                            <input type="text" class="form-control" id="username" name="username" required placeholder="请输入用户名">
                        </div>
                    </div>

                    <div class="mb-3">
                        <label for="password" class="form-label">密码</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-lock"></i></span>
                            <input type="password" class="form-control" id="password" name="password" required placeholder="设置您的密码">
                        </div>
                    </div>

                    <div class="mb-4">
                        <label for="email" class="form-label">电子邮箱</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                            <input type="email" class="form-control" id="email" name="email" required placeholder="example@email.com">
                        </div>
                    </div>

                    <div class="d-grid gap-2">
                        <button type="submit" class="btn btn-primary btn-lg">立即注册</button>
                    </div>
                </form>
            </c:if>

            <div class="text-center mt-3">
                <p class="text-muted small">已有账号? <a href="login.jsp" class="text-primary fw-bold">立即登录</a></p>
            </div>
        </div>
    </div>
</div>

<%@ include file="include/footer.jsp" %>
</body>
</html>