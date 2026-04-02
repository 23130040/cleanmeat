function openAddOriginModal() {
    document.getElementById('addOriginModal').classList.add('show');
}

function closeAddOriginModal() {
    document.getElementById('addOriginModal').classList.remove('show');
}

function openEditOriginModal(id, name, description) {
    document.getElementById('edit-origin-id').value = id;
    document.getElementById('edit-origin-name').value = name;
    document.getElementById('edit-origin-description').value = description;
    document.getElementById('editOriginModal').classList.add('show');
}

function closeEditOriginModal() {
    document.getElementById('editOriginModal').classList.remove('show');
}

document.addEventListener('DOMContentLoaded', function() {
    const searchInput = document.getElementById('originSearch');
    if (searchInput) {
        searchInput.addEventListener('keyup', function() {
            let value = this.value.toLowerCase();
            let rows = document.querySelectorAll('#originTableBody tr');
            
            rows.forEach(row => {
                let text = row.textContent.toLowerCase();
                row.style.display = text.includes(value) ? '' : 'none';
            });
        });
    }
});
