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

    uploadZone.addEventListener('dragover', (e) => {
        e.preventDefault();
        uploadZone.classList.add('dragover');
    });

    uploadZone.addEventListener('dragleave', () => {
        uploadZone.classList.remove('dragover');
    });

    uploadZone.addEventListener('drop', (e) => {
        e.preventDefault();
        uploadZone.classList.remove('dragover');
        const file = e.dataTransfer.files[0];
        if (file && file.type.startsWith('image/')) {
            fileInput.files = e.dataTransfer.files;
            const event = new Event('change');
            fileInput.dispatchEvent(event);
        }
    });
}

function removePreview(event) {
    if (event) event.stopPropagation();
    fileInput.value = '';
    imagePreview.style.display = 'none';
    uploadContent.style.display = 'flex';
}

window.addEventListener('click', (e) => {
    const modal = document.getElementById('addNewsModal');
    if (e.target === modal) {
        closeAddNewsModal();
    }
});
