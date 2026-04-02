document.addEventListener('DOMContentLoaded', function () {
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
        option.addEventListener('change', function () {
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
        option.addEventListener('change', function () {
            paymentOptions.forEach(opt => opt.closest('.payment-method-option').classList.remove('active'));
            if (this.checked) {
                this.closest('.payment-method-option').classList.add('active');
            }
        });
    });

    const btnConfirmOrder = document.querySelector('.btn-confirm-order');
    const successModal = document.getElementById('successModal');
    const paymentModal = document.getElementById('paymentModal');

    function showModal(modal) {
        modal.classList.add('active');
        document.body.style.overflow = 'hidden';
    }

    function hideModal(modal) {
        modal.classList.remove('active');
        document.body.style.overflow = '';
    }

    if (btnConfirmOrder) {
        btnConfirmOrder.addEventListener('click', function (e) {
            e.preventDefault();

            const addressInput = document.querySelector('input[name="addressOption"]:checked');
            const transportInput = document.querySelector('input[name="shippingOption"]:checked');
            const paymentInput = document.querySelector('input[name="paymentOption"]:checked');

            if (!addressInput || !transportInput || !paymentInput) {
                alert('Vui lòng chọn đầy đủ thông tin giao hàng và thanh toán.');
                return;
            }

            const formData = new URLSearchParams();
            formData.append('addressId', addressInput.value);
            formData.append('transportId', transportInput.value);
            formData.append('paymentId', paymentInput.value);

            if (addressInput.value === 'new') {
                const manualAddress = document.getElementById('address').value;
                if (!manualAddress) {
                    alert('Vui lòng nhập địa chỉ giao hàng cụ thể.');
                    btnConfirmOrder.disabled = false;
                    btnConfirmOrder.innerText = 'Xác nhận đặt hàng';
                    return;
                }
                formData.append('address', manualAddress);
            }

            btnConfirmOrder.disabled = true;
            btnConfirmOrder.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i> Đang xử lý...';

            fetch(window.location.pathname, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: formData
            })
                .then(res => {
                    if (!res.ok) throw new Error("Lỗi server!");
                    return res.json();
                })
                .then(data => {
                    if (data.success) {
                        handleOrderSuccess(data);
                    } else {
                        alert('Có lỗi xảy ra khi đặt hàng. Vui lòng thử lại.');
                        btnConfirmOrder.disabled = false;
                        btnConfirmOrder.innerText = 'Xác nhận đặt hàng';
                    }
                })
                .catch(err => {
                    console.error('Order error:', err);
                    alert('Lỗi kết nối. Vui lòng thử lại.');
                    btnConfirmOrder.disabled = false;
                    btnConfirmOrder.innerText = 'Xác nhận đặt hàng';
                });
        });
    }

    function handleOrderSuccess(data) {
        const method = data.paymentMethod.toLowerCase();
        const totalText = document.querySelector('.total-value').textContent;

        if (method.includes('cod') || method.includes('nhận hàng')) {
            successModal.querySelector('.cod-warning').style.display = 'flex';
            showModal(successModal);
        } else {
            const isVNPay = method.includes('vnpay');
            const logo = document.getElementById('paymentLogo');
            const typeName = document.getElementById('paymentTypeName');
            const qrImage = document.getElementById('qrImage');
            const amountLabel = document.getElementById('modalTotalAmount');

            amountLabel.textContent = totalText;

            if (isVNPay) {
                logo.src = 'https://sandbox.vnpayment.vn/paymentv2/Images/brands/logo-vnpay.png';
                typeName.innerText = 'Thanh toán qua VNPAY';
            } else {
                logo.src = 'https://upload.wikimedia.org/wikipedia/vi/f/fe/MoMo_Logo.png';
                typeName.innerText = 'Thanh toán qua MOMO';
            }

            qrImage.src = data.qrUrl;

            if (data.payUrl) {
                window.location.href = data.payUrl;
                return;
            }

            showModal(paymentModal);
        }
    }

    document.querySelectorAll('.btn-cancel-payment').forEach(btn => {
        btn.addEventListener('click', () => {
            if (confirm('Bạn có chắc chắn muốn hủy thanh toán? Đơn hàng sẽ được lưu ở trạng thái Chờ xác nhận.')) {
                hideModal(paymentModal);
                const cp = document.getElementById('contextPath').value;
                window.location.href = cp + '/order-history';
            }
        });
    });

    updateTotals();
});
