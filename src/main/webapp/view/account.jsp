<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="profile-section">
    <div class="container">
        <h1 class="profile-page-title">Tài khoản của tôi</h1>

        <div class="profile-layout">
            <aside class="profile-sidebar glass">
                <div class="user-brief">
                    <form class="brief-avatar" action="${pageContext.request.contextPath}/account"
                          method="post" enctype="multipart/form-data">
                        <div class="avatar-wrapper">
                            <img id="displayAvatar"
                                 src="${pageContext.request.contextPath}/images/default-avatar.png"
                                 alt="User Avatar">
                            <label for="avatarUpload" class="avatar-edit-icon"><i
                                    class="fa-solid fa-camera"></i></label>
                        </div>
                        <input type="file" id="avatarUpload" name="avatar" hidden accept="image/*">
                        <button type="submit" class="btn-save-avatar" id="btnSaveAvatar">
                            <i class="fa-solid fa-cloud-arrow-up"></i> Lưu ảnh đại diện
                        </button>
                    </form>
                    <div class="brief-info">
                        <span class="brief-name">${user.name != null ? user.name : 'Người dùng'}</span>
                    </div>
                </div>

                <nav class="profile-nav">
                    <button class="nav-item active" data-target="personal-info">
                        <i class="fa-solid fa-user-gear"></i> Thông tin cá nhân
                    </button>
                    <button class="nav-item" data-target="addresses">
                        <i class="fa-solid fa-location-dot"></i> Danh sách địa chỉ
                    </button>
                    <button class="nav-item" data-target="change-password">
                        <i class="fa-solid fa-shield-halved"></i> Đổi mật khẩu
                    </button>
                    <button class="nav-item" data-target="settings">
                        <i class="fa-solid fa-sliders"></i> Cài đặt tài khoản
                    </button>
                </nav>
            </aside>

            <main class="profile-content">
                <section id="personal-info" class="content-panel active">
                    <h2 class="section-title">Thông tin cá nhân</h2>
                    <p class="section-desc">Quản lý các thông tin cá nhân cơ bản của bạn</p>
                    <form id="profile-form" class="profile-form" method="post"
                          action="${pageContext.request.contextPath}/account">
                        <input type="hidden" name="action" value="updateProfile">
                        <div class="form-row">
                            <div class="form-group col-6">
                                <label>Họ và tên</label>
                                <input type="text" id="name" name="name" value="${user.name}"
                                       placeholder="Nhập họ và tên">
                                <span class="error-message" id="name-error">${error}</span>
                            </div>
                            <div class="form-group col-6">
                                <label>Số điện thoại</label>
                                <input type="tel" id="phone" name="phone" value="${user.phone}"
                                       placeholder="Nhập số điện thoại">
                                <span class="error-message" id="phone-error">${error}</span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label>Địa chỉ Email</label>
                            <input type="email" id="email" name="email" value="${user.email}"
                                   placeholder="Nhập email" disabled>
                            <span class="field-note">Bạn không thể thay đổi địa chỉ email liên kết</span>
                        </div>
                        <div class="form-row">
                            <div class="form-group col-6">
                                <label>Giới tính</label>
                                <select id="gender" name="gender">
                                    <option value="male" ${user.gender=='male' ? 'selected' : '' }>Nam
                                    </option>
                                    <option value="female" ${user.gender=='female' ? 'selected' : '' }>Nữ
                                    </option>
                                    <option value="other" ${user.gender !='male' && user.gender !='female'
                                            ? 'selected' : '' }>
                                        Khác
                                    </option>
                                </select>
                            </div>
                            <div class="form-group col-6">
                                <label>Ngày sinh</label>
                                <input type="text" id="birthday" name="birthday"
                                       value="${user.birthdayFormatted}" placeholder="dd/MM/yyyy">
                                <span class="error-message" id="birthday-error">${error}</span>
                            </div>
                        </div>
                        <button type="submit" class="btn-primary-premium">Cập nhật thông tin</button>
                    </form>
                </section>

                <section id="addresses" class="content-panel">
                    <div class="header-with-action">
                        <div>
                            <h2 class="section-title">Danh sách địa chỉ</h2>
                            <p class="section-desc">Địa chỉ nhận hàng mặc định và các địa chỉ khác</p>
                        </div>
                        <button id="addAddressBtn" class="btn-add-address">
                            <i class="fa-solid fa-plus"></i> Thêm địa chỉ mới
                        </button>
                    </div>

                    <div class="address-cards-list">
                        <c:choose>
                            <c:when test="${not empty addresses}">
                                <c:forEach var="addr" items="${addresses}">
                                    <div class="address-item-card ${addr.is_Default ? 'active' : ''}">
                                        <div class="address-header">
                                            <div class="addr-actions">
                                                <c:if test="${not addr.is_Default}">
                                                    <form action="${pageContext.request.contextPath}/account"
                                                          method="post">
                                                        <input type="hidden" name="action" value="deleteAddress">
                                                        <input type="hidden" name="addressId" value="${addr.id}">
                                                        <button type="submit" class="btn-icon-text text-danger"
                                                                title="Xóa địa chỉ">
                                                            <i class="fa-regular fa-trash-can"></i>
                                                        </button>
                                                    </form>
                                                </c:if>
                                            </div>
                                        </div>
                                        <p class="addr-detail">${addr.address}
                                            <c:if test="${addr.is_Default}">
                                                <span class="badge-default">Mặc định</span>
                                            </c:if>
                                        </p>
                                        <c:if test="${not addr.is_Default}">
                                            <form action="${pageContext.request.contextPath}/account" method="post"
                                                  style="display:inline;">
                                                <input type="hidden" name="action" value="setDefaultAddress">
                                                <input type="hidden" name="addressId" value="${addr.id}">
                                                <button type="submit" class="btn-set-default">
                                                    <i class="fa-regular fa-star"></i> Đặt làm mặc định
                                                </button>
                                            </form>
                                        </c:if>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <p style="font-style: italic; color:#b3b7bf">Không có địa chỉ nào.</p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </section>

                <section id="change-password" class="content-panel">
                    <h2 class="section-title">Đổi mật khẩu</h2>
                    <p class="section-desc">Thay đổi mật khẩu định kỳ để bảo mật tài khoản</p>
                    <form class="profile-form" id="password-form" method="post"
                          action="${pageContext.request.contextPath}/account">
                        <input type="hidden" name="action" value="changePassword">
                        <div class="form-group">
                            <label>Mật khẩu hiện tại</label>
                            <input type="password" id="oldPassword" name="oldPassword"
                                   placeholder="Nhập mật khẩu hiện tại">
                            <span class="error-message" id="oldPassword-error"></span>
                        </div>
                        <div class="form-group">
                            <label>Mật khẩu mới</label>
                            <input type="password" id="newPassword" name="newPassword" placeholder="Nhập mật khẩu mới">
                            <span class="error-message" id="newPassword-error"></span>
                        </div>
                        <div class="form-group">
                            <label>Xác nhận mật khẩu mới</label>
                            <input type="password" id="confirmNew" name="confirmNew"
                                   placeholder="Xác nhận lại mật khẩu mới">
                            <span class="error-message" id="confirmNew-error"></span>
                        </div>
                        <button type="submit" class="btn-primary-premium">Cập nhật mật khẩu</button>
                    </form>
                </section>

                <section id="settings" class="content-panel">
                    <h2 class="section-title">Cài đặt tài khoản</h2>
                    <p class="section-desc">Tùy chỉnh các thông báo và cài đặt riêng tư</p>
                    <div class="settings-list">
                        <div class="settings-item danger-zone">
                            <div class="item-info">
                                <h4>Vô hiệu hóa tài khoản</h4>
                                <p>Cảnh báo: Tài khoản sẽ không thể đăng nhập sau khi vô hiệu hóa</p>
                            </div>
                            <button class="btn-outline-danger" id="disableBtn">Xử lý ngay</button>
                        </div>
                    </div>
                </section>
            </main>
        </div>
    </div>
</div>

<div id="add-address-modal" class="modal">
    <div class="modal-content">
        <div class="modal-close-icon" data-dismiss="modal">&times;</div>
        <div class="modal-header">
            <h3>Thêm địa chỉ mới</h3>
        </div>
        <form id="address-form" method="post" action="${pageContext.request.contextPath}/account">
            <input type="hidden" name="action" value="addAddress">
            <div class="modal-body">
                <div class="form-group">
                    <label>Địa chỉ chi tiết</label>
                    <textarea id="streetAddress" name="streetAddress" rows="3"
                              placeholder="Số nhà, tên đường, tòa nhà..."></textarea>
                    <span class="error-message" id="streetAddress-error"></span>
                </div>
                <div class="form-group" style="margin-top: 20px;">
                    <label class="checkbox-wrapper">
                        <input type="checkbox" name="isDefault" id="isDefault">
                        <span class="checkbox-text">Đặt làm địa chỉ mặc định</span>
                    </label>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn-secondary" data-dismiss="modal">
                    Hủy bỏ
                </button>
                <button type="submit" class="btn-modal-save">Lưu địa chỉ</button>
            </div>
        </form>
    </div>
</div>

<div id="notification-modal" class="modal">
    <div class="modal-content">
        <div class="modal-header success">
            <h3><i class="fa-solid fa-circle-check"></i> <span id="success-modal-title">Thành công!</span></h3>
            <span class="modal-close-icon" data-dismiss="modal"><i class="fa-solid fa-xmark"></i></span>
        </div>
        <div class="modal-body">
            <p id="success-modal-message">Thông tin của bạn đã được cập nhật thành công.</p>
        </div>
        <div class="modal-footer">
            <button id="ok-btn" class="btn-modal-ok" data-dismiss="modal">Đồng ý</button>
        </div>
    </div>
</div>

<div id="error-modal" class="modal">
    <div class="modal-content">
        <div class="modal-header error">
            <h3><i class="fa-solid fa-circle-exclamation"></i> <span id="error-modal-title">Có lỗi xảy ra</span></h3>
            <span class="modal-close-icon" data-dismiss="modal"><i class="fa-solid fa-xmark"></i></span>
        </div>
        <div class="modal-body">
            <p id="error-modal-message">
                <c:choose>
                    <c:when test="${not empty sessionScope.error}">
                        ${sessionScope.error}
                        <% session.removeAttribute("error"); %>
                    </c:when>
                    <c:otherwise>Không thể thực hiện yêu cầu lúc này. Vui lòng kiểm tra lại.</c:otherwise>
                </c:choose>
            </p>
        </div>
        <div class="modal-footer">
            <button class="btn-modal-ok" data-dismiss="modal">Đóng</button>
        </div>
    </div>
</div>

<div id="deactivate-modal" class="modal">
    <div class="modal-content">
        <div class="modal-close-icon" data-dismiss="modal">&times;</div>
        <div class="modal-header danger-header">
            <h3><i class="fa-solid fa-triangle-exclamation"></i> Xác nhận vô hiệu hóa</h3>
        </div>
        <div class="modal-body danger-body">
            <div class="warning-icon-large">
                <i class="fa-solid fa-user-slash"></i>
            </div>
            <h4>Bạn có chắc chắn muốn vô hiệu hóa tài khoản?</h4>
            <p>Hành động này sẽ ngăn bạn đăng nhập vào hệ thống. Mọi dữ liệu cá nhân sẽ được bảo lưu nhưng tài khoản sẽ ở trạng thái không hoạt động cho đến khi được quản trị viên kích hoạt lại.</p>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn-secondary" data-dismiss="modal">
                Hủy bỏ
            </button>
            <button type="button" class="btn-danger-premium" id="dangerBtn" style="flex: 2;">Vô hiệu hóa ngay</button>
        </div>
    </div>
</div>

<div id="password-confirm-modal" class="modal">
    <div class="modal-content">
        <div class="modal-close-icon" data-dismiss="modal">&times;</div>
        <div class="modal-header">
            <h3><i class="fa-solid fa-shield-halved"></i> Xác thực mật khẩu</h3>
        </div>
        <form id="deactivate-form" method="post" action="${pageContext.request.contextPath}/account">
            <input type="hidden" name="action" value="deactivateAccount">
            <div class="modal-body" style="text-align: left; padding: 0 30px 10px;">
                <p style="color: #697386; margin-bottom: 20px;">Để bảo mật, vui lòng nhập mật khẩu tài khoản của bạn để xác nhận hành động vô hiệu hóa này.</p>
                <div class="form-group">
                    <label>Mật khẩu tài khoản</label>
                    <input type="password" name="confirmPassword" id="confirmPassword" placeholder="Nhập mật khẩu của bạn" required>
                    <span class="error-message" id="confirmPassword-error">${error}</span>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn-secondary" data-dismiss="modal">
                    Quay lại
                </button>
                <button type="submit" class="btn-danger-premium" style="flex: 2;">Xác nhận và vô hiệu hóa</button>
            </div>
        </form>
    </div>
</div>
<script>
    const CONTEXTPATH = "${pageContext.request.contextPath}";
</script>
<script src="${pageContext.request.contextPath}/js/account.js"></script>