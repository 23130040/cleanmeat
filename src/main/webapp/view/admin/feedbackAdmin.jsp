<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="feedback-admin-wrapper">
    <div class="page-actions">
        <div class="search-box">
            <input type="text" placeholder="Tìm kiếm phản hồi, khách hàng, sản phẩm..." id="feedbackSearch" autocomplete="off">
            <i class="fa-solid fa-magnifying-glass"></i>
        </div>
    </div>

    <div class="table-container">
        <table class="admin-table">
            <thead>
            <tr>
                <th>Khách hàng</th>
                <th>Sản phẩm</th>
                <th>Đánh giá</th>
                <th>Bình luận</th>
                <th>Ngày gửi</th>
                <th>Thao tác</th>
            </tr>
            </thead>
            <tbody id="feedbackTableBody">
            <c:choose>
                <c:when test="${not empty feedbacks}">
                    <c:forEach var="item" items="${feedbacks}">
                        <tr>
                            <td>
                                <div class="user-cell">
                                    <c:choose>
                                        <c:when test="${not empty item.avatar}">
                                            <img src="${item.avatar}" class="user-avatar-sm">
                                        </c:when>
                                        <c:otherwise>
                                            <div class="user-avatar-placeholder-sm"><i class="fa-solid fa-user"></i></div>
                                        </c:otherwise>
                                    </c:choose>
                                    <div class="user-info-sm">
                                        <span class="user-name-sm">${item.name}</span>
                                        <span class="user-id-sm">ID: #${item.user_id}</span>
                                    </div>
                                </div>
                            </td>
                            <td>
                                <span class="product-name-badge">${item.item_name}</span>
                            </td>
                            <td>
                                <div class="rating-stars">
                                    <c:forEach begin="1" end="5" var="i">
                                        <i class="fa-solid fa-star ${i <= item.rating ? 'filled' : ''}"></i>
                                    </c:forEach>
                                </div>
                            </td>
                            <td>
                                <div class="comment-text" title="${item.comment}">
                                    ${item.comment}
                                </div>
                            </td>
                            <td>
                                <span class="date-badge">
                                    <fmt:parseDate value="${item.created_at}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDate" type="both" />
                                    <fmt:formatDate value="${parsedDate}" pattern="dd/MM/yyyy" />
                                </span>
                            </td>
                            <td>
                                <div class="actions">
                                    <form action="${pageContext.request.contextPath}/feedback-admin" method="post" style="display:inline;" onsubmit="return confirm('Xác nhận xóa phản hồi này?')">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="id" value="${item.id}">
                                        <button type="submit" class="btn-action delete"><i class="fa-regular fa-trash-can"></i></button>
                                    </form>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <tr>
                        <td colspan="6" style="text-align: center; padding: 40px; color: #94a3b8;">Chưa có phản hồi nào từ khách hàng.</td>
                    </tr>
                </c:otherwise>
            </c:choose>
            </tbody>
        </table>
    </div>
</div>
