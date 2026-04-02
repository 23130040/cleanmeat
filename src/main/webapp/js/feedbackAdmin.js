document.addEventListener('DOMContentLoaded', function() {
    const searchInput = document.getElementById('feedbackSearch');
    if (searchInput) {
        searchInput.addEventListener('keyup', function() {
            let value = this.value.toLowerCase().trim();
            let rows = document.querySelectorAll('#feedbackTableBody tr');
            
            rows.forEach(row => {
                let text = row.textContent.toLowerCase();
                row.style.display = text.includes(value) ? '' : 'none';
            });
            
            // Check if any rows are visible
            const noResultRow = document.getElementById('noResultsRow');
            let hasVisibleRow = Array.from(rows).some(row => row.style.display !== 'none');
            
            if (!hasVisibleRow && value !== '') {
                if (!noResultRow) {
                    const tableBody = document.getElementById('feedbackTableBody');
                    const newNoResultRow = document.createElement('tr');
                    newNoResultRow.id = 'noResultsRow';
                    newNoResultRow.innerHTML = `<td colspan="6" style="text-align: center; padding: 40px; color: #94a3b8;">Không tìm thấy phản hồi nào khớp với từ khóa "${value}".</td>`;
                    tableBody.appendChild(newNoResultRow);
                } else {
                    noResultRow.style.display = '';
                    noResultRow.querySelector('td').textContent = `Không tìm thấy phản hồi nào khớp với từ khóa "${value}".`;
                }
            } else if (noResultRow) {
                noResultRow.style.display = 'none';
            }
        });
    }
});
