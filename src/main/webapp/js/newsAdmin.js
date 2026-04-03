// Add News Modal
function openAddNewsModal() {
    document.getElementById('addNewsModal').classList.add('show');
}

function closeAddNewsModal() {
    document.getElementById('addNewsModal').classList.remove('show');
    const form = document.querySelector('#addNewsModal form');
    if (form) {
        form.reset();
        removePreview();
    }
}

// Edit News Modal
function openEditNewsModal() {
    document.getElementById('editNewsModal').classList.add('show');
}

function closeEditNewsModal() {
    document.getElementById('editNewsModal').classList.remove('show');
    const form = document.querySelector('#editNewsModal form');
    if (form) {
        form.reset();
    }
}

// View News Modal
function openViewNewsModal() {
    document.getElementById('viewNewsModal').classList.add('show');
}

function closeViewNewsModal() {
    document.getElementById('viewNewsModal').classList.remove('show');
}

// Delete Confirmation Modal
function closeDeleteModal() {
    document.getElementById('deleteNewsModal').classList.remove('show');
}

function confirmDelete(id) {
    document.getElementById('deleteNewsId').value = id;
    document.getElementById('deleteNewsModal').classList.add('show');
}

// Fetch Logic for View/Edit
function viewNews(id) {
    fetch(`${window.contextPath}/news-admin?action=getDetail&id=${id}`)
        .then(response => response.json())
        .then(news => {
            document.getElementById('viewNewsTitle').innerText = news.title;
            const img = document.getElementById('viewNewsImg');
            img.src = news.picture_url.startsWith('http') ? news.picture_url : window.contextPath + news.picture_url;
            
            document.getElementById('viewNewsAuthor').innerHTML = `<i class="fa-regular fa-user"></i> ${news.author}`;
            document.getElementById('viewNewsDate').innerHTML = `<i class="fa-regular fa-calendar-days"></i> ${news.created_at.split(' ')[0]}`;
            
            const statusBadge = document.getElementById('viewNewsStatus');
            statusBadge.innerText = news.status;
            statusBadge.className = 'status-badge ' + (news.status === 'Đã đăng' ? 'published' : 'draft');
            
            document.getElementById('viewNewsFullContent').innerText = news.content;
            openViewNewsModal();
        })
        .catch(error => console.error('Error:', error));
}

function editNews(id) {
    fetch(`${window.contextPath}/news-admin?action=getDetail&id=${id}`)
        .then(response => response.json())
        .then(news => {
            document.getElementById('editNewsId').value = news.id;
            document.getElementById('editTitle').value = news.title;
            document.getElementById('editAuthor').value = news.author;
            document.getElementById('editStatus').value = news.status;
            document.getElementById('editContent').value = news.content;
            
            const previewImg = document.getElementById('editPreviewImg');
            previewImg.src = news.picture_url.startsWith('http') ? news.picture_url : window.contextPath + news.picture_url;
            document.getElementById('editImagePreview').style.display = 'block';
            document.getElementById('editUploadContent').style.display = 'none';
            
            openEditNewsModal();
        })
        .catch(error => console.error('Error:', error));
}

// Image Preview for Add News
const uploadZone = document.getElementById('newsUploadZone');
const fileInput = document.getElementById('newsPicture');
const imagePreview = document.getElementById('imagePreview');
const uploadContent = document.getElementById('uploadContent');

if (uploadZone) {
    uploadZone.addEventListener('click', () => fileInput.click());

    fileInput.addEventListener('change', function(e) {
        const file = e.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function(e) {
                const img = imagePreview.querySelector('img');
                img.src = e.target.result;
                imagePreview.style.display = 'block';
                uploadContent.style.display = 'none';
            }
            reader.readAsDataURL(file);
        }
    });
}

function removePreview(event) {
    if (event) event.stopPropagation();
    fileInput.value = '';
    imagePreview.style.display = 'none';
    uploadContent.style.display = 'flex';
}

// Image Preview for Edit News
const editUploadZone = document.getElementById('editNewsUploadZone');
const editFileInput = document.getElementById('editNewsPicture');
const editImagePreview = document.getElementById('editImagePreview');
const editUploadContent = document.getElementById('editUploadContent');

if (editUploadZone) {
    editUploadZone.addEventListener('click', () => editFileInput.click());

    editFileInput.addEventListener('change', function(e) {
        const file = e.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function(e) {
                const img = editImagePreview.querySelector('img');
                img.src = e.target.result;
                editImagePreview.style.display = 'block';
                editUploadContent.style.display = 'none';
            }
            reader.readAsDataURL(file);
        }
    });
}

function removeEditPreview(event) {
    if (event) event.stopPropagation();
    editFileInput.value = '';
    editImagePreview.style.display = 'none';
    editUploadContent.style.display = 'flex';
}

// Global Modal Click Handlers
window.addEventListener('click', (e) => {
    const addModal = document.getElementById('addNewsModal');
    const editModal = document.getElementById('editNewsModal');
    const viewModal = document.getElementById('viewNewsModal');
    const deleteModal = document.getElementById('deleteNewsModal');
    
    if (e.target === addModal) closeAddNewsModal();
    if (e.target === editModal) closeEditNewsModal();
    if (e.target === viewModal) closeViewNewsModal();
    if (e.target === deleteModal) closeDeleteModal();
});
