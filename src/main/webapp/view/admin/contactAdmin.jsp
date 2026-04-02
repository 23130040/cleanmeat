<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="contact-admin-wrapper">
    <div class="page-top-actions">
        <div class="search-box">
            <input type="text" placeholder="Tìm kiếm tên, email, tiêu đề..." id="contactSearch">
            <i class="fa-solid fa-magnifying-glass"></i>
        </div>
    </div>

    <div class="table-card">
        <table class="admin-table">
            <thead>
                <tr>
                    <th>Người gửi</th>
                    <th>Chủ đề</th>
                    <th>Nội dung</th>
                    <th>Trạng thái</th>
                    <th>Ngày gửi</th>
                    <th>Thao tác</th>
                </tr>
            </thead>
            <tbody id="contactTableBody">
                <c:choose>
                    <c:when test="${not empty contacts}">
                        <c:forEach var="c" items="${contacts}">
                            <tr>
                                <td>
                                    <div class="sender-info">
                                        <span class="sender-name">${c.full_name}</span>
                                        <span class="sender-email">${c.email}</span>
                                    </div>
                                </td>
                                <td><span class="subject-text">${c.subject}</span></td>
                                <td>
                                    <div class="message-preview" title="${c.message}">${c.message}</div>
                                </td>
                                <td>
                                    <span class="status-badge status-${c.status}">
                                        <c:choose>
                                            <c:when test="${c.status == 'pending'}">Chờ xử lý</c:when>
                                            <c:when test="${c.status == 'processing'}">Đang xử lý</c:when>
                                            <c:when test="${c.status == 'replied'}">Đã phản hồi</c:when>
                                        </c:choose>
                                    </span>
                                </td>
                                <td>
                                    <span class="date-text">
                                        <c:if test="${not empty c.created_at}">
                                            <fmt:parseDate value="${c.created_at}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDate" type="both" />
                                            <fmt:formatDate value="${parsedDate}" pattern="dd/MM/yyyy HH:mm" />
                                        </c:if>
                                    </span>
                                </td>
                                <td>
                                    <div class="table-actions">
                                        <form action="${pageContext.request.contextPath}/contact-admin" method="post" class="status-form">
                                            <input type="hidden" name="action" value="updateStatus">
                                            <input type="hidden" name="id" value="${c.id}">
                                            <select name="status" onchange="this.form.submit()" class="status-select">
                                                <option value="pending" ${c.status == 'pending' ? 'selected' : ''}>Chờ</option>
                                                <option value="processing" ${c.status == 'processing' ? 'selected' : ''}>Đang XL</option>
                                                <option value="replied" ${c.status == 'replied' ? 'selected' : ''}>Đã xong</option>
                                            </select>
                                        </form>
                                        <form action="${pageContext.request.contextPath}/contact-admin" method="post" onsubmit="return confirm('Xóa yêu cầu này?')">
                                            <input type="hidden" name="action" value="delete">
                                            <input type="hidden" name="id" value="${c.id}">
                                            <button type="submit" class="btn-delete"><i class="fa-regular fa-trash-can"></i></button>
                                        </form>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="6" style="text-align: center; padding: 30px; color: #888;">Không có yêu cầu liên hệ nào.</td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>
</div>
