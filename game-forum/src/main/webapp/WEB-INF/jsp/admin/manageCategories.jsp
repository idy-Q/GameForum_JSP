<!-- admin/manageCategories.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>板块管理 - 游戏论坛</title>
    <link rel="stylesheet" type="text/css" href="../../../css/style.css">
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
        <h2>板块管理</h2>

        <!-- 显示错误消息 -->
        <c:if test="${not empty param.error}">
            <div class="alert alert-error">${param.error}</div>
        </c:if>

        <!-- 显示成功消息 -->
        <c:if test="${not empty param.success}">
            <div class="alert alert-success">${param.success}</div>
        </c:if>

        <div class="form-container" style="max-width: 600px;">
            <h3>添加新板块</h3>
            <form action="${pageContext.request.contextPath}/admin/category" method="post">
                <input type="hidden" name="action" value="add">
                <div class="form-group">
                    <label for="categoryName">板块名称:</label>
                    <input type="text" id="categoryName" name="categoryName" required>
                </div>

                <div class="form-group">
                    <label for="description">描述:</label>
                    <textarea class="no-resize" id="description" name="description" rows="10" cols="78"></textarea>
                </div>

                <div class="form-group">
                    <button type="submit">添加板块</button>
                </div>
            </form>
        </div>

        <h3 class="admin-heading">现有板块</h3>
        <table class="admin-table">
            <thead>
            <tr>
                <th>ID</th>
                <th>板块名称</th>
                <th>描述</th>
                <th>创建时间</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="category" items="${categories}">
                <tr>
                    <td>${category.categoryId}</td>
                    <td>${category.categoryName}</td>
                    <td>${category.description}</td>
                    <td>${category.createdAt}</td>
                    <td>
                        <a href="${pageContext.request.contextPath}/admin/category?action=delete&id=${category.categoryId}"
                           onclick="return confirm('确定要删除这个板块吗？')"
                           style="color: red;">删除</a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </c:if>
</div>

<%@ include file="../../../include/footer.jsp" %>
</body>
</html>
