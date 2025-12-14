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
        <%-- 头部标题 --%>
        <div class="d-flex justify-content-between align-items-center mb-4 border-bottom border-secondary pb-2">
            <h3 class="text-white mb-0"><i class="fas fa-folder-open text-primary me-2"></i> 板块管理</h3>
        </div>

        <c:if test="${not empty param.error}">
            <div class="alert alert-danger mb-4"><i class="fas fa-exclamation-circle me-2"></i> ${param.error}</div>
        </c:if>
        <c:if test="${not empty param.success}">
            <div class="alert alert-success mb-4"><i class="fas fa-check-circle me-2"></i> ${param.success}</div>
        </c:if>

        <div class="row">
            <div class="col-lg-4 mb-4">
                <div class="card bg-dark border-secondary shadow-sm h-100">
                    <div class="card-header bg-transparent border-secondary">
                        <h5 class="mb-0 text-white"><i class="fas fa-plus-circle text-success me-2"></i> 添加新板块</h5>
                    </div>
                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/admin/category" method="post">
                            <input type="hidden" name="action" value="add">

                            <div class="mb-3">
                                <label for="categoryName" class="form-label text-muted small text-uppercase fw-bold">板块名称</label>
                                <input type="text" class="form-control bg-dark text-white border-secondary" id="categoryName" name="categoryName" required placeholder="例如：射击游戏">
                            </div>

                            <div class="mb-3">
                                <label for="description" class="form-label text-muted small text-uppercase fw-bold">描述</label>
                                <textarea class="form-control bg-dark text-white border-secondary no-resize" id="description" name="description" rows="6" placeholder="简要描述该板块的主题..."></textarea>
                            </div>

                            <div class="d-grid mt-4">
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save me-2"></i> 确认添加
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <div class="col-lg-8">
                <div class="card bg-dark border-secondary shadow-sm h-100">
                    <div class="card-header bg-transparent border-secondary d-flex justify-content-between align-items-center">
                        <h5 class="mb-0 text-white"><i class="fas fa-list text-info me-2"></i> 现有板块</h5>
                        <span class="badge bg-secondary border border-secondary">共 ${categories.size()} 个</span>
                    </div>
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <table class="table table-dark table-hover mb-0 align-middle" style="background-color: transparent;">
                                <thead class="bg-secondary bg-opacity-10 text-uppercase text-muted small">
                                <tr>
                                    <th class="ps-4" style="width: 50px;">ID</th>
                                    <th style="width: 20%;">名称</th>
                                    <th>描述</th>
                                    <th class="text-end pe-4" style="width: 100px;">操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="category" items="${categories}">
                                    <tr>
                                        <td class="ps-4 text-muted font-monospace">${category.categoryId}</td>
                                        <td class="fw-bold text-white">${category.categoryName}</td>
                                        <td class="small text-muted text-truncate" style="max-width: 200px;">${category.description}</td>
                                        <td class="text-end pe-4">
                                            <a href="${pageContext.request.contextPath}/admin/category?action=delete&id=${category.categoryId}"
                                               onclick="return confirm('确定要删除【${category.categoryName}】板块吗？\n注意：该操作可能会影响该板块下的所有帖子！')"
                                               class="btn btn-sm btn-outline-danger border-0" title="删除">
                                                <i class="fas fa-trash-alt"></i>
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </c:if>
</div>

<%@ include file="../../../include/footer.jsp" %>
</body>
</html>
