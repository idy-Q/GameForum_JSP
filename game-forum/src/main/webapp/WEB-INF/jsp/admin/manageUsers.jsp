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

    <!-- 将 manageUsers.jsp 中的 JavaScript 部分修改为使用绝对路径 -->
    <script>
        function changeRole(userId, role) {
            if (confirm('确定要更改用户角色吗？')) {
                fetch('${pageContext.request.contextPath}/admin/userAction', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: 'action=changeRole&userId=' + userId + '&role=' + role
                })
                    .then(response => response.json())
                    .then(data => {
                        if (data.success) {
                            alert(data.message);
                            location.reload();
                        } else {
                            alert('操作失败: ' + data.message);
                        }
                    })
                    .catch(error => {
                        console.error('Error:', error);
                        alert('操作失败');
                    });
            }
        }

        function deleteUser(userId) {
            if (confirm('确定要删除该用户吗？此操作不可恢复！')) {
                fetch('${pageContext.request.contextPath}/admin/userAction', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: 'action=deleteUser&userId=' + userId
                })
                    .then(response => response.json())
                    .then(data => {
                        if (data.success) {
                            alert(data.message);
                            location.reload();
                        } else {
                            alert('删除失败: ' + data.message);
                        }
                    })
                    .catch(error => {
                        console.error('Error:', error);
                        alert('删除失败');
                    });
            }
        }
    </script>

    
    <%@ include file="../../../include/footer.jsp" %>
</body>
</html>
