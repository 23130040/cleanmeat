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

    // Checkout: Toggle new address form
    const addressOptions = document.querySelectorAll('input[name="addressOption"]');
    const newAddressForm = document.getElementById('newAddressForm');

    if (addressOptions.length > 0 && newAddressForm) {
        const manualFields = newAddressForm.querySelectorAll('input, select');

        const toggleManualForm = (value) => {
            if (value === 'new') {
                newAddressForm.style.display = 'block';
                manualFields.forEach(field => {
                    if (field.id !== 'orderNote') field.required = true;
                });
            } else {
                newAddressForm.style.display = 'none';
                manualFields.forEach(field => field.required = false);
            }
        };

        addressOptions.forEach(option => {
            option.addEventListener('change', function () {
                toggleManualForm(this.value);
            });
            // Initial check for pre-selected option
            if (option.checked) toggleManualForm(option.value);
        });
    }

    // Profile Page: Tab Switching Logic
    const profileNavItems = document.querySelectorAll('.profile-nav .nav-item');
    const profilePanels = document.querySelectorAll('.profile-content .content-panel');

    if (profileNavItems.length > 0 && profilePanels.length > 0) {
        profileNavItems.forEach(item => {
            item.addEventListener('click', function() {
                const targetId = this.getAttribute('data-target');
                
                // Update nav active state
                profileNavItems.forEach(nav => nav.classList.remove('active'));
                this.classList.add('active');
                
                // Update panel visibility
                profilePanels.forEach(panel => {
                    panel.classList.remove('active');
                    if (panel.id === targetId) {
                        panel.classList.add('active');
                    }
                });
            });
        });
    }

    // Profile Page: Avatar Preview
    const avatarUpload = document.getElementById('avatarUpload');
    const displayAvatar = document.getElementById('displayAvatar');

    if (avatarUpload && displayAvatar) {
        avatarUpload.addEventListener('change', function() {
            const file = this.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    displayAvatar.src = e.target.result;
                };
                reader.readAsDataURL(file);
            }
        });
    }
});