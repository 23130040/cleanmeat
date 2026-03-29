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

});

function openModal(id) {
    const modal = document.getElementById(id);
    if (modal) {
        modal.classList.add('show');
        document.body.style.overflow = 'hidden';
    }
}

