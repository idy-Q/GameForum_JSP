<!-- admin/manageUsers.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>用户管理 - 游戏论坛</title>
    <link rel="stylesheet" type="text/css" href="../../../css/style.css">
</head>
<body>
    <%@ include file="../../../include/header.jsp" %>
    
    <div class="container">
        <c:if test="${sessionScope.user == null || sessionScope.user.role != 'admin'}">
            <div class="alert alert-error">权限不足</div>
            <script>
                setTimeout(function() {
                    window.location.href = '../../../index.jsp';
                }, 2000);
            </script>
        </c:if>
        
        <c:if test="${sessionScope.user != null && sessionScope.user.role == 'admin'}">
            <h2>用户管理</h2>
            
            <table class="admin-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>用户名</th>
                        <th>邮箱</th>
                        <th>角色</th>
                        <th>注册时间</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="user" items="${users}">
                        <tr>
                            <td>${user.userId}</td>
                            <td>${user.username}</td>
                            <td>${user.email}</td>
                            <td>${user.role}</td>
                            <td>${user.createdAt}</td>
                            <td>
                                <c:if test="${user.role == 'user'}">
                                    <a href="#" onclick="changeRole(${user.userId}, 'admin')">设为管理员</a>
                                </c:if>
                                <c:if test="${user.role == 'admin' && user.username != 'admin'}">
                                    <a href="#" onclick="changeRole(${user.userId}, 'user')">设为普通用户</a>
                                </c:if>
                                <c:if test="${user.username != 'admin'}">
                                    | <a href="#" onclick="deleteUser(${user.userId})" style="color: red;">删除</a>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>
    </div>
    
    <script>
        function changeRole(userId, role) {
            if (confirm('确定要更改用户角色吗？')) {
                // 这里应该调用相应的Servlet处理
                alert('功能待实现');
            }
        }
        
        function deleteUser(userId) {
            if (confirm('确定要删除该用户吗？')) {
                // 这里应该调用相应的Servlet处理
                alert('功能待实现');
            }
        }
    </script>
    
    <%@ include file="../../../include/footer.jsp" %>
</body>
</html>
