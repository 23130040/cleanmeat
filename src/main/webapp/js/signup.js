document.addEventListener("DOMContentLoaded", () => {
    document.getElementById("signup-form").addEventListener("submit", (e) => {

        const error = document.getElementById("error");
        error.innerText = "";

        let username = document.getElementById("name").value.trim();
        let email = document.getElementById("email").value.trim();
        let phone = document.getElementById("phone").value.trim();
        let password = document.getElementById("password").value;
        let confirmPassword = document.getElementById("confirmPassword").value;

        if (username === "") {
            error.innerText = "Họ và tên không được để trống!";
            e.preventDefault();
            return;
        }

        if (email === "") {
            error.innerText = "Email không được để trống!";
            e.preventDefault();
            return;
        }

        if (phone === "") {
            error.innerText = "Số điện thoại không được để trống!";
            e.preventDefault();
            return;
        }

        if (password === "") {
            error.innerText = "Mật khẩu không được để trống!";
            e.preventDefault();
            return;
        }

        if (confirmPassword === "") {
            error.innerText = "Mật khẩu xác nhận không được để trống!";
            e.preventDefault();
            return;
        }

        let emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailRegex.test(email)) {
            error.innerText = "Email không hợp lệ!";
            e.preventDefault();
            return;
        }

        let phoneRegex = /^0\d{9}$/;
        if (!phoneRegex.test(phone)) {
            error.innerText = "Số điện thoại không hợp lệ!";
            e.preventDefault();
            return;
        }

        if (password.length < 8) {
            error.innerText = "Mật khẩu phải có ít nhất 8 ký tự!";
            e.preventDefault();
            return;
        }

        let passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$/;
        if (!passwordRegex.test(password)) {
            error.innerText = "Mật khẩu phải có chữ hoa, chữ thường, số và ký tự đặc biệt!";
            e.preventDefault();
            return;
        }

        if (confirmPassword !== password) {
            error.innerText = "Mật khẩu xác nhận không khớp!";
            e.preventDefault();
            return;
        }
    });
});