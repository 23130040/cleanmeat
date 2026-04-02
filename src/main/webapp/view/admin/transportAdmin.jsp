<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="transport-admin-wrapper">
    <div class="page-actions">
        <div class="search-box">
            <input type="text" placeholder="Tìm kiếm đơn vị vận chuyển..." autocomplete="off">
            <i class="fa-solid fa-magnifying-glass"></i>
        </div>
        <button class="btn-add-primary" onclick="openAddTransportModal()">
            <i class="fa-solid fa-plus"></i> Thêm mới
        </button>
    </div>

    <div class="table-container">
        <table class="admin-table">
            <thead>
            <tr>
                <th>ID</th>
                <th>Đơn vị vận chuyển</th>
                <th>Phí cơ bản</th>
                <th>Thời gian dự kiến</th>
                <th>Freeship</th>
                <th>Trạng thái</th>
                <th>Thao tác</th>
            </tr>
            </thead>
            <tbody>
            <c:choose>
                <c:when test="${not empty transports}">
                    <c:forEach var="item" items="${transports}">
                        <tr>
                            <td><span class="days-badge">#${item.id}</span></td>
                            <td><strong style="color: #0f172a;">${item.name}</strong></td>
                            <td>
                                <span class="fee-badge">
                                    <fmt:formatNumber value="${item.base_fee}" type="currency" currencySymbol="đ"/>
                                </span>
                            </td>
                            <td><span class="days-badge">${item.estimate_day} ngày</span></td>
                            <td>
                                <span style="font-weight: 600; color: #64748b;">
                                    <fmt:formatNumber value="${item.free_ship}" type="currency" currencySymbol="đ"/>
                                </span>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${item.status}">
                                        <span class="badge badge-active">Đang hoạt động</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge badge-inactive">Tạm ngưng</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <div class="actions">
                                    <form action="${pageContext.request.contextPath}/transport-admin" method="post" style="display:inline;">
                                        <input type="hidden" name="action" value="toggleStatus">
                                        <input type="hidden" name="id" value="${item.id}">
                                        <input type="hidden" name="status" value="${!item.status}">
                                        <button type="submit" class="btn-action ${item.status ? 'deactivate' : 'activate'}">
                                            <i class="fa-solid ${item.status ? 'fa-toggle-on' : 'fa-toggle-off'}"></i>
                                        </button>
                                    </form>
                                    <button class="btn-action edit" onclick="openEditTransportModal('${item.id}', '${item.name}', '${item.base_fee}', '${item.estimate_day}', '${item.free_ship}')">
                                        <i class="fa-regular fa-pen-to-square"></i>
                                    </button>
                                    <form action="${pageContext.request.contextPath}/transport-admin" method="post" style="display:inline;" onsubmit="return confirm('Xác nhận xóa đơn vị này?')">
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
                        <td colspan="7" style="text-align: center; padding: 40px; color: #94a3b8;">Chưa có đơn vị vận chuyển nào.</td>
                    </tr>
                </c:otherwise>
            </c:choose>
            </tbody>
        </table>
    </div>
</div>

<div class="admin-modal-overlay modernize-modal" id="addTransportModal">
    <div class="admin-modal-container small">
        <div class="modal-topbar">
            <h2><i class="fa-solid fa-truck-fast"></i> Thêm đơn vị mới</h2>
            <button class="btn-close-modal" onclick="closeAddTransportModal()"><i class="fa-solid fa-xmark"></i></button>
        </div>
        <form action="${pageContext.request.contextPath}/transport-admin" method="post" class="modal-form">
            <input type="hidden" name="action" value="add">
            <div class="admin-form-group">
                <label>Tên đơn vị vận chuyển</label>
                <div class="input-icon-wrapper">
                    <i class="fa-solid fa-building-columns"></i>
                    <input type="text" name="name" class="admin-input-control" placeholder="Giao hàng nhanh, J&T..." required>
                </div>
            </div>
            <div class="admin-form-group">
                <label>Phí vận chuyển cơ bản (đ)</label>
                <div class="input-icon-wrapper">
                    <i class="fa-solid fa-money-bill-wave"></i>
                    <input type="number" name="base_fee" class="admin-input-control" placeholder="15000" required>
                </div>
            </div>
            <div class="admin-form-group">
                <label>Ngày dự kiến giao</label>
                <div class="input-icon-wrapper">
                    <i class="fa-regular fa-calendar-days"></i>
                    <input type="number" name="estimated_day" class="admin-input-control" placeholder="2" required>
                </div>
            </div>
            <div class="admin-form-group">
                <label>Ngưỡng miễn phí ship (đ)</label>
                <div class="input-icon-wrapper">
                    <i class="fa-solid fa-hand-holding-dollar"></i>
                    <input type="number" name="free_ship" class="admin-input-control" placeholder="100000" required>
                </div>
            </div>
            <div class="admin-form-group">
                <div class="toggle-wrapper">
                    <span class="toggle-label">Kích hoạt ngay</span>
                    <label class="switch">
                        <input type="checkbox" name="status" checked>
                        <span class="slider round"></span>
                    </label>
                </div>
            </div>
            <div class="form-actions-full gap-12" style="display: flex;">
                <button type="button" class="btn-cancel-outline flex-1" onclick="closeAddTransportModal()">Hủy</button>
                <button type="submit" class="btn-update-solid flex-2">Lưu đơn vị</button>
            </div>
        </form>
    </div>
</div>

<div class="admin-modal-overlay modernize-modal" id="editTransportModal">
    <div class="admin-modal-container small">
        <div class="modal-topbar">
            <h2><i class="fa-solid fa-pen-to-square"></i> Cập nhật đơn vị</h2>
            <button class="btn-close-modal" onclick="closeEditTransportModal()"><i class="fa-solid fa-xmark"></i></button>
        </div>
        <form action="${pageContext.request.contextPath}/transport-admin" method="post" class="modal-form">
            <input type="hidden" name="action" value="edit">
            <input type="hidden" name="id" id="edit-transport-id">
            <div class="admin-form-group">
                <label>Tên đơn vị vận chuyển</label>
                <div class="input-icon-wrapper">
                    <i class="fa-solid fa-building-columns"></i>
                    <input type="text" name="name" id="edit-transport-name" class="admin-input-control" required>
                </div>
            </div>
            <div class="admin-form-group">
                <label>Phí vận chuyển cơ bản (đ)</label>
                <div class="input-icon-wrapper">
                    <i class="fa-solid fa-money-bill-wave"></i>
                    <input type="number" name="base_fee" id="edit-transport-fee" class="admin-input-control" required>
                </div>
            </div>
            <div class="admin-form-group">
                <label>Ngày dự kiến giao</label>
                <div class="input-icon-wrapper">
                    <i class="fa-regular fa-calendar-days"></i>
                    <input type="number" name="estimated_day" id="edit-transport-days" class="admin-input-control" required>
                </div>
            </div>
            <div class="admin-form-group">
                <label>Ngưỡng miễn phí ship (đ)</label>
                <div class="input-icon-wrapper">
                    <i class="fa-solid fa-hand-holding-dollar"></i>
                    <input type="number" name="free_ship" id="edit-transport-free-ship" class="admin-input-control" required>
                </div>
            </div>
            <div class="form-actions-full gap-12" style="display: flex;">
                <button type="button" class="btn-cancel-outline flex-1" onclick="closeEditTransportModal()">Hủy</button>
                <button type="submit" class="btn-update-solid flex-2">Cập nhật thay đổi</button>
            </div>
        </form>
    </div>
</div>
