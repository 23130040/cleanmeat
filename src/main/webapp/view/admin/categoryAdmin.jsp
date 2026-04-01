<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="category-admin-wrapper">
    <div class="category-admin-header">
        <div class="filter-group">
            <div class="search-box">
                <i class="fa-solid fa-magnifying-glass"></i>
                <input type="text" id="categorySearch" placeholder="Tìm danh mục...">
            </div>
        </div>
        <button class="btn-add-category" onclick="openAddCategoryModal()">
            <i class="fa-solid fa-plus"></i> Thêm danh mục
        </button>
    </div>

    <div class="table-container">
        <table class="admin-table">
            <thead>
                <tr>
                    <th style="width: 80px">ID</th>
                    <th>Tên danh mục</th>
                    <th>Mô tả</th>
                    <th style="width: 150px">Ngày tạo</th>
                    <th style="width: 120px">Thao tác</th>
                </tr>
            </thead>
            <tbody id="categoryTableBody">
                <c:choose>
                    <c:when test="${not empty categories}">
                        <c:forEach var="cat" items="${categories}">
                            <tr>
                                <td>#${cat.id}</td>
                                <td class="font-600">${cat.name}</td>
                                <td class="text-muted"><c:out value="${cat.description}" default="Không có mô tả"/></td>
                                <td>${cat.created_at.toLocalDate()}</td>
                                <td>
                                    <div class="actions">
                                        <button class="btn-action edit" title="Chỉnh sửa" onclick="openEditCategoryModal(${cat.id}, '${cat.name}', '${cat.description}')">
                                            <i class="fa-solid fa-pen-to-square"></i>
                                        </button>
                                        <button class="btn-action delete" title="Xóa" onclick="confirmDeleteCategory(${cat.id}, '${cat.name}')">
                                            <i class="fa-regular fa-trash-can"></i>
                                        </button>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="5" class="text-center">Không có danh mục nào.</td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>
</div>

<div class="admin-modal-overlay" id="addCategoryModal">
    <div class="admin-modal-container">
        <div class="modal-topbar">
            <h2>Thêm danh mục mới</h2>
            <button class="btn-close-modal" onclick="closeModal('addCategoryModal')"><i class="fa-solid fa-xmark"></i></button>
        </div>
        <form action="${pageContext.request.contextPath}/category-admin" method="post" class="modal-form">
            <input type="hidden" name="action" value="add">
            <div class="admin-form-group">
                <label for="add-name">Tên danh mục <span class="required">*</span></label>
                <input type="text" id="add-name" name="name" class="admin-input-control" placeholder="Nhập tên danh mục" required>
            </div>
            <div class="admin-form-group">
                <label for="add-description">Mô tả</label>
                <textarea id="add-description" name="description" class="admin-input-control" placeholder="Nhập mô tả cho danh mục" rows="4"></textarea>
            </div>
            <div class="form-actions-full">
                <button type="submit" class="btn-update-solid">Lưu thay đổi</button>
            </div>
        </form>
    </div>
</div>

<div class="admin-modal-overlay" id="editCategoryModal">
    <div class="admin-modal-container">
        <div class="modal-topbar">
            <h2>Chỉnh sửa danh mục</h2>
            <button class="btn-close-modal" onclick="closeModal('editCategoryModal')"><i class="fa-solid fa-xmark"></i></button>
        </div>
        <form action="${pageContext.request.contextPath}/category-admin" method="post" class="modal-form">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="id" id="edit-id">
            <div class="admin-form-group">
                <label for="edit-name">Tên danh mục <span class="required">*</span></label>
                <input type="text" id="edit-name" name="name" class="admin-input-control" required>
            </div>
            <div class="admin-form-group">
                <label for="edit-description">Mô tả</label>
                <textarea id="edit-description" name="description" class="admin-input-control" rows="4"></textarea>
            </div>
            <div class="form-actions-full">
                <button type="submit" class="btn-update-solid">Cập nhật</button>
            </div>
        </form>
    </div>
</div>

<div class="admin-modal-overlay" id="deleteCategoryModal">
    <div class="admin-alert-content">
        <button class="btn-close-alert" onclick="closeModal('deleteCategoryModal')"><i class="fa-solid fa-xmark"></i></button>
        <div class="alert-icon warning"><i class="fa-solid fa-triangle-exclamation"></i></div>
        <h3>Xác nhận xóa</h3>
        <p>Bạn có chắc chắn muốn xóa danh mục <strong id="delete-cat-name"></strong> không? Thao tác này không thể hoàn tác.</p>
        <form action="${pageContext.request.contextPath}/category-admin" method="post">
            <input type="hidden" name="action" value="delete">
            <input type="hidden" name="id" id="delete-id">
            <div class="form-actions-full" style="display: flex; gap: 10px;">
                <button type="button" class="btn-alert-ok" style="background-color: #6b7280;" onclick="closeModal('deleteCategoryModal')">Hủy</button>
                <button type="submit" class="btn-alert-ok" style="background-color: #ef4444;">Xóa ngay</button>
            </div>
        </form>
    </div>
</div>
