<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="login-page">
    <div class="login-card">
        <div class="login-icon">
            <i class="fa-regular fa-user"></i>
        </div>
        <h2 class="login-title">Đăng nhập</h2>
        <p class="login-subtitle">Chào mừng bạn quay trở lại!</p>
        <form action="${pageContext.request.contextPath}/sign-in" method="post">
            <div class="form-group">
                <label>Email</label>
                <div class="form-input">
                    <i class="fa-solid fa-envelope"></i>
                    <input type="email" class="input-box" name="email" placeholder="example@email.com" required>
                </div>
            </div>

            <div class="form-group">
                <label>Mật khẩu</label>
                <div class="form-input">
                    <i class="fa-solid fa-lock"></i>
                    <input type="password" class="input-box" name="password" placeholder="••••••••" required>
                </div>
            </div>

            <p class="error">${error}</p>

            <button type="submit" class="btn-login">Đăng nhập</button>
        </form>

        <p class="signin-text">
            Chưa có tài khoản?
            <a href="${pageContext.request.contextPath}/sign-up">Đăng ký ngay</a>
        </p>
    </div>
    <a href="${pageContext.request.contextPath}/home" class="back-home">
        ← Quay về trang chủ
    </a>
</div>