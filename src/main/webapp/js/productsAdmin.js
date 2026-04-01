let selectedFiles = [];

function openAddProductModal() {
    document.getElementById('addProductModal').classList.add('show');
    resetImageUpload();
}

function resetImageUpload() {
    selectedFiles = [];
    document.getElementById('productImages').value = '';
    document.getElementById('imagePreviewContainer').innerHTML = '';
    document.getElementById('primaryIndex').value = '0';
}

document.getElementById('uploadZone')?.addEventListener('click', () => {
    document.getElementById('productImages').click();
});

document.getElementById('productImages')?.addEventListener('change', function(e) {
    const files = Array.from(e.target.files);
    files.forEach(file => {
        if (!selectedFiles.some(f => f.name === file.name && f.size === file.size)) {
            selectedFiles.push(file);
        }
    });
    updateImagePreviews('imagePreviewContainer', 'primaryIndex', selectedFiles);
    syncFileInput('productImages', selectedFiles);
});

let editSelectedFiles = [];
document.getElementById('edit-uploadZone')?.addEventListener('click', () => {
    document.getElementById('edit-productImages').click();
});

document.getElementById('edit-productImages')?.addEventListener('change', function(e) {
    const files = Array.from(e.target.files);
    files.forEach(file => {
        if (!editSelectedFiles.some(f => f.name === file.name && f.size === file.size)) {
            editSelectedFiles.push(file);
        }
    });
    updateImagePreviews('edit-imagePreviewContainer', 'edit-primaryIndex', editSelectedFiles);
    syncFileInput('edit-productImages', editSelectedFiles);
});

function updateImagePreviews(containerId, indexId, fileArray) {
    const container = document.getElementById(containerId);
    container.innerHTML = '';

    fileArray.forEach((file, index) => {
        const reader = new FileReader();
        reader.onload = function(e) {
            const previewCard = document.createElement('div');
            previewCard.className = 'preview-card';
            if (document.getElementById(indexId).value == index) {
                previewCard.classList.add('is-primary');
            }

            previewCard.innerHTML = `
                <img src="${e.target.result}" alt="Preview">
                <div class="preview-actions">
                    <label class="primary-radio">
                        <input type="radio" name="${containerId}-radio" ${document.getElementById(indexId).value == index ? 'checked' : ''} onchange="setPrimaryImage('${containerId}', '${indexId}', ${index})">
                        <span>Ảnh chính</span>
                    </label>
                    <button type="button" class="btn-remove-img" onclick="removeImage('${containerId}', '${indexId}', ${index})">
                        <i class="fa-solid fa-trash-can"></i>
                    </button>
                </div>
            `;
            container.appendChild(previewCard);
        };
        reader.readAsDataURL(file);
    });
}

function setPrimaryImage(containerId, indexId, index) {
    document.getElementById(indexId).value = index;
    const container = document.getElementById(containerId);
    const cards = container.querySelectorAll('.preview-card');
    cards.forEach((card, i) => {
        if (i === index) card.classList.add('is-primary');
        else card.classList.remove('is-primary');
    });
}

function removeImage(containerId, indexId, index) {
    const isEdit = containerId.startsWith('edit-');
    const fileArray = isEdit ? editSelectedFiles : selectedFiles;
    const inputId = isEdit ? 'edit-productImages' : 'productImages';

    fileArray.splice(index, 1);
    
    let currentPrimary = parseInt(document.getElementById(indexId).value);
    if (currentPrimary === index) {
        document.getElementById(indexId).value = '0';
    } else if (currentPrimary > index) {
        document.getElementById(indexId).value = currentPrimary - 1;
    }
    
    updateImagePreviews(containerId, indexId, fileArray);
    syncFileInput(inputId, fileArray);
}

function syncFileInput(inputId, fileArray) {
    const dataTransfer = new DataTransfer();
    fileArray.forEach(file => dataTransfer.items.add(file));
    document.getElementById(inputId).files = dataTransfer.files;
}

function viewProduct(id) {
    fetch(`${window.location.pathname}?action=getDetail&id=${id}`)
        .then(res => res.json())
        .then(item => {
            document.getElementById('detail-img').src = item.image ? `${window.location.origin}/cleanmeat${item.image}` : '';
            document.getElementById('detail-name').textContent = item.name;
            document.getElementById('detail-short-desc').textContent = item.short_description || '';
            document.getElementById('detail-cat-badge').textContent = item.category_name;
            document.getElementById('detail-origin-badge').textContent = item.origin_name || 'N/A';
            document.getElementById('detail-discount-badge').textContent = `-${Math.round(item.discount)}%`;
            document.getElementById('detail-discount-badge').style.display = item.discount > 0 ? 'inline-block' : 'none';
            
            document.getElementById('detail-price').textContent = new Intl.NumberFormat('vi-VN').format(item.price);
            document.getElementById('detail-unit').textContent = item.unit_name;
            document.getElementById('detail-stock').innerHTML = `${item.current_stock} <span class="stock-min-hint">(Tối thiểu: ${item.min_stock})</span>`;
            
            document.getElementById('detail-created').textContent = item.created_at.split(' ')[0];
            document.getElementById('detail-updated').textContent = item.updated_at.split(' ')[0];
            document.getElementById('detail-long-desc').innerHTML = item.long_description ? item.long_description.replace(/\n/g, '<br>') : '<em>Không có mô tả chi tiết.</em>';
            
            document.getElementById('btn-edit-from-detail').onclick = () => {
                closeModal('productDetailModal');
                editProduct(id);
            };
            
            document.getElementById('productDetailModal').classList.add('show');
        })
        .catch(err => alert('Không thể lấy thông tin sản phẩm!'));
}

function editProduct(id) {
    fetch(`${window.location.pathname}?action=getDetail&id=${id}`)
        .then(res => res.json())
        .then(item => {
            document.getElementById('edit-id').value = item.id;
            document.getElementById('edit-name').value = item.name;
            document.getElementById('edit-short-desc').value = item.short_description || '';
            document.getElementById('edit-long-desc').value = item.long_description || '';
            document.getElementById('edit-category').value = item.category_id;
            document.getElementById('edit-origin').value = item.origin_id;
            document.getElementById('edit-packaging').value = item.packaging || '';
            document.getElementById('edit-unit').value = item.unit_name;
            document.getElementById('edit-price').value = item.price;
            document.getElementById('edit-discount').value = item.discount;
            document.getElementById('edit-current-stock').value = item.current_stock;
            document.getElementById('edit-min-stock').value = item.min_stock;
            
            editSelectedFiles = [];
            document.getElementById('edit-productImages').value = '';
            document.getElementById('edit-imagePreviewContainer').innerHTML = '';
            document.getElementById('edit-primaryIndex').value = '0';
            
            document.getElementById('editProductModal').classList.add('show');
        })
        .catch(err => alert('Không thể lấy thông tin sản phẩm!'));
}

function confirmDelete(id, name) {
    if (confirm(`Bạn có chắc chắn muốn xóa sản phẩm "${name}"?`)) {
        window.location.href = `${window.location.pathname}?action=delete&id=${id}`;
    }
}

window.addEventListener('click', function(event) {
    const addProductModal = document.getElementById('addProductModal');
    if (event.target == addProductModal) {
        closeModal('addProductModal');
    }
});
