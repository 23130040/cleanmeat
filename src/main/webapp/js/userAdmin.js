document.addEventListener('DOMContentLoaded', function() {
    window.openModal = function(modalId) {
        document.getElementById(modalId).classList.add('show');
    };

    window.closeModal = function(modalId) {
        document.getElementById(modalId).classList.remove('show');
    };

    document.querySelectorAll('.btn-action.view').forEach(btn => {
        btn.addEventListener('click', function() {
            const id = this.getAttribute('data-id');
            fetch(`user-action?id=${id}`)
                .then(response => response.json())
                .then(user => {
                    document.getElementById('viewUserName').innerText = user.name;
                    const roleBadge = document.getElementById('viewUserRoleBadge');
                    roleBadge.innerText = user.role === 'admin' ? 'Admin' : 'Khách hàng';
                    roleBadge.className = `badge badge-${user.role}`;

                    const avatarImg = document.getElementById('viewUserAvatar');
                    const avatarIcon = document.getElementById('viewUserAvatarIcon');
                    if (user.avatar) {
                        avatarImg.src = user.avatar;
                        avatarImg.style.display = 'block';
                        avatarIcon.style.display = 'none';
                    } else {
                        avatarImg.style.display = 'none';
                        avatarIcon.style.display = 'block';
                    }
                    const infoHtml = `
                        <div class="info-row">
                            <span class="info-label">Email</span>
                            <span class="info-value">${user.email}</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Số điện thoại</span>
                            <span class="info-value">${user.phone || 'Chưa cập nhật'}</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Giới tính</span>
                            <span class="info-value">${user.gender === 'Male' ? 'Nam' : (user.gender === 'Female' ? 'Nữ' : 'Khác')}</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Ngày sinh</span>
                            <span class="info-value">${user.birthday ? user.birthday : 'Chưa cập nhật'}</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Trạng thái</span>
                            <span class="info-value">${user.status ? 'Đang hoạt động' : 'Đã vô hiệu hóa'}</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Ngày đăng ký</span>
                            <span class="info-value">${user.created_at ? (typeof user.created_at === 'string' ? user.created_at.split('T')[0] : (user.created_at.date ? `${user.created_at.date.year}-${user.created_at.date.month}-${user.created_at.date.day}` : 'Chưa rõ')) : 'Chưa rõ'}</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Xác thực email</span>
                            <span class="info-value">${user.status ? 'Đã xác thực' : 'Chưa xác thực'}</span>
                        </div>
                    `;
                    document.getElementById('viewUserInfoList').innerHTML = infoHtml;
                    
                    const editBtn = document.getElementById('viewModalEditBtn');
                    editBtn.onclick = function() {
                        closeModal('viewUserModal');
                        document.querySelector(`.btn-action.edit[data-id="${id}"] i`).parentNode.click();
                    };

                    openModal('viewUserModal');
                });
        });
    });

    document.querySelectorAll('.btn-action.edit').forEach(btn => {
        btn.addEventListener('click', function() {
            const id = this.getAttribute('data-id');
            fetch(`user-action?id=${id}`)
                .then(response => response.json())
                .then(user => {
                    document.getElementById('editUserId').value = user.id;
                    document.getElementById('editUserName').innerText = user.name;
                    document.getElementById('editUserEmail').innerText = user.email;
                    
                    const avatarImg = document.getElementById('editUserAvatar');
                    const avatarIcon = document.getElementById('editUserAvatarIcon');
                    if (user.avatar) {
                        avatarImg.src = user.avatar;
                        avatarImg.style.display = 'block';
                        avatarIcon.style.display = 'none';
                    } else {
                        avatarImg.style.display = 'none';
                        avatarIcon.style.display = 'block';
                    }
                    
                    document.getElementById('editUserRole').value = user.role;
                    document.getElementById('editUserStatus').value = user.status.toString();
                    openModal('editUserModal');
                });
        });
    });

    document.getElementById('editUserForm').addEventListener('submit', function(e) {
        e.preventDefault();
        const formData = new FormData(this);
        const id = formData.get('id');
        const role = formData.get('role');
        const status = formData.get('status');

        fetch(`user-action?action=update&id=${id}&role=${role}&status=${status}`, {
            method: 'POST'
        })
        .then(response => response.json())
        .then(data => {
            closeModal('editUserModal');
            if (data.success) {
                showAlert('success', data.message);
                setTimeout(() => location.reload(), 1500);
            } else {
                showAlert('error', data.message);
            }
        });
    });

    let deleteUserId = null;
    document.querySelectorAll('.btn-action.delete').forEach(btn => {
        btn.addEventListener('click', function() {
            deleteUserId = this.getAttribute('data-id');
            openModal('deleteUserModal');
        });
    });

    document.getElementById('confirmDeleteBtn').addEventListener('click', function() {
        if (deleteUserId) {
            fetch(`user-action?action=delete&id=${deleteUserId}`, {
                method: 'POST'
            })
            .then(response => response.json())
            .then(data => {
                closeModal('deleteUserModal');
                if (data.success) {
                    showAlert('success', data.message);
                    setTimeout(() => location.reload(), 1500);
                } else {
                    showAlert('error', data.message);
                }
            });
        }
    });

    function showAlert(type, message) {
        const successModal = document.getElementById('adminSuccessModal');
        const errorModal = document.getElementById('adminErrorModal');
        
        if (type === 'success' && successModal) {
            const msgEl = document.getElementById('successMessage');
            if (msgEl) msgEl.innerText = message;
            
            successModal.classList.add('show');
            successModal.style.display = 'flex';
        } else if (type === 'error' && errorModal) {
            const msgEl = document.getElementById('errorMessage');
            if (msgEl) msgEl.innerText = message;
            
            errorModal.classList.add('show');
            errorModal.style.display = 'flex';
        } else {
            alert(message);
        }
    }
});
