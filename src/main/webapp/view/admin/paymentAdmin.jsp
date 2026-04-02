<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="payment-admin-wrapper">
    <div class="page-actions">
        <div class="search-box">
            <i class="fa-solid fa-magnifying-glass"></i>
            <input type="text" id="memberSearch" placeholder="Tìm kiếm phương thức...">
        </div>
        <button class="btn-add-primary" onclick="openAddPaymentModal()">
            <i class="fa-solid fa-plus"></i> Thêm phương thức
        </button>
    </div>

    <div class="table-container">
        <table class="admin-table">
            <thead>
            <tr>
                <th>ID</th>
                <th>Tên phương thức</th>
                <th>Ngày tạo</th>
                <th>Ngày cập nhật</th>
                <th>Trạng thái</th>
                <th>Thao tác</th>
            </tr>
            </thead>
            <tbody>
            <c:choose>
                <c:when test="${not empty payments}">
                    <c:forEach var="payment" items="${payments}">
                        <tr>
                            <td><span class="id-badge">#${payment.id}</span></td>
                            <td>
                                <span class="payment-name-bold">${payment.name}</span>
                            </td>
                            <td>
                                <div class="date-cell">
                                    <c:if test="${not empty payment.created_at}">
                                        <span>${fn:substring(payment.created_at, 0, 10)}</span>
                                        <small>${fn:substring(payment.created_at, 11, 16)}</small>
                                    </c:if>
                                </div>
                            </td>
                            <td>
                                <div class="date-cell">
                                    <c:if test="${not empty payment.updated_at}">
                                        <span>${fn:substring(payment.updated_at, 0, 10)}</span>
                                        <small>${fn:substring(payment.updated_at, 11, 16)}</small>
                                    </c:if>
                                </div>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${payment.status}">
                                        <span class="badge badge-active">Đang hoạt động</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge badge-inactive">Ngừng hoạt động</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <div class="actions">
                                    <form action="${pageContext.request.contextPath}/payment-admin" method="post" style="display:inline;">
                                        <input type="hidden" name="action" value="toggleStatus">
                                        <input type="hidden" name="id" value="${payment.id}">
                                        <input type="hidden" name="status" value="${!payment.status}">
                                        <button type="submit" class="btn-action ${payment.status ? 'deactivate' : 'activate'}" 
                                                title="${payment.status ? 'Ngừng hoạt động' : 'Kích hoạt'}">
                                            <i class="fa-solid ${payment.status ? 'fa-toggle-on' : 'fa-toggle-off'}"></i>
                                        </button>
                                    </form>
                                    <button class="btn-action edit" title="Chỉnh sửa" 
                                            onclick="openEditPaymentModal('${payment.id}', '${payment.name}')">
                                        <i class="fa-regular fa-pen-to-square"></i>
                                    </button>
                                    <form action="${pageContext.request.contextPath}/payment-admin" method="post" style="display:inline;" 
                                          onsubmit="return confirm('Bạn có chắc chắn muốn xóa phương thức này?')">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="id" value="${payment.id}">
                                        <button type="submit" class="btn-action delete" title="Xóa"><i class="fa-regular fa-trash-can"></i></button>
                                    </form>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <tr>
                        <td colspan="6" class="text-center">Chưa có phương thức thanh toán nào.</td>
                    </tr>
                </c:otherwise>
            </c:choose>
            </tbody>
        </table>
    </div>
</div>

<div class="admin-modal-overlay modernize-modal" id="addPaymentModal">
    <div class="admin-modal-container small">
        <div class="modal-topbar">
            <h2><i class="fa-solid fa-plus-circle"></i> Thêm phương thức mới</h2>
            <button class="btn-close-modal" onclick="closeAddPaymentModal()"><i class="fa-solid fa-xmark"></i></button>
        </div>
        <form action="${pageContext.request.contextPath}/payment-admin" method="post" class="modal-form">
            <input type="hidden" name="action" value="add">
            <div class="admin-form-group">
                <label>Tên phương thức</label>
                <div class="input-icon-wrapper">
                    <i class="fa-regular fa-credit-card"></i>
                    <input type="text" name="name" class="admin-input-control" placeholder="Ví dụ: Ví MoMo, ZaloPay..." required>
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
            <div class="form-actions-full gap-12">
                <button type="button" class="btn-cancel-outline flex-1" onclick="closeAddPaymentModal()">Hủy</button>
                <button type="submit" class="btn-update-solid flex-2">Lưu phương thức</button>
            </div>
        </form>
    </div>
</div>

<div class="admin-modal-overlay modernize-modal" id="editPaymentModal">
    <div class="admin-modal-container small">
        <div class="modal-topbar">
            <h2><i class="fa-solid fa-pen-to-square"></i> Chỉnh sửa phương thức</h2>
            <button class="btn-close-modal" onclick="closeEditPaymentModal()"><i class="fa-solid fa-xmark"></i></button>
        </div>
        <form action="${pageContext.request.contextPath}/payment-admin" method="post" class="modal-form">
            <input type="hidden" name="action" value="edit">
            <input type="hidden" name="id" id="edit-payment-id">
            <div class="admin-form-group">
                <label>Tên phương thức</label>
                <div class="input-icon-wrapper">
                    <i class="fa-regular fa-credit-card"></i>
                    <input type="text" name="name" id="edit-payment-name" class="admin-input-control" required>
                </div>
            </div>
            <div class="form-actions-full">
                <button type="button" class="btn-cancel-outline flex-1" onclick="closeEditPaymentModal()">Hủy</button>
                <button type="submit" class="btn-update-solid flex-2">Cập nhật thay đổi</button>
            </div>
        </form>
    </div>
</div>
