<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="user-admin-wrapper">
    <div class="user-admin-header">
        <div class="filter-group">
            <div class="search-box">
                <i class="fa-solid fa-magnifying-glass"></i>
                <input type="text" placeholder="Tìm theo tên, email, SĐT...">
            </div>
            <select class="filter-select">
                <option value="all">Tất cả vai trò</option>
                <option value="admin">Admin</option>
                <option value="customer">Khách hàng</option>
            </select>
            <select class="filter-select">
                <option value="all">Tất cả trạng thái</option>
                <option value="active">Hoạt động</option>
                <option value="inactive">Vô hiệu</option>
            </select>
        </div>
        <div class="user-count">
            <i class="fa-regular fa-user"></i> ${fn:length(users)} người dùng
        </div>
    </div>

    <div class="table-container">
        <table class="admin-table">
            <thead>
                <tr>
                    <th>Người dùng</th>
                    <th>Liên hệ</th>
                    <th>Giới tính</th>
                    <th>Vai trò</th>
                    <th>Trạng thái</th>
                    <th>Ngày tạo</th>
                    <th>Thao tác</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty users}">
                        <c:forEach var="u" items="${users}">
                            <tr>
                                <td>
                                    <div class="user-cell">
                                        <div class="avatar-sm">
                                            <c:choose>
                                                <c:when test="${not empty u.avatar}">
                                                    <img src="${pageContext.request.contextPath}${u.avatar}" alt="Avatar">
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="avatar-placeholder"><i class="fa-solid fa-user"></i></div>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <span class="user-name-bold">${u.name}</span>
                                    </div>
                                </td>
                                <td>
                                    <div class="contact-cell">
                                        <span class="contact-email">${u.email}</span>
                                        <span class="contact-phone">${u.phone != null ? u.phone : 'Chưa cập nhật'}</span>
                                    </div>
                                </td>
                                <td>
                                    ${u.gender == 'Male' ? 'Nam' : (u.gender == 'Female' ? 'Nữ' : 'Khác')}
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${u.role == 'admin'}">
                                            <span class="badge badge-admin">Admin</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge badge-customer">Khách hàng</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${u.status}">
                                            <span class="badge badge-active">Hoạt động</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge badge-inactive">Vô hiệu</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    ${fn:substring(u.created_at, 0, 10)}
                                </td>
                                <td>
                                    <div class="actions">
                                        <button class="btn-action view" title="Xem chi tiết"><i class="fa-regular fa-eye"></i></button>
                                        <button class="btn-action edit" title="Chỉnh sửa"><i class="fa-solid fa-pen-to-square"></i></button>
                                        <button class="btn-action delete" title="Xóa"><i class="fa-regular fa-trash-can"></i></button>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="7" class="text-center">Không có người dùng nào.</td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>

    <div class="pagination-container">
        <span class="pagination-info">Hiển thị 1-${fn:length(users)} / ${fn:length(users)}</span>
        <div class="pagination-controls">
            <button class="page-btn"><i class="fa-solid fa-angle-left"></i></button>
            <button class="page-btn active">1</button>
            <button class="page-btn"><i class="fa-solid fa-angle-right"></i></button>
        </div>
    </div>
</div>
