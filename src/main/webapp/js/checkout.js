document.addEventListener('DOMContentLoaded', function() {
    const newAddressForm = document.getElementById('newAddressForm');
    const addressOptions = document.querySelectorAll('input[name="addressOption"]');
    const shippingOptions = document.querySelectorAll('input[name="shippingOption"]');
    const shippingValue = document.querySelector('.shipping-value');
    const totalValue = document.querySelector('.total-value');
    const subtotalValue = document.querySelector('.subtotal-value');

    const getNumber = (text) => parseInt(text.replace(/[^\d]/g, '')) || 0;
    const formatVND = (number) => number.toLocaleString('vi-VN') + 'đ';

    function updateTotals() {
        const subtotal = getNumber(subtotalValue.textContent);
        let currentShipping = 0;

        const selected = document.querySelector('input[name="shippingOption"]:checked');
        if (selected) {
            const baseFee = parseInt(selected.dataset.fee) || 0;
            const threshold = parseInt(selected.dataset.freeThreshold) || 999999999;
            
            if (subtotal >= threshold) {
                currentShipping = 0;
            } else {
                currentShipping = baseFee;
            }
        }

        document.querySelectorAll('.shipping-method-option').forEach(option => {
            const input = option.querySelector('input');
            const label = option.querySelector('.shipping-price');
            const baseFee = parseInt(input.dataset.fee);
            const threshold = parseInt(input.dataset.freeThreshold);
            
            if (subtotal >= threshold) {
                label.textContent = 'Miễn phí';
                label.classList.add('shipping-free');
            } else {
                label.textContent = baseFee === 0 ? 'Miễn phí' : formatVND(baseFee);
                if (baseFee === 0) label.classList.add('shipping-free');
                else label.classList.remove('shipping-free');
            }
        });

        shippingValue.textContent = currentShipping === 0 ? 'Miễn phí' : formatVND(currentShipping);
        if (currentShipping === 0) shippingValue.classList.add('shipping-free');
        else shippingValue.classList.remove('shipping-free');

        const total = subtotal + currentShipping;
        totalValue.textContent = formatVND(total);
    }

    addressOptions.forEach(option => {
        option.addEventListener('change', function() {
            if (this.value === 'new') {
                newAddressForm.style.display = 'block';
                newAddressForm.querySelectorAll('input, select').forEach(el => el.required = true);
            } else {
                newAddressForm.style.display = 'none';
                newAddressForm.querySelectorAll('input, select').forEach(el => el.required = false);
            }
        });
    });

    shippingOptions.forEach(option => {
        option.addEventListener('change', updateTotals);
    });

    const initialAddress = document.querySelector('input[name="addressOption"]:checked');
    if (initialAddress && initialAddress.value === 'new') {
        newAddressForm.style.display = 'block';
    }

    const paymentOptions = document.querySelectorAll('input[name="paymentOption"]');
    paymentOptions.forEach(option => {
        option.addEventListener('change', function() {
            paymentOptions.forEach(opt => opt.closest('.payment-method-option').classList.remove('active'));
            if (this.checked) {
                this.closest('.payment-method-option').classList.add('active');
            }
        });
    });

    updateTotals();
});
