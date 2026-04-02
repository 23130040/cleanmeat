document.addEventListener('DOMContentLoaded', function () {

    document.querySelectorAll('.btn-remove-cart').forEach(btn => {
        btn.addEventListener('click', function () {
            const itemId = this.getAttribute('data-item-id');
            const card = this.closest('.cart-item-card-premium');
            const select = card.querySelector('.cart-weight-select');
            const weight = select.value;

            const params = new URLSearchParams();
            params.append('action', 'remove');
            params.append('itemId', itemId);
            params.append('weight', weight);

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
            const card = this.closest('.cart-item-card-premium');
            const weight = card.querySelector('.cart-weight-select').value;
            
            const qtySpan = card.querySelector('.picker-val');
            if (!qtySpan) return;

            let currentQty = parseInt(qtySpan.textContent);
            const newQty = currentQty + delta;
            if (newQty < 1) return;

            const params = new URLSearchParams();
            params.append('action', 'update');
            params.append('itemId', itemId);
            params.append('weight', weight);
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
                if (data.success) {
                    qtySpan.textContent = newQty;
                    updateCartBadge(data.cartCount);
                    recalcTotal(data.total);
                    // Local subtotal update is skipped for brevity, full sync via server
                }
            })
            .catch(err => console.error('Cart update error:', err));
        });
    });

    document.querySelectorAll('.cart-weight-select').forEach(select => {
        select.addEventListener('change', function () {
            const itemId = this.getAttribute('data-item-id');
            const oldWeight = this.getAttribute('data-old-weight');
            const newWeight = this.value;

            const params = new URLSearchParams();
            params.append('action', 'updateWeight');
            params.append('itemId', itemId);
            params.append('oldWeight', oldWeight);
            params.append('newWeight', newWeight);

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
                    location.reload();
                }
            });
        });
    });

    const btnClearAll = document.getElementById('btn-clear-all');
    if (btnClearAll) {
        btnClearAll.addEventListener('click', function () {
            const hasItems = document.querySelectorAll('.cart-item-card-premium').length > 0;
            if (!hasItems) return;

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
                    location.reload();
                }
            });
        });
    }

    function recalcTotal(serverTotal) {
        const total = serverTotal.toLocaleString('vi-VN') + 'đ';
        const grandEl = document.querySelector('.final-price');
        if (grandEl) grandEl.textContent = total;
        const subtotalEl = document.querySelector('.summary-bill-details .bill-row:first-child .val');
        if (subtotalEl) subtotalEl.textContent = total;
    }

    function updateCartBadge(count) {
        const badge = document.getElementById('cart-quantity');
        if (badge) badge.textContent = count;
    }

    function checkEmptyCart() {
        const cards = document.querySelectorAll('.cart-item-card-premium');
        if (cards.length === 0) {
            location.reload();
        }
    }
});
