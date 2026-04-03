function viewOrder(id) {
    const cp = typeof contextPath !== 'undefined' ? contextPath : '';
    fetch(`${window.location.pathname}?action=getDetail&id=${id}`)
        .then(res => res.json())
        .then(order => {
            document.getElementById('modalOrderCode').textContent = `Chi tiết đơn hàng ORD-${String(order.id).padStart(4, '0')}`;
            document.getElementById('modalCustomerName').textContent = order.user_name || 'N/A';
            document.getElementById('modalCustomerEmail').textContent = order.user_email || '';
            document.getElementById('modalShippingAddress').textContent = order.address ? order.address.address : 'N/A';
            document.getElementById('modalPaymentMethod').textContent = order.payment_method || 'N/A';
            document.getElementById('modalTransportMethod').textContent = order.transport_method || 'N/A';
            document.getElementById('modalTotalValue').textContent = formatCurrency(order.total_price);

            // Products
            const productList = document.getElementById('modalProductList');
            productList.innerHTML = '';
            if (order.items && order.items.length > 0) {
                order.items.forEach(item => {
                    const tr = document.createElement('tr');
                    const imageUrl = item.itemImage ? `${cp}/images/${item.itemImage}` : `${cp}/images/default.png`;
                    tr.innerHTML = `
                        <td class="product-name-col">
                            <div class="product-info-cell">
                                <img src="${imageUrl}" class="modal-product-img" onerror="this.src='${cp}/images/default.png'">
                                <div class="product-details">
                                    <span class="product-name-text">${item.itemName || 'Sản phẩm'}</span>
                                    <span class="product-unit-text">${item.weight || 0}g / ${item.unitName || 'Gói'}</span>
                                </div>
                            </div>
                        </td>
                        <td class="product-price-col">${formatCurrency(item.price / (item.quantity || 1))}</td>
                        <td class="product-qty-col">×${Math.round((item.quantity || 1) * 100) / 100}</td>
                        <td class="product-total-col">${formatCurrency(item.price)}</td>
                    `;
                    productList.appendChild(tr);
                });
            } else {
                productList.innerHTML = '<tr><td colspan="4" style="text-align: center; padding: 20px;">Không có sản phẩm</td></tr>';
            }

            // Timeline
            const timeline = document.getElementById('modalTimeline');
            timeline.innerHTML = '';
            
            // Initial Created Status
            const createdItem = document.createElement('div');
            createdItem.className = 'timeline-item';
            createdItem.innerHTML = `
                <div class="timeline-dot"></div>
                <div class="timeline-content">
                    <div class="timeline-title">Đơn hàng được tạo</div>
                    <div class="timeline-time">${order.created_at}</div>
                </div>
            `;
            timeline.appendChild(createdItem);

            // History Items
            if (order.statusHistory && order.statusHistory.length > 0) {
                order.statusHistory.slice().reverse().forEach((history, index) => {
                    const item = document.createElement('div');
                    item.className = `timeline-item ${index === order.statusHistory.length - 1 ? 'active' : ''}`;
                    item.innerHTML = `
                        <div class="timeline-dot"></div>
                        <div class="timeline-content">
                            <div class="timeline-title">
                                <div class="status-transition">
                                    <span class="badge ${getBadgeClass(history.status_from)}">${getStatusLabel(history.status_from)}</span>
                                    <i class="fa-solid fa-arrow-right status-arrow"></i>
                                    <span class="badge ${getBadgeClass(history.status_to)}">${getStatusLabel(history.status_to)}</span>
                                </div>
                            </div>
                            <div class="timeline-time">
                                <strong>${history.changed_by}</strong> • ${history.changed_at}
                            </div>
                            ${history.note ? `<div class="timeline-note">"${history.note}"</div>` : ''}
                        </div>
                    `;
                    timeline.appendChild(item);
                });
            }

            // Action Buttons in Modal
            const modalActions = document.getElementById('modalActions');
            modalActions.innerHTML = '';
            if (order.status === 'pending' || order.status === 'Chờ xác nhận') {
                modalActions.innerHTML = `
                    <button class="btn-modal btn-modal-primary" onclick="updateStatus(${order.id}, 'Đang xử lý', 'Duyệt đơn hàng từ chi tiết')">
                        <i class="fa-solid fa-check"></i> Duyệt đơn
                    </button>
                    <button class="btn-modal btn-modal-danger" onclick="updateStatus(${order.id}, 'Đã hủy', 'Hủy đơn hàng từ chi tiết')">
                        <i class="fa-solid fa-xmark"></i> Huỷ đơn
                    </button>
                `;
            } else if (order.status === 'delivery' || order.status === 'Đang xử lý') {
                modalActions.innerHTML = `
                    <button class="btn-modal btn-modal-primary" onclick="updateStatus(${order.id}, 'Hoàn thành', 'Hoàn thành đơn hàng từ chi tiết')">
                        <i class="fa-regular fa-circle-check"></i> Hoàn thành
                    </button>
                    <button class="btn-modal btn-modal-danger" onclick="updateStatus(${order.id}, 'Đã hủy', 'Hủy đơn hàng từ chi tiết')">
                        <i class="fa-solid fa-xmark"></i> Huỷ đơn
                    </button>
                `;
            }
            modalActions.innerHTML += '<button class="btn-modal btn-modal-outline" onclick="closeModal(\'orderDetailModal\')">Đóng</button>';

            document.getElementById('orderDetailModal').classList.add('show');
        });
}

function updateStatus(id, newStatus, note) {
    if (!confirm(`Xác nhận cập nhật trạng thái đơn hàng sang "${getStatusLabel(newStatus)}"?`)) return;

    const formData = new URLSearchParams();
    formData.append('action', 'updateStatus');
    formData.append('id', id);
    formData.append('status', newStatus);
    formData.append('note', note);

    fetch(window.location.pathname, {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: formData
    })
    .then(res => res.json())
    .then(data => {
        if (data.success) {
            updateUIForStatus(id, newStatus);
            // Optionally update the modal if it's open
            if (document.getElementById('orderDetailModal').classList.contains('show')) {
                viewOrder(id);
            }
        } else {
            alert(data.message || 'Cập nhật thất bại!');
        }
    })
    .catch(err => alert('Đã xảy ra lỗi!'));
}

function closeModal(id) {
    document.getElementById(id).classList.remove('show');
}

function formatCurrency(amount) {
    return new Intl.NumberFormat('vi-VN').format(amount) + 'đ';
}

function getStatusLabel(status) {
    switch (status) {
        case 'pending':
        case 'Chờ xác nhận':
            return 'Chờ duyệt';
        case 'delivery':
        case 'Đang xử lý':
            return 'Đang xử lý';
        case 'finished':
        case 'Hoàn thành':
            return 'Hoàn thành';
        case 'cancelled':
        case 'Đã huỷ':
        case 'Đã hủy':
            return 'Đã huỷ';
        default: return status;
    }
}

function getBadgeClass(status) {
    switch (status) {
        case 'pending':
        case 'Chờ xác nhận':
            return 'badge-pending';
        case 'delivery':
        case 'Đang xử lý':
            return 'badge-delivery';
        case 'finished':
        case 'Hoàn thành':
            return 'badge-finished';
        case 'cancelled':
        case 'Đã huỷ':
        case 'Đã hủy':
            return 'badge-cancelled';
        default: return '';
    }
}

function updateUIForStatus(id, newStatus) {
    // Update Badge
    const statusCell = document.getElementById(`status-cell-${id}`);
    if (statusCell) {
        statusCell.innerHTML = `<span class="badge ${getBadgeClass(newStatus)}">${getStatusLabel(newStatus)}</span>`;
    }

    // Update Action Buttons
    const actionsCell = document.getElementById(`actions-cell-${id}`);
    if (actionsCell) {
        let buttonsHtml = `<button class="btn-action view" title="Xem chi tiết" onclick="viewOrder(${id})"><i class="fa-regular fa-eye"></i></button>`;
        
        if (newStatus === 'delivery' || newStatus === 'pending' || newStatus === 'Chờ xác nhận' || newStatus === 'Đang xử lý') {
            if (newStatus === 'delivery' || newStatus === 'Đang xử lý') {
                buttonsHtml += `
                    <button class="btn-pill btn-finish" onclick="updateStatus(${id}, 'Hoàn thành', 'Hoàn thành đơn hàng')"><i class="fa-regular fa-circle-check"></i> Hoàn thành</button>
                    <button class="btn-pill btn-cancel" onclick="updateStatus(${id}, 'Đã hủy', 'Hủy đơn hàng')"><i class="fa-solid fa-xmark"></i> Huỷ đơn</button>
                `;
            } else {
                buttonsHtml += `
                    <button class="btn-pill btn-approve" onclick="updateStatus(${id}, 'Đang xử lý', 'Duyệt đơn hàng')"><i class="fa-solid fa-check"></i> Duyệt đơn</button>
                    <button class="btn-pill btn-cancel" onclick="updateStatus(${id}, 'Đã hủy', 'Hủy đơn hàng')"><i class="fa-solid fa-xmark"></i> Huỷ đơn</button>
                `;
            }
        }
        actionsCell.innerHTML = `<div class="actions">${buttonsHtml}</div>`;
    }
}

// Close modal when clicking outside
window.onclick = function(event) {
    const modal = document.getElementById('orderDetailModal');
    if (event.target == modal) {
        closeModal('orderDetailModal');
    }
}
