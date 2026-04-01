document.addEventListener('DOMContentLoaded', function() {
    const searchInput = document.getElementById('categorySearch');
    const tableBody = document.getElementById('categoryTableBody');
    
    if (searchInput) {
        searchInput.addEventListener('input', function() {
            const query = this.value.toLowerCase().trim();
            const rows = tableBody.querySelectorAll('tr');
            
            rows.forEach(row => {
                const name = row.cells[1].textContent.toLowerCase();
                const description = row.cells[2].textContent.toLowerCase();
                
                if (name.includes(query) || description.includes(query)) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            });
        });
    }
});

function openAddCategoryModal() {
    document.getElementById('addCategoryModal').classList.add('show');
}

function openEditCategoryModal(id, name, description) {
    document.getElementById('edit-id').value = id;
    document.getElementById('edit-name').value = name;
    document.getElementById('edit-description').value = description;
    document.getElementById('editCategoryModal').classList.add('show');
}

function confirmDeleteCategory(id, name) {
    document.getElementById('delete-id').value = id;
    document.getElementById('delete-cat-name').textContent = name;
    document.getElementById('deleteCategoryModal').classList.add('show');
}

function closeModal(modalId) {
    document.getElementById(modalId).classList.remove('show');
}
