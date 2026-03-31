window.CONTEXTPATH = document.getElementById('contextPath')?.value || '';

function updateCartBadge(count) {
    const badge = document.getElementById('cart-quantity');
    if (badge) {
        badge.textContent = count;
        badge.classList.add('pulse');
        setTimeout(() => badge.classList.remove('pulse'), 500);
    }
}

function showNotification(message, type = 'success') {
    const toast = document.createElement('div');
    toast.className = `toast-notice ${type}`;
    toast.innerHTML = `
        <div class="toast-content">
            <i class="fa-solid ${type === 'success' ? 'fa-check-circle' : 'fa-exclamation-circle'}"></i>
            <span>${message}</span>
        </div>
    `;
    document.body.appendChild(toast);
    setTimeout(() => toast.classList.add('show'), 100);
    setTimeout(() => {
        toast.classList.remove('show');
        setTimeout(() => toast.remove(), 300);
    }, 3000);
}

document.addEventListener('DOMContentLoaded', function () {
    const profileDropdown = document.getElementById('userProfileDropdown');
    if (profileDropdown) {
        const dropdownMenu = profileDropdown.querySelector('.dropdown-menu');

        profileDropdown.addEventListener('click', function (e) {
            e.stopPropagation();
            this.classList.toggle('active');
            dropdownMenu.classList.toggle('show');
        });

        document.addEventListener('click', function (e) {
            if (!profileDropdown.contains(e.target)) {
                profileDropdown.classList.remove('active');
                dropdownMenu.classList.remove('show');
            }
        });
    }

    document.addEventListener('click', function (e) {
        const dismissBtn = e.target.closest('[data-dismiss="modal"]');
        if (dismissBtn) {
            const modal = dismissBtn.closest('.modal');
            if (modal) {
                closeModal(modal.id);
            }
        }
    });

});

function openModal(id) {
    const modal = document.getElementById(id);
    if (modal) {
        modal.classList.add('show');
        document.body.style.overflow = 'hidden';
    }
}

function closeModal(id) {
    const modal = document.getElementById(id);
    if (modal) {
        modal.classList.remove('show');
        document.body.style.overflow = 'auto';
    }
}
