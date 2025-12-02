<!-- src/main/webapp/error.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>错误页面 - 游戏论坛</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<%@ include file="/include/header.jsp" %>

<div class="container">
    <div class="error-page">
        <h2>出错了!</h2>
        <div class="error-message">
            <c:if test="${not empty param.error}">
                <p>${param.error}</p>
            </c:if>
            <c:if test="${empty param.error}">
                <p>发生未知错误</p>
            </c:if>
        </div>
        <div class="error-actions">
            <a href="${pageContext.request.contextPath}/index.jsp" class="btn">返回首页</a>
            <a href="javascript:history.back()" class="btn">返回上一页</a>
        </div>
    </div>
</div>

<%@ include file="/include/footer.jsp" %>
</body>
</html>
