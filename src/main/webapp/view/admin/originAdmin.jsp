<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="origin-admin-wrapper">
    <div class="page-actions">
        <div class="search-box">
            <input type="text" placeholder="Tìm kiếm xuất xứ..." id="originSearch" autocomplete="off">
            <i class="fa-solid fa-magnifying-glass"></i>
        </div>
        <button class="btn-add-primary" onclick="openAddOriginModal()">
            <i class="fa-solid fa-plus"></i> Thêm mới
        </button>
    </div>

    <div class="table-container">
        <table class="admin-table">
            <thead>
            <tr>
                <th>ID</th>
                <th>Tên xuất xứ</th>
                <th>Mô tả</th>
                <th>Thao tác</th>
            </tr>
            </thead>
            <tbody id="originTableBody">
            <c:choose>
                <c:when test="${not empty origins}">
                    <c:forEach var="item" items="${origins}">
                        <tr>
                            <td><span class="days-badge">#${item.id}</span></td>
                            <td><strong style="color: #0f172a;">${item.name}</strong></td>
                            <td style="max-width: 400px; color: #64748b;">${item.description}</td>
                            <td>
                                <div class="actions">
                                    <button class="btn-action edit" onclick="openEditOriginModal('${item.id}', '${item.name}', '${item.description}')">
                                        <i class="fa-regular fa-pen-to-square"></i>
                                    </button>
                                    <form action="${pageContext.request.contextPath}/origin-admin" method="post" style="display:inline;" onsubmit="return confirm('Xác nhận xóa xuất xứ này?')">
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
                        <td colspan="4" style="text-align: center; padding: 40px; color: #94a3b8;">Chưa có xuất xứ nào.</td>
                    </tr>
                </c:otherwise>
            </c:choose>
            </tbody>
        </table>
    </div>
</div>

<div class="admin-modal-overlay modernize-modal" id="addOriginModal">
    <div class="admin-modal-container small">
        <div class="modal-topbar">
            <h2><i class="fa-solid fa-earth-asia"></i> Thêm xuất xứ mới</h2>
            <button class="btn-close-modal" onclick="closeAddOriginModal()"><i class="fa-solid fa-xmark"></i></button>
        </div>
        <form action="${pageContext.request.contextPath}/origin-admin" method="post" class="modal-form">
            <input type="hidden" name="action" value="add">
            <div class="admin-form-group">
                <label>Tên xuất xứ</label>
                <div class="input-icon-wrapper">
                    <i class="fa-solid fa-location-dot"></i>
                    <input type="text" name="name" class="admin-input-control" placeholder="Việt Nam, Mỹ, Nhật Bản..." required>
                </div>
            </div>
            <div class="admin-form-group">
                <label>Mô tả chi tiết</label>
                <textarea name="description" class="admin-input-control" placeholder="Mô tả về quy trình sản xuất hoặc tiêu chuẩn địa phương..." rows="4"></textarea>
            </div>
            <div class="form-actions-full gap-12" style="display: flex; margin-top: 20px;">
                <button type="button" class="btn-cancel-outline flex-1" onclick="closeAddOriginModal()">Hủy</button>
                <button type="submit" class="btn-update-solid flex-2">Lưu xuất xứ</button>
            </div>
        </form>
    </div>
</div>

<div class="admin-modal-overlay modernize-modal" id="editOriginModal">
    <div class="admin-modal-container small">
        <div class="modal-topbar">
            <h2><i class="fa-solid fa-pen-to-square"></i> Cập nhật xuất xứ</h2>
            <button class="btn-close-modal" onclick="closeEditOriginModal()"><i class="fa-solid fa-xmark"></i></button>
        </div>
        <form action="${pageContext.request.contextPath}/origin-admin" method="post" class="modal-form">
            <input type="hidden" name="action" value="edit">
            <input type="hidden" name="id" id="edit-origin-id">
            <div class="admin-form-group">
                <label>Tên xuất xứ</label>
                <div class="input-icon-wrapper">
                    <i class="fa-solid fa-location-dot"></i>
                    <input type="text" name="name" id="edit-origin-name" class="admin-input-control" required>
                </div>
            </div>
            <div class="admin-form-group">
                <label>Mô tả chi tiết</label>
                <textarea name="description" id="edit-origin-description" class="admin-input-control" rows="4"></textarea>
            </div>
            <div class="form-actions-full gap-12" style="display: flex; margin-top: 20px;">
                <button type="button" class="btn-cancel-outline flex-1" onclick="closeEditOriginModal()">Hủy</button>
                <button type="submit" class="btn-update-solid flex-2">Cập nhật thay đổi</button>
            </div>
        </form>
    </div>
</div>
