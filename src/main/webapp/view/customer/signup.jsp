<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="signup-page">
    <div class="signup-card">
        <div class="signup-icon">
            <i class="fa-solid fa-user-plus"></i>
        </div>
        <h2 class="signup-title">Đăng ký</h2>
        <p class="signup-subtitle">Tạo tài khoản mới để bắt đầu mua sắm</p>
        <form id="signup-form" action="${pageContext.request.contextPath}/sign-up" method="post">
            <div class="form-group">
                <label>Họ và tên</label>
                <div class="form-input">
                    <i class="fa-regular fa-user"></i>
                    <input type="text" id="name" class="input-box" name="name" placeholder="Nguyễn Văn A">
                </div>
            </div>

            <div class="form-group">
                <label>Email</label>
                <div class="form-input">
                    <i class="fa-solid fa-envelope"></i>
                    <input type="email" id="email" class="input-box" name="email" placeholder="example@email.com">
                </div>
            </div>

            <div class="form-group">
                <label>Số điện thoại</label>
                <div class="form-input">
                    <i class="fa-solid fa-phone"></i>
                    <input type="text" id="phone" class="input-box" name="phone" placeholder="0123456789">
                </div>
            </div>

            <div class="form-group">
                <label>Mật khẩu</label>
                <div class="form-input">
                    <i class="fa-solid fa-lock"></i>
                    <input type="password" id="password" class="input-box" name="password" placeholder="••••••••">
                </div>
            </div>

            <div class="form-group">
                <label>Xác nhận mật khẩu</label>
                <div class="form-input">
                    <i class="fa-solid fa-lock"></i>
                    <input type="password" id="confirmPassword" class="input-box" name="confirmPassword"
                           placeholder="••••••••">
                </div>
            </div>

            <p id="error">${error}</p>

            <button type="submit" class="btn-signup">Đăng ký</button>
        </form>

        <div class="social-divider">
            <span>Hoặc đăng ký bằng</span>
        </div>

        <div class="social-login">
            <button class="btn-social google">
                <i class="fa-brands fa-google"></i>
                Google
            </button>
            <button class="btn-social facebook">
                <i class="fa-brands fa-facebook"></i>
                Facebook
            </button>
        </div>

        <p class="register-text">
            Đã có tài khoản?
            <a href="${pageContext.request.contextPath}/sign-in">Đăng nhập ngay</a>
        </p>
    </div>
    <a href="${pageContext.request.contextPath}/home" class="back-home">
        ← Quay về trang chủ
    </a>
</div>

<div class="modal" id="verify-modal">
    <div class="modal-content">
        <button class="modal-close-icon close-btn"><i class="fa-solid fa-xmark"></i></button>
        <div class="modal-header success">
            <h3><i class="fa-solid fa-circle-check"></i> Thông báo</h3>
        </div>
        <div class="modal-body">
            <p>Xác thực email thành công! Bạn có thể đăng nhập.</p>
        </div>
        <div class="modal-footer">
            <a href="${pageContext.request.contextPath}/sign-in">
                <button class="btn-modal-ok">Đăng nhập</button>
            </a>
        </div>
    </div>
</div>

<div class="modal" id="error-modal">
    <div class="modal-content">
        <button class="modal-close-icon close-btn"><i class="fa-solid fa-xmark"></i></button>
        <div class="modal-header error">
            <h3><i class="fa-solid fa-circle-xmark"></i> Lỗi</h3>
        </div>
        <div class="modal-body">
            <p>Link xác thực không hợp lệ hoặc đã hết hạn.</p>
        </div>
        <div class="modal-footer">
            <a href="${pageContext.request.contextPath}/sign-in">
                <button class="btn-modal-ok" style="background: #ef4444; box-shadow: 0 4px 12px rgba(239, 68, 68, 0.3);">Đăng nhập</button>
            </a>
        </div>
    </div>
</div>

<div class="modal" id="register-success-modal">
    <div class="modal-content">
        <div class="modal-header success">
            <h3><i class="fa-solid fa-circle-check"></i> Đăng ký thành công</h3>
        </div>
        <div class="modal-body">
            <p>Vui lòng kiểm tra email để xác thực tài khoản.</p>
        </div>
    </div>
</div>

<c:if test="${param.verified == 'true'}">
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            document.getElementById("verify-modal").classList.add("show");
        });
    </script>
</c:if>
<c:if test="${param.error == 'invalid-token'}">
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            document.getElementById("error-modal").classList.add("show");
        });
    </script>
</c:if>

<c:if test="${param.signup == 'success'}">
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            document.getElementById("register-success-modal").classList.add("show");
        });
    </script>
</c:if>