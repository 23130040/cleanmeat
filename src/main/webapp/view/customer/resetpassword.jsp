<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="login-page">
    <div class="login-card">
        <div class="login-icon">
            <i class="fa-solid fa-key"></i>
        </div>
        <h2 class="login-title">Đặt lại mật khẩu</h2>
        <p class="login-subtitle">Vui lòng nhập mật khẩu mới cho tài khoản của bạn.</p>
        
        <form action="${pageContext.request.contextPath}/reset-password" method="post">
            <input type="hidden" name="token" value="${token}">
            
            <div class="form-group">
                <label>Mật khẩu mới</label>
                <div class="form-input">
                    <i class="fa-solid fa-lock"></i>
                    <input type="password" class="input-box" name="password" placeholder="••••••••" required>
                </div>
            </div>

            <div class="form-group">
                <label>Xác nhận mật khẩu</label>
                <div class="form-input">
                    <i class="fa-solid fa-shield-check"></i>
                    <input type="password" class="input-box" name="confirmPassword" placeholder="••••••••" required>
                </div>
            </div>

            <c:if test="${not empty error}">
                <p class="error">${error}</p>
            </c:if>

            <button type="submit" class="btn-login">Cập nhật mật khẩu</button>
        </form>

        <p class="signin-text">
            Nhớ mật khẩu?
            <a href="${pageContext.request.contextPath}/sign-in">Đăng nhập</a>
        </p>
    </div>
    <a href="${pageContext.request.contextPath}/home" class="back-home">
        ← Quay về trang chủ
    </a>
</div>
