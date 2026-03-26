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
                    <input type="password" id="confirmPassword" class="input-box" name="confimPassword"
                           placeholder="••••••••">
                </div>
            </div>

            <p id="error"></p>

            <button type="submit" class="btn-signup">Đăng ký</button>
        </form>

        <p class="register-text">
            Đã có tài khoản?
            <a href="${pageContext.request.contextPath}/sign-in">Đăng nhập ngay</a>
        </p>
    </div>
    <a href="${pageContext.request.contextPath}/home" class="back-home">
        ← Quay về trang chủ
    </a>
</div>