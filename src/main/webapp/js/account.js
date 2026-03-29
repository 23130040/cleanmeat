document.addEventListener('DOMContentLoaded', function () {

    function switchTab(targetId) {
        document.querySelectorAll('.nav-item').forEach(btn =>
            btn.classList.remove('active')
        );

        document.querySelectorAll('.content-panel').forEach(panel =>
            panel.classList.remove('active')
        );

        const activeBtn = document.querySelector(`.nav-item[data-target="${targetId}"]`);
        const activePanel = document.getElementById(targetId);

        if (activeBtn && activePanel) {
            activeBtn.classList.add('active');
            activePanel.classList.add('active');
            window.location.hash = targetId;
        }
    }

    document.querySelectorAll('.nav-item').forEach(button => {
        button.addEventListener('click', function () {
            const target = this.getAttribute('data-target');
            switchTab(target);
        });
    });

    const hash = window.location.hash.substring(1);
    if (hash) {
        switchTab(hash);
    }

    const profileForm = document.getElementById('profile-form');

    if (profileForm) {
        profileForm.addEventListener('submit', function (e) {
            let isValid = true;

            const nameInput = document.getElementById('name');
            const nameError = document.getElementById('name-error');
            const phoneInput = document.getElementById('phone');
            const phoneError = document.getElementById('phone-error');
            const birthdayInput = document.getElementById('birthday');
            const birthdayError = document.getElementById('birthday-error');

            clearError(nameInput, nameError);
            clearError(phoneInput, phoneError);
            clearError(birthdayInput, birthdayError);

            if (nameInput.value.trim() === '') {
                showError(nameInput, nameError, 'Họ và tên không được để trống');
                isValid = false;
            }

            const phoneRegex = /^(0|84)(3|5|7|8|9)\d{8}$/;
            const phoneVal = phoneInput.value.trim().replace(/\s/g, '');

            if (phoneVal === '') {
                showError(phoneInput, phoneError, 'Số điện thoại không được để trống');
                isValid = false;
            } else if (!phoneRegex.test(phoneVal)) {
                showError(phoneInput, phoneError, 'Số điện thoại không hợp lệ');
                isValid = false;
            }

            if (!validateBirthday()) {
                isValid = false;
            }

            if (!isValid) e.preventDefault();
        });

        function validateBirthday() {
            const birthdayInput = document.getElementById('birthday');
            const birthdayError = document.getElementById('birthday-error');
            const value = birthdayInput.value.trim();

            if (value === '') {
                showError(birthdayInput, birthdayError, 'Vui lòng nhập ngày sinh');
                return false;
            }

            const birthdayRegex = /^(\d{1,2})\/(\d{1,2})\/(\d{4})$/;
            const match = value.match(birthdayRegex);

            if (!match) {
                showError(birthdayInput, birthdayError, 'Định dạng phải là dd/MM/yyyy');
                return false;
            }

            const day = parseInt(match[1], 10);
            const month = parseInt(match[2], 10) - 1;
            const year = parseInt(match[3], 10);

            const selectedDate = new Date(year, month, day);
            const today = new Date();

            if (
                month < 0 || month > 11 ||
                day < 1 || day > 31 ||
                selectedDate.getMonth() !== month ||
                selectedDate.getDate() !== day
            ) {
                showError(birthdayInput, birthdayError, 'Ngày sinh không hợp lệ');
                return false;
            }

            if (selectedDate > today) {
                showError(birthdayInput, birthdayError, 'Ngày sinh không thể ở tương lai');
                return false;
            }

            clearError(birthdayInput, birthdayError);
            return true;
        }
    }

    const passwordForm = document.getElementById('password-form');
    if (passwordForm) {
        passwordForm.addEventListener('submit', function (e) {
            let isValid = true;
            const oldPass = document.getElementById('oldPassword');
            const newPass = document.getElementById('newPassword');
            const confirmPass = document.getElementById('confirmNew');
            
            const oldError = document.getElementById('oldPassword-error');
            const newError = document.getElementById('newPassword-error');
            const confirmError = document.getElementById('confirmNew-error');

            clearError(oldPass, oldError);
            clearError(newPass, newError);
            clearError(confirmPass, confirmError);

            if (oldPass.value.trim() === '') {
                showError(oldPass, oldError, 'Vui lòng nhập mật khẩu hiện tại');
                isValid = false;
            }

            const passRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$/;
            if (newPass.value.trim() === '') {
                showError(newPass, newError, 'Vui lòng nhập mật khẩu mới');
                isValid = false;
            } else if (!passRegex.test(newPass.value)) {
                showError(newPass, newError, 'Mật khẩu phải có ít nhất 8 ký tự, bao gồm chữ hoa, chữ thường, số và ký tự đặc biệt');
                isValid = false;
            }

            if (confirmPass.value.trim() === '') {
                showError(confirmPass, confirmError, 'Vui lòng xác nhận mật khẩu mới');
                isValid = false;
            } else if (confirmPass.value !== newPass.value) {
                showError(confirmPass, confirmError, 'Mật khẩu xác nhận không khớp');
                isValid = false;
            }

            if (!isValid) e.preventDefault();
        });
    }

    function checkURLParams() {
        const urlParams = new URLSearchParams(window.location.search);
        const updated = urlParams.get('updated');
        
        if (updated === 'success') {
            const successMsg = document.getElementById('success-modal-message');
            if (successMsg) {
                if (window.location.hash === '#change-password') {
                    successMsg.textContent = 'Mật khẩu của bạn đã được thay đổi thành công! Vui lòng đăng nhập lại.';
                    document.getElementById("ok-btn").addEventListener("click", () => {
                       window.location.href = CONTEXTPATH + "/sign-in";
                    });
                } else if (window.location.hash === '#personal-info') {
                    successMsg.textContent = 'Thông tin cá nhân đã được cập nhật!';
                }
            }
            openModal('notification-modal');
        } else if (updated === 'failed' || updated === 'error') {
            openModal('error-modal');
        }

        if (updated) {
            const newUrl = window.location.pathname + window.location.hash;
            window.history.replaceState({}, document.title, newUrl);
        }
    }

    checkURLParams();

    const addAddressBtn = document.getElementById("addAddressBtn");
    if (addAddressBtn) {
        addAddressBtn.addEventListener('click', function () {
            switchTab("addresses");
            openModal('add-address-modal');
        });
    }

    const addressForm = document.getElementById('address-form');
    if (addressForm) {
        addressForm.addEventListener('submit', function (e) {
            const streetAddress = document.getElementById('streetAddress');
            const addressError = document.getElementById('streetAddress-error');

            if (streetAddress.value.trim() === '') {
                e.preventDefault();
                showError(streetAddress, addressError, 'Vui lòng nhập địa chỉ chi tiết');
            }
        });
    }

    function showError(input, errorSpan, message) {
        input.parentElement.classList.add('has-error');
        errorSpan.textContent = message;
        errorSpan.style.display = 'block';
    }

    function clearError(input, errorSpan) {
        input.parentElement.classList.remove('has-error');
        errorSpan.textContent = '';
        errorSpan.style.display = 'none';
    }

    window.onclick = function (event) {
        if (event.target.classList.contains('modal')) {
            closeModal(event.target.id);
        }
    };
});