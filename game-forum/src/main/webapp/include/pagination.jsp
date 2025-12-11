<%-- include/pagination.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- 只有当总页数大于1时才显示分页 --%>
<c:if test="${totalPages > 1}">
    <div class="pagination">
            <%-- 上一页 --%>
        <c:if test="${currentPage > 1}">
            <a href="?page=${currentPage - 1}">« 上一页</a>
        </c:if>
        <c:if test="${currentPage <= 1}">
            <span class="disabled">« 上一页</span>
        </c:if>

            <%-- 页码数字循环 --%>
        <c:forEach begin="1" end="${totalPages}" var="i">
            <c:choose>
                <c:when test="${currentPage == i}">
                    <span class="current">${i}</span>
                </c:when>
                <c:otherwise>
                    <a href="?page=${i}">${i}</a>
                </c:otherwise>
            </c:choose>
        </c:forEach>

            <%-- 下一页 --%>
        <c:if test="${currentPage < totalPages}">
            <a href="?page=${currentPage + 1}">下一页 »</a>
        </c:if>
        <c:if test="${currentPage >= totalPages}">
            <span class="disabled">下一页 »</span>
        </c:if>
    </div>
</c:if>