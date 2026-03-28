<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="profile-section">
    <div class="container">
        <h1 class="profile-page-title">Tài khoản của tôi</h1>

        <div class="profile-layout">
            <aside class="profile-sidebar glass">
                <div class="user-brief">
                    <div class="brief-avatar">
                        <img id="displayAvatar" src="${pageContext.request.contextPath}/images/default-avatar.png" alt="User Avatar">
                        <label for="avatarUpload" class="avatar-edit-icon"><i class="fa-solid fa-camera"></i></label>
                        <input type="file" id="avatarUpload" hidden accept="image/*">
                    </div>
                    <div class="brief-info">
                        <span class="brief-name">${user.name != null ? user.name : 'Người dùng'}</span>
                        <span class="brief-sub">Thành viên mẫn cán</span>
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
                    <form class="profile-form">
                        <div class="form-row">
                            <div class="form-group col-6">
                                <label>Họ và tên</label>
                                <input type="text" value="${user.name}" placeholder="Nhập họ và tên">
                            </div>
                            <div class="form-group col-6">
                                <label>Số điện thoại</label>
                                <input type="tel" value="${user.phone}" placeholder="Nhập số điện thoại">
                            </div>
                        </div>
                        <div class="form-group">
                            <label>Địa chỉ Email</label>
                            <input type="email" value="${user.email}" placeholder="Nhập email" disabled>
                            <span class="field-note">Bạn không thể thay đổi địa chỉ email liên kết</span>
                        </div>
                        <div class="form-row">
                            <div class="form-group col-6">
                                <label>Giới tính</label>
                                <select>
                                    <option value="male">Nam</option>
                                    <option value="female">Nữ</option>
                                    <option value="other">Khác</option>
                                </select>
                            </div>
                            <div class="form-group col-6">
                                <label>Ngày sinh</label>
                                <input type="date">
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
                        <button class="btn-add-address"><i class="fa-solid fa-plus"></i> Thêm địa chỉ mới</button>
                    </div>

                    <div class="address-cards-list">
                        <div class="address-item-card active">
                            <div class="address-header">
                                <h4 class="addr-name">Nguyễn Văn A <span class="badge-default">Mặc định</span></h4>
                                <div class="addr-actions">
                                    <button class="btn-icon-text">Sửa</button>
                                    <button class="btn-icon-text text-danger">Xóa</button>
                                </div>
                            </div>
                            <p class="addr-phone">0901234567</p>
                            <p class="addr-detail">123 Đường ABC, Phường 1, Quận 1, TP. Hồ Chí Minh</p>
                        </div>

                        <div class="address-item-card">
                            <div class="address-header">
                                <h4 class="addr-name">Nguyễn Văn B</h4>
                                <div class="addr-actions">
                                    <button class="btn-icon-text">Sửa</button>
                                    <button class="btn-icon-text text-danger">Xóa</button>
                                </div>
                            </div>
                            <p class="addr-phone">0908765432</p>
                            <p class="addr-detail">456 Đường XYZ, Phường Tân Quy, Quận 7, TP. Hồ Chí Minh</p>
                            <button class="btn-set-default">Thiết lập mặc định</button>
                        </div>
                    </div>
                </section>

                <section id="change-password" class="content-panel">
                    <h2 class="section-title">Đổi mật khẩu</h2>
                    <p class="section-desc">Thay đổi mật khẩu định kỳ để bảo mật tài khoản</p>
                    <form class="profile-form">
                        <div class="form-group">
                            <label>Mật khẩu hiện tại</label>
                            <input type="password" placeholder="Nhập mật khẩu hiện tại">
                        </div>
                        <div class="form-group">
                            <label>Mật khẩu mới</label>
                            <input type="password" placeholder="Nhập mật khẩu mới">
                        </div>
                        <div class="form-group">
                            <label>Xác nhận mật khẩu mới</label>
                            <input type="password" placeholder="Xác nhận lại mật khẩu mới">
                        </div>
                        <button type="submit" class="btn-primary-premium">Cập nhật mật khẩu</button>
                    </form>
                </section>

                <section id="settings" class="content-panel">
                    <h2 class="section-title">Cài đặt tài khoản</h2>
                    <p class="section-desc">Tùy chỉnh các thông báo và cài đặt riêng tư</p>
                    <div class="settings-list">
                        <div class="settings-item">
                            <div class="item-info">
                                <h4>Thông báo qua Email</h4>
                                <p>Nhận cập nhật về các ưu đãi và đơn hàng mới</p>
                            </div>
                            <label class="switch">
                                <input type="checkbox" checked>
                                <span class="slider round"></span>
                            </label>
                        </div>
                        <div class="settings-item">
                            <div class="item-info">
                                <h4>Thông báo qua SMS</h4>
                                <p>Nhận mã ưu đãi trực tiếp vào tin nhắn</p>
                            </div>
                            <label class="switch">
                                <input type="checkbox">
                                <span class="slider round"></span>
                            </label>
                        </div>
                        <div class="settings-item danger-zone">
                            <div class="item-info">
                                <h4>Vô hiệu hóa tài khoản</h4>
                                <p>Cảnh báo: Tài khoản sẽ không thể đăng nhập sau khi vô hiệu hóa</p>
                            </div>
                            <button class="btn-outline-danger">Xử lý ngay</button>
                        </div>
                    </div>
                </section>
            </main>
        </div>
    </div>
</div>
