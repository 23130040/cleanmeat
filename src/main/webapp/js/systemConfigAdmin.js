document.addEventListener('DOMContentLoaded', function() {
    const logoUrlInput = document.getElementById('logoUrlInput');
    const logoPreview = document.getElementById('logoPreview');
    const configForm = document.getElementById('configForm');

    if (logoUrlInput && logoPreview) {
        logoUrlInput.addEventListener('input', function() {
            const url = this.value.trim();
            if (url) {
                logoPreview.src = url;
            } else {
                logoPreview.src = '/images/logo-placeholder.png';
            }
        });
        logoPreview.addEventListener('error', function() {
            this.src = '/images/logo-placeholder.png';
        });
    }
    if (configForm) {
        configForm.addEventListener('submit', function(e) {
            e.preventDefault();
            if (confirm('Bạn có chắc chắn muốn lưu các thay đổi này không?')) {
                this.submit();
            }
        });
    }
});
