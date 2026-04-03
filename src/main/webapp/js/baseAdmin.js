function toggleAdminDropdown(event) {
    event.stopPropagation();
    var dropdown = document.getElementById("adminDropdown");
    dropdown.classList.toggle("show");
}

window.onclick = function (event) {
    var dropdown = document.getElementById("adminDropdown");
    if (dropdown && dropdown.classList.contains("show")) {
        var isClickInside = event.target.closest('.user-profile-container');
        if (!isClickInside) {
            dropdown.classList.remove("show");
        }
    }

    var accountModal = document.getElementById('adminAccountModal');
    if (event.target == accountModal) {
        closeAccountModal();
    }
}

function toggleSidebar() {
    document.body.classList.toggle('sidebar-collapsed');
    var icon = document.getElementById('sidebarToggleIcon');
    if (document.body.classList.contains('sidebar-collapsed')) {
        icon.classList.remove('fa-outdent');
        document.getElementById("navTitle").innerHTML = "";
        icon.classList.add('fa-indent');
    } else {
        icon.classList.remove('fa-indent');
        document.getElementById("navTitle").innerHTML = "Clean Meat";
        icon.classList.add('fa-outdent');
    }
}

function openAccountModal(event) {
    if (event) {
        event.preventDefault();
        event.stopPropagation();
    }
    var dropdown = document.getElementById("adminDropdown");
    if (dropdown) dropdown.classList.remove("show");
    document.getElementById('adminAccountModal').classList.add('show');
}

function closeAccountModal() {
    closeModal('adminAccountModal');
}

function closeModal(modalId) {
    document.getElementById(modalId).classList.remove('show');
}

function hideAlertModal() {
    var successModal = document.getElementById('adminSuccessModal');
    var errorModal = document.getElementById('adminErrorModal');
    if (successModal) successModal.classList.remove('show');
    if (errorModal) errorModal.classList.remove('show');

    const url = new URL(window.location);
    url.searchParams.delete('success');
    url.searchParams.delete('error');
    window.history.replaceState({}, '', url);
}

function switchAccountTab(tabId, btn) {
    document.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'));
    document.querySelectorAll('.tab-content').forEach(c => c.classList.remove('active'));
    btn.classList.add('active');
    document.getElementById('tab-' + tabId).classList.add('active');
}

function previewAvatar(event) {
    const reader = new FileReader();
    reader.onload = function() {
        const preview = document.getElementById('preview-avatar');
        const icon = document.getElementById('preview-avatar-icon');
        
        preview.src = reader.result;
        preview.style.display = 'block';
        
        if (icon) {
            icon.style.display = 'none';
        }
    };
    
    if (event.target.files[0]) {
        reader.readAsDataURL(event.target.files[0]);
    }
}