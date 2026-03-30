document.addEventListener('DOMContentLoaded', function () {

    document.querySelectorAll('.btn-remove-cart').forEach(btn => {
        btn.addEventListener('click', function () {
            const itemId = this.getAttribute('data-item-id');
            const card = this.closest('.cart-item-card-premium');

            const formData = new FormData();
            formData.append('action', 'remove');
            formData.append('itemId', itemId);

            fetch(CONTEXTPATH + '/cart', {
                method: 'POST',
                body: formData
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

            const formData = new FormData();
            formData.append('action', 'update');
            formData.append('itemId', itemId);
            formData.append('quantity', newQty);

            fetch(CONTEXTPATH + '/cart', {
                method: 'POST',
                body: formData
            })
            .then(res => res.json())
            .then(data => {
                if (data.success) {
                    qtySpan.textContent = newQty;
                    updateCartBadge(data.cartCount);
                    recalcItemTotal(itemId, newQty);
                    recalcTotal();
                }
            });
        });
    });

    function recalcItemTotal(itemId, qty) {
        const card = document.querySelector(`.btn-remove-cart[data-item-id="${itemId}"]`)
                               ?.closest('.cart-item-card-premium');
        if (!card) return;
        const priceEl  = card.querySelector('.price-detail:not(.total) .val');
        const totalEl  = card.querySelector('.price-detail.total .val');
        if (!priceEl || !totalEl) return;
        const unitPrice = parseFloat(priceEl.textContent.replace(/[^\d.]/g, ''));
        totalEl.textContent = (unitPrice * qty).toLocaleString('vi-VN') + 'đ';
    }

    function recalcTotal() {
        let total = 0;
        document.querySelectorAll('.price-detail.total .val').forEach(el => {
            total += parseFloat(el.textContent.replace(/[^\d.]/g, '')) || 0;
        });
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
