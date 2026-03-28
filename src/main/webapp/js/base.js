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
});