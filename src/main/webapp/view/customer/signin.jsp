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

            <a href="#" class="forgot-password-link" id="forgotPasswordBtn">Quên mật khẩu?</a>

            <c:if test="${not empty message}">
                <p class="success-message">${message}</p>
            </c:if>

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

<div class="modal-overlay" id="forgotPasswordModal">
    <div class="modal-content">
        <i class="fa-solid fa-xmark close-modal" id="closeForgotModal"></i>
        <div class="modal-header">
            <i class="fa-solid fa-circle-question"></i>
            <h3>Quên mật khẩu?</h3>
            <p>Nhập email của bạn để nhận link khôi phục mật khẩu.</p>
        </div>
        <form id="forgotPasswordForm">
            <div class="form-group">
                <label>Email</label>
                <div class="form-input">
                    <i class="fa-solid fa-envelope"></i>
                    <input type="email" id="forgotEmail" class="input-box" placeholder="example@email.com" required>
                </div>
                <p class="error" id="forgotError" style="display: none;"></p>
            </div>
            <button type="submit" class="btn-login" id="sendEmailBtn">
                <span class="loading-spinner" id="spinner"></span>
                Gửi yêu cầu
            </button>
        </form>
    </div>
</div>

<div class="modal-overlay" id="successModal">
    <div class="modal-content">
        <i class="fa-solid fa-xmark close-modal" id="closeSuccessModal"></i>
        <div class="modal-header">
            <i class="fa-solid fa-circle-check" style="color: #10b981;"></i>
            <h3>Thành công!</h3>
            <p>Link khôi phục mật khẩu đã được gửi tới email của bạn. Vui lòng kiểm tra hộp thư.</p>
        </div>
        <button class="btn-login" id="backToLoginBtn">Quay lại đăng nhập</button>
    </div>
</div>

<script>
    const forgotPasswordBtn = document.getElementById('forgotPasswordBtn');
    const forgotPasswordModal = document.getElementById('forgotPasswordModal');
    const successModal = document.getElementById('successModal');
    const closeForgotModal = document.getElementById('closeForgotModal');
    const closeSuccessModal = document.getElementById('closeSuccessModal');
    const forgotPasswordForm = document.getElementById('forgotPasswordForm');
    const forgotEmail = document.getElementById('forgotEmail');
    const forgotError = document.getElementById('forgotError');
    const sendEmailBtn = document.getElementById('sendEmailBtn');
    const spinner = document.getElementById('spinner');
    const backToLoginBtn = document.getElementById('backToLoginBtn');

    forgotPasswordBtn.addEventListener('click', (e) => {
        e.preventDefault();
        forgotPasswordModal.classList.add('active');
    });

    const closeAll = () => {
        forgotPasswordModal.classList.remove('active');
        successModal.classList.remove('active');
        forgotError.style.display = 'none';
        forgotPasswordForm.reset();
    };

    closeForgotModal.addEventListener('click', closeAll);
    closeSuccessModal.addEventListener('click', closeAll);
    backToLoginBtn.addEventListener('click', closeAll);

    window.addEventListener('click', (e) => {
        if (e.target === forgotPasswordModal || e.target === successModal) {
            closeAll();
        }
    });

    forgotPasswordForm.addEventListener('submit', async (e) => {
        e.preventDefault();
        
        const email = forgotEmail.value.trim();
        if (!email) return;

        forgotError.style.display = 'none';
        sendEmailBtn.disabled = true;
        spinner.style.display = 'inline-block';

        try {
            const response = await fetch('${pageContext.request.contextPath}/forgot-password', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: `email=\${encodeURIComponent(email)}`
            });

            const data = await response.json();
            
            if (data.success) {
                forgotPasswordModal.classList.remove('active');
                successModal.classList.add('active');
            } else {
                forgotError.textContent = data.message;
                forgotError.style.display = 'block';
            }
        } catch (error) {
            forgotError.textContent = 'Có lỗi xảy ra, vui lòng thử lại sau.';
            forgotError.style.display = 'block';
        } finally {
            sendEmailBtn.disabled = false;
            spinner.style.display = 'none';
        }
    });
</script>