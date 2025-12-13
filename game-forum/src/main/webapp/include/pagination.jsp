<%-- src/main/webapp/include/pagination.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${totalPages > 1}">
    <nav aria-label="Page navigation" class="mt-5">
        <ul class="pagination justify-content-center">
                <%-- 上一页 --%>
            <li class="page-item ${currentPage <= 1 ? 'disabled' : ''}">
                <a class="page-link bg-dark text-secondary border-secondary" href="?page=${currentPage - 1}" ${currentPage <= 1 ? 'tabindex="-1" aria-disabled="true"' : ''}>
                    <i class="fas fa-chevron-left"></i> 上一页
                </a>
            </li>

                <%-- 页码数字 --%>
            <c:forEach begin="1" end="${totalPages}" var="i">
                <li class="page-item ${currentPage == i ? 'active' : ''}">
                    <a class="page-link ${currentPage == i ? 'bg-primary border-primary text-white' : 'bg-dark text-secondary border-secondary'}" href="?page=${i}">
                            ${i}
                    </a>
                </li>
            </c:forEach>

                <%-- 下一页 --%>
            <li class="page-item ${currentPage >= totalPages ? 'disabled' : ''}">
                <a class="page-link bg-dark text-secondary border-secondary" href="?page=${currentPage + 1}" ${currentPage >= totalPages ? 'tabindex="-1" aria-disabled="true"' : ''}>
                    下一页 <i class="fas fa-chevron-right"></i>
                </a>
            </li>
        </ul>
    </nav>
</c:if>