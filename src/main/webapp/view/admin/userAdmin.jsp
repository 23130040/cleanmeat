<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="user-admin-wrapper">
    <div class="user-admin-header">
        <form action="${pageContext.request.contextPath}/user-admin" method="get" class="filter-group">
            <div class="search-box">
                <i class="fa-solid fa-magnifying-glass"></i>
                <input type="text" name="query" placeholder="Tìm theo tên, email, SĐT..." value="${searchQuery}">
                <button type="submit" style="display: none;"></button>
            </div>
            <select class="filter-select" name="role" onchange="this.form.submit()">
                <option value="all" ${selectedRole == 'all' ? 'selected' : ''}>Tất cả vai trò</option>
                <option value="admin" ${selectedRole == 'admin' ? 'selected' : ''}>Admin</option>
                <option value="customer" ${selectedRole == 'customer' ? 'selected' : ''}>Khách hàng</option>
            </select>
            <select class="filter-select" name="status" onchange="this.form.submit()">
                <option value="all" ${selectedStatus == 'all' ? 'selected' : ''}>Tất cả trạng thái</option>
                <option value="active" ${selectedStatus == 'active' ? 'selected' : ''}>Hoạt động</option>
                <option value="inactive" ${selectedStatus == 'inactive' ? 'selected' : ''}>Vô hiệu</option>
            </select>
        </form>
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
                                                    <img src="${u.avatar}" alt="Avatar">
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
                                        <button class="btn-action view" title="Xem chi tiết" data-id="${u.id}"><i class="fa-regular fa-eye"></i></button>
                                        <button class="btn-action edit" title="Chỉnh sửa" data-id="${u.id}"><i class="fa-solid fa-pen-to-square"></i></button>
                                        <button class="btn-action delete" title="Xóa" data-id="${u.id}"><i class="fa-regular fa-trash-can"></i></button>
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

<div class="admin-modal-overlay" id="viewUserModal">
    <div class="admin-modal-container">
        <div class="modal-topbar">
            <h2>Chi tiết người dùng</h2>
            <button class="btn-close-modal" onclick="closeModal('viewUserModal')"><i class="fa-solid fa-xmark"></i></button>
        </div>
        <div class="modal-body">
            <div class="user-summary-card no-bg border-bottom">
                <div class="us-avatar large" id="viewUserAvatarContainer">
                    <img src="" alt="" id="viewUserAvatar" style="display: none;">
                    <i class="fa-solid fa-user" id="viewUserAvatarIcon"></i>
                </div>
                <div class="us-details">
                    <h3 id="viewUserName"></h3>
                    <span class="badge badge-customer" id="viewUserRoleBadge">Khách hàng</span>
                </div>
            </div>
            
            <div class="user-info-list" id="viewUserInfoList">
            </div>

            <div class="modal-footer-actions">
                <button class="btn-edit-inline" id="viewModalEditBtn">
                    <i class="fa-solid fa-pen"></i> Chỉnh sửa vai trò / trạng thái
                </button>
            </div>
        </div>
    </div>
</div>

<div class="admin-modal-overlay" id="editUserModal">
    <div class="admin-modal-container">
        <div class="modal-topbar">
            <h2>Chỉnh sửa người dùng</h2>
            <button class="btn-close-modal" onclick="closeModal('editUserModal')"><i class="fa-solid fa-xmark"></i></button>
        </div>
        <form id="editUserForm" class="modal-body">
            <input type="hidden" name="id" id="editUserId">
            
            <div class="user-summary-card">
                <div class="us-avatar" id="editUserAvatarContainer">
                    <img src="" alt="" id="editUserAvatar" style="display: none;">
                    <i class="fa-solid fa-user" id="editUserAvatarIcon"></i>
                </div>
                <div class="us-details">
                    <h3 id="editUserName"></h3>
                    <p id="editUserEmail"></p>
                </div>
            </div>

            <div class="admin-form-group">
                <label>Vai trò</label>
                <select class="admin-input-control" name="role" id="editUserRole">
                    <option value="admin">Admin</option>
                    <option value="customer">Khách hàng</option>
                </select>
            </div>
            <div class="admin-form-group">
                <label>Trạng thái</label>
                <select class="admin-input-control" name="status" id="editUserStatus">
                    <option value="true">Đang hoạt động</option>
                    <option value="false">Đã vô hiệu hóa</option>
                </select>
            </div>
            <div class="form-actions-full" style="gap: 12px;">
                <button type="submit" class="btn-update-solid">Lưu thay đổi</button>
                <button type="button" class="btn-edit-outline" style="flex: 1; justify-content: center;" onclick="closeModal('editUserModal')">Huỷ</button>
            </div>
        </form>
    </div>
</div>

<div class="admin-modal-overlay" id="deleteUserModal">
    <div class="admin-modal-container mini">
        <div class="modal-topbar">
            <h2>Xác nhận vô hiệu hóa</h2>
            <button class="btn-close-modal" onclick="closeModal('deleteUserModal')"><i class="fa-solid fa-xmark"></i></button>
        </div>
        <div class="modal-body text-center">
            <p>Bạn có chắc chắn muốn vô hiệu hóa người dùng này không?</p>
            <div class="form-actions-center mt-20" style="gap: 12px; display: flex; justify-content: center;">
                <button class="btn-alert-ok" style="background-color: #ef4444; flex: 1;" id="confirmDeleteBtn">Vô hiệu hóa</button>
                <button class="btn-edit-outline" style="flex: 1; justify-content: center;" onclick="closeModal('deleteUserModal')">Hủy bỏ</button>
            </div>
        </div>
    </div>
</div>

<script src="${pageContext.request.contextPath}/js/userAdmin.js"></script>
