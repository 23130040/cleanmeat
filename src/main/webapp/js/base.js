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
