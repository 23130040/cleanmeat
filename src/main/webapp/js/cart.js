document.addEventListener('DOMContentLoaded', function () {

    document.querySelectorAll('.btn-remove-cart').forEach(btn => {
        btn.addEventListener('click', function () {
            const itemId = this.getAttribute('data-item-id');
            const card = this.closest('.cart-item-card-premium');

            const params = new URLSearchParams();
            params.append('action', 'remove');
            params.append('itemId', itemId);

            fetch(CONTEXTPATH + '/cart', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: params
            })
            .then(res => res.json())
            .then(data => {
                if (data.success) {
                    card.style.transition = 'opacity 0.3s, transform 0.3s';
                    card.style.opacity = '0';
                    card.style.transform = 'translateX(40px)';
                    setTimeout(() => {
                        card.remove();
                        updateCartBadge(data.cartCount);
                        checkEmptyCart();
                        recalcTotal();
                    }, 300);
                }
            });
        });
    });

    document.querySelectorAll('.btn-qty').forEach(btn => {
        btn.addEventListener('click', function () {
            const itemId = this.getAttribute('data-item-id');
            const delta = parseInt(this.getAttribute('data-delta'));
            const qtySpan = document.getElementById('qty-' + itemId);
            if (!qtySpan) return;

            let currentQty = parseInt(qtySpan.textContent);
            const newQty = currentQty + delta;
            if (newQty < 1) return;

            const params = new URLSearchParams();
            params.append('action', 'update');
            params.append('itemId', itemId);
            params.append('quantity', newQty);

            fetch(CONTEXTPATH + '/cart', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: params
            })
            .then(res => res.json())
            .then(data => {
                console.log('Update result:', data);
                if (data.success) {
                    qtySpan.textContent = newQty;
                    updateCartBadge(data.cartCount);
                    recalcItemTotal(itemId, newQty);
                    recalcTotal(data.total);
                }
            })
            .catch(err => console.error('Cart update error:', err));
        });
    });

    const btnClearAll = document.getElementById('btn-clear-all');
    if (btnClearAll) {
        btnClearAll.addEventListener('click', function () {
            const hasItems = document.querySelectorAll('.cart-item-card-premium').length > 0;
            if (!hasItems) return;

            if (!confirm('Bạn có chắc chắn muốn xóa toàn bộ sản phẩm khỏi giỏ hàng?')) return;

            const params = new URLSearchParams();
            params.append('action', 'clear');

            fetch(CONTEXTPATH + '/cart', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: params
            })
            .then(res => res.json())
            .then(data => {
                if (data.success) {
                    const container = document.querySelector('.cart-items-container');
                    const layout = document.querySelector('.cart-layout');
                    if (layout) {
                        layout.style.transition = 'opacity 0.3s, transform 0.3s';
                        layout.style.opacity = '0';
                        layout.style.transform = 'translateY(20px)';
                    }
                    setTimeout(() => {
                        location.reload();
                    }, 300);
                }
            });
        });
    }

    function recalcItemTotal(itemId, qty) {
        const card = document.querySelector(`.btn-remove-cart[data-item-id="${itemId}"]`)
                               ?.closest('.cart-item-card-premium');
        if (!card) return;
        const priceEl  = card.querySelector('.current-unit-price');
        const totalEl  = card.querySelector('.price-detail.total .val');
        if (!priceEl || !totalEl) return;
        const unitPrice = parseInt(priceEl.textContent.replace(/[^\d]/g, ''));
        totalEl.textContent = (unitPrice * qty).toLocaleString('vi-VN') + 'đ';
    }

    function recalcTotal(serverTotal) {
        let total = serverTotal !== undefined ? serverTotal : 0;
        if (serverTotal === undefined) {
            document.querySelectorAll('.price-detail.total .val').forEach(el => {
                total += parseInt(el.textContent.replace(/[^\d]/g, '')) || 0;
            });
        }
        const grandEl = document.querySelector('.final-price');
        if (grandEl) grandEl.textContent = total.toLocaleString('vi-VN') + 'đ';
        const subtotalEl = document.querySelector('.summary-bill-details .bill-row:first-child .val');
        if (subtotalEl) subtotalEl.textContent = total.toLocaleString('vi-VN') + 'đ';
    }

    function checkEmptyCart() {
        const cards = document.querySelectorAll('.cart-item-card-premium');
        if (cards.length === 0) {
            location.reload();
        }
    }
});
