document.addEventListener('DOMContentLoaded', function() {
    const searchInput = document.getElementById('contactSearch');
    if (searchInput) {
        searchInput.addEventListener('keyup', function() {
            const val = this.value.toLowerCase();
            const rows = document.querySelectorAll('#contactTableBody tr');
            
            rows.forEach(row => {
                const text = row.innerText.toLowerCase();
                row.style.display = text.includes(val) ? '' : 'none';
            });
        });
    }
});
