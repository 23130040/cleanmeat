<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Clean Meat - Admin</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/baseAdmin.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/${requestScope.pageCss}">
</head>
<body>
<nav>
    <div class="nav-logo">
        <img src="${pageContext.request.contextPath}/images/cleanmeat.png"> <span
            style="color:white; font-size:20px; font-weight: 600; margin-left: 5px" id="navTitle">Clean Meat</span>
    </div>
    <ul class="nav-menu">
        <li class="${active == 'dashboard' ? 'active' : ''}"><a href="${pageContext.request.contextPath}/dashboard"><i
                class="fa-solid fa-chart-column"></i> Dashboard</a>
        </li>
        <li class="${active == 'user-admin' ? 'active' : ''}"><a href="${pageContext.request.contextPath}/user-admin"><i
                class="fa-regular fa-user"></i> Người dùng</a></li>
        <li class="${active == 'products-admin' ? 'active' : ''}"><a
                href="${pageContext.request.contextPath}/products-admin"><i
                class="fa-solid fa-store"></i> Sản phẩm</a></li>
        <li class="${active == 'orders-admin' ? 'active' : ''}"><a
                href="${pageContext.request.contextPath}/orders-admin"><i
                class="fa-solid fa-bag-shopping"></i> Đơn hàng</a></li>
        <li class="${active == 'stock-history-admin' ? 'active' : ''}"><a
                href="${pageContext.request.contextPath}/stock-history-admin"><i
                class="fa-brands fa-stack-overflow"></i> Lịch sử kho</a></li>
        <li class="${active == 'news-admin' ? 'active' : ''}"><a
                href="${pageContext.request.contextPath}/news-admin"><i class="fa-regular fa-newspaper"></i>
            Tin tức</a></li>
        <li class="${active == 'payment-admin' ? 'active' : ''}"><a
                href="${pageContext.request.contextPath}/payment-admin"><i class="fa-regular fa-credit-card"></i>
            Thanh toán</a></li>
        <li class="${active == 'transport-admin' ? 'active' : ''}"><a
                href="${pageContext.request.contextPath}/transport-admin"><i class="fa-regular fa-truck"></i>
            Vận chuyển</a></li>
        <li class="${active == 'origin-admin' ? 'active' : ''}"><a
                href="${pageContext.request.contextPath}/origin-admin"><i class="fa-solid fa-location-dot"></i>
            Xuất xứ</a></li>
        <li class="${active == 'feedback-admin' ? 'active' : ''}"><a
                href="${pageContext.request.contextPath}/feedback-admin"><i class="fa-regular fa-star"></i>
            Phản hồi</a></li>
        <li class="${active == 'system-admin' ? 'active' : ''}"><a
                href="${pageContext.request.contextPath}/system-admin"><i class="fa-solid fa-gear"></i>
            Cấu hình hệ thống</a></li>

    </ul>
    <div class="nav-footer">
        <p>© 2026 CleanMeat Admin</p>
    </div>
</nav>
<main>
    <div class="container">
        <header class="main-header">
            <button class="header-btn" onclick="toggleSidebar()"><i class="fa-solid fa-outdent"
                                                                    id="sidebarToggleIcon"></i></button>
            <h1 class="header-title">${requestScope.adminTitle}</h1>
            <div class="header-user">
                <button class="header-btn">
                    <i class="fa-regular fa-bell"></i>
                    <span id="noti-count">0</span>
                </button>
                <div class="user-profile-container" style="position: relative;">
                    <div class="user-info" onclick="toggleAdminDropdown(event)">
                        <div class="user-avatar-wrapper">
                            <c:choose>
                                <c:when test="${not empty user.avatar}">
                                    <img src="${user.avatar}" class="user-avatar">
                                </c:when>
                                <c:otherwise>
                                    <div class="user-avatar placeholder"><i class="fa-solid fa-user"></i></div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="user-name">
                            <span>${user.name}</span>
                            <span>Quản trị viên</span>
                        </div>
                        <button class="user-down"><i class="fa-solid fa-angle-down"></i></button>
                    </div>

                    <div class="admin-dropdown-menu" id="adminDropdown">
                        <div class="dropdown-header">
                            <span class="dd-name">${user.name}</span>
                            <span class="dd-email">${user.email}</span>
                        </div>
                        <div class="dropdown-divider"></div>
                        <a href="javascript:void(0)" onclick="openAccountModal(event)" class="dropdown-item">
                            <i class="fa-solid fa-user-gear"></i> Thông tin tài khoản
                        </a>
                        <a href="${pageContext.request.contextPath}/sign-out" class="dropdown-item text-danger">
                            <i class="fa-solid fa-arrow-right-from-bracket"></i> Đăng xuất
                        </a>
                    </div>
                </div>
            </div>
        </header>
        <div class="page-content">
            <c:import url="${requestScope.pageContent}"></c:import>
        </div>
    </div>
</main>
<div class="admin-modal-overlay" id="adminAccountModal">
    <div class="admin-modal-container">
        <div class="modal-topbar">
            <h2>Thông tin tài khoản</h2>
            <button class="btn-close-modal" onclick="closeAccountModal()"><i class="fa-solid fa-xmark"></i></button>
        </div>

        <div class="modal-tabs">
            <button class="tab-btn active" onclick="switchAccountTab('info', this)">
                <i class="fa-regular fa-user"></i> Thông tin cá nhân
            </button>
            <button class="tab-btn" onclick="switchAccountTab('password', this)">
                <i class="fa-solid fa-lock"></i> Đổi mật khẩu
            </button>
        </div>

        <form method="post" action="${pageContext.request.contextPath}/edit-info" class="tab-content active"
              id="tab-info" enctype="multipart/form-data">
            <input type="hidden" name="action" value="changeInfo">
            <div class="user-summary-card">
                <div class="us-avatar-container">
                    <div class="us-avatar">
                        <c:choose>
                            <c:when test="${not empty user.avatar}">
                                <img src="${user.avatar}" alt="Avatar" id="preview-avatar">
                            </c:when>
                            <c:otherwise>
                                <i class="fa-solid fa-user" id="preview-avatar-icon"></i>
                                <img src="" alt="Avatar" id="preview-avatar" style="display:none;">
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <label for="avatar-upload" class="avatar-edit-btn">
                        <i class="fa-solid fa-camera"></i>
                    </label>
                    <input type="file" id="avatar-upload" name="avatar" accept="image/*" style="display: none;"
                           onchange="previewAvatar(event)">
                </div>
                <div class="us-details">
                    <h3>${user.name}</h3>
                    <p>Admin</p>
                    <span>Tham gia: <c:choose><c:when
                            test="${not empty user.created_at}">${user.created_at.toLocalDate()}</c:when><c:otherwise>1/1/1999</c:otherwise></c:choose></span>
                </div>
            </div>

            <div class="admin-form-group">
                <label>Họ và tên</label>
                <input type="text" class="admin-input-control" name="name" value="${user.name}">
            </div>
            <div class="admin-form-group">
                <label>Email</label>
                <input type="text" class="admin-input-control" value="${user.email}" readonly>
            </div>
            <div class="admin-form-group">
                <label>Số điện thoại</label>
                <input type="text" class="admin-input-control" name="phone" value="${user.phone}">
            </div>

            <div class="form-actions-left">
                <button class="btn-edit-outline" type="submit">
                    <i class="fa-solid fa-pen"></i> Chỉnh sửa
                </button>
            </div>
        </form>

        <div class="tab-content" id="tab-password">
            <div class="admin-form-group">
                <label>Mật khẩu hiện tại</label>
                <input type="password" class="admin-input-control" placeholder="••••••••">
            </div>
            <div class="admin-form-group">
                <label>Mật khẩu mới</label>
                <input type="password" class="admin-input-control" placeholder="••••••••">
            </div>
            <div class="admin-form-group">
                <label>Xác nhận mật khẩu mới</label>
                <input type="password" class="admin-input-control" placeholder="••••••••">
            </div>
            <div class="form-actions-full">
                <button class="btn-update-solid" onclick="alert('Tính năng cập nhật chưa kích hoạt database!')">Cập nhật
                    mật khẩu
                </button>
            </div>
        </div>
    </div>
</div>

<c:if test="${not empty param.success}">
    <div class="admin-alert-modal show" id="adminSuccessModal">
        <div class="admin-alert-content">
            <button class="btn-close-alert" onclick="this.closest('.admin-alert-modal').classList.remove('show')"><i class="fa-solid fa-xmark"></i></button>
            <div class="alert-icon success"><i class="fa-solid fa-circle-check"></i></div>
            <h3>Thành công!</h3>
            <p>
                <c:choose>
                    <c:when test="${param.success == 'info_updated'}">Cập nhật thông tin cá nhân thành công.</c:when>
                    <c:when test="${param.success == 'password_updated'}">Đổi mật khẩu thành công.</c:when>
                    <c:otherwise>Thao tác đã được thực hiện.</c:otherwise>
                </c:choose>
            </p>
            <button class="btn-alert-ok" onclick="this.closest('.admin-alert-modal').classList.remove('show')">Đồng ý</button>
        </div>
    </div>
</c:if>

<c:if test="${not empty param.error}">
    <div class="admin-alert-modal show" id="adminErrorModal">
        <div class="admin-alert-content">
            <button class="btn-close-alert" onclick="this.closest('.admin-alert-modal').classList.remove('show')"><i class="fa-solid fa-xmark"></i></button>
            <div class="alert-icon error"><i class="fa-solid fa-circle-xmark"></i></div>
            <h3>Có lỗi xảy ra</h3>
            <p>
                <c:choose>
                    <c:when test="${param.error == 'update_failed'}">Có lỗi trong quá trình cập nhật, vui lòng thử lại.</c:when>
                    <c:when test="${param.error == 'wrong_password'}">Mật khẩu hiện tại không chính xác.</c:when>
                    <c:otherwise>Đã có lỗi không xác định xảy ra.</c:otherwise>
                </c:choose>
            </p>
            <button class="btn-alert-ok" style="background-color: #ef4444;" onclick="this.closest('.admin-alert-modal').classList.remove('show')">Đóng lại</button>
        </div>
    </div>
</c:if>

</body>
<script src="${pageContext.request.contextPath}/js/baseAdmin.js"></script>
</html>
