document.addEventListener('DOMContentLoaded', function () {
    const profileForm = document.getElementById('profile-form');

    if (profileForm) {
        profileForm.addEventListener('submit', function (e) {
            let isValid = true;

            const nameInput = document.getElementById('name');
            const nameError = document.getElementById('name-error');
            nameError.innerText = "";
            if (nameInput.value.trim() === '') {
                showError(nameInput, nameError, 'Họ và tên không được để trống');
                isValid = false;
            } else {
                hideError(nameInput, nameError);
            }

            const phoneInput = document.getElementById('phone');
            const phoneError = document.getElementById('phone-error');
            phoneError.innerText = "";
            const phoneRegex = /^(0|84)(3|5|7|8|9)\d{8}$/;
            const phoneVal = phoneInput.value.trim().replace(/\s/g, '');
            if (phoneVal === '') {
                showError(phoneInput, phoneError, 'Số điện thoại không được để trống');
                isValid = false;
            } else if (!phoneRegex.test(phoneVal)) {
                showError(phoneInput, phoneError, 'Số điện thoại không hợp lệ');
                isValid = false;
            } else {
                hideError(phoneInput, phoneError);
            }
            if (!validateBirthday()) {
                isValid = false;
            }

            if (!isValid) {
                e.preventDefault();
            }
        });

        const birthdayInput = document.getElementById('birthday');
        const birthdayError = document.getElementById('birthday-error');
        birthdayError.innerText = "";
        function validateBirthday() {
            const value = birthdayInput.value.trim();
            const birthdayRegex = /^(\d{1,2})\/(\d{1,2})\/(\d{4})$/;

            if (value === '') {
                showError(birthdayInput, birthdayError, 'Vui lòng nhập ngày sinh');
                return false;
            }

            const match = value.match(birthdayRegex);
            if (!match) {
                showError(birthdayInput, birthdayError, 'Vui lòng nhập đúng định dạng dd/mm/yyyy');
                return false;
            }

            const day = parseInt(match[1], 10);
            const month = parseInt(match[2], 10) - 1;
            const year = parseInt(match[3], 10);
            const selectedDate = new Date(year, month, day);
            const today = new Date();

            if (month < 0 || month > 11 || day < 1 || day > 31 || selectedDate.getMonth() !== month || selectedDate.getDate() !== day) {
                showError(birthdayInput, birthdayError, 'Ngày sinh không hợp lệ');
                return false;
            }

            if (selectedDate > today) {
                showError(birthdayInput, birthdayError, 'Ngày sinh không thể ở tương lai');
                return false;
            }

            hideError(birthdayInput, birthdayError);
            return true;
        }

        birthdayInput.addEventListener('blur', validateBirthday);
        birthdayInput.addEventListener('input', function () {
            if (birthdayInput.value.trim() !== '') {
                const birthdayRegex = /^(\d{1,2})\/(\d{1,2})\/(\d{4})$/;
                if (birthdayInput.value.trim().match(birthdayRegex)) {
                    hideError(birthdayInput, birthdayError);
                }
            }
        });
    }

    function showError(input, errorSpan, message) {
        input.parentElement.classList.add('has-error');
        errorSpan.textContent = message;
        errorSpan.style.display = 'block';
    }

    function hideError(input, errorSpan) {
        input.parentElement.classList.remove('has-error');
        errorSpan.style.display = 'none';
        errorSpan.textContent = '';
    }
});
