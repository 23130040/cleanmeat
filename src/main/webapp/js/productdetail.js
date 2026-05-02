document.addEventListener("DOMContentLoaded", function () {

    const qtyInput = document.getElementById("qty");
    const plus = document.getElementById("plus");
    const minus = document.getElementById("minus");
    const priceBox = document.getElementById("price");
    const weightBtns = document.querySelectorAll(".weight-btn");

    const formWeight = document.getElementById("form-weight");
    const formQuantity = document.getElementById("form-quantity");

    let basePrice = Number(priceBox.dataset.base.replace(/,/g, "")) || 0;
    let currentWeight = 250;
    let quantity = 1;
    let stock = parseInt(qtyInput.dataset.stock) || 999;

    function formatPrice(num) {
        return num.toLocaleString("vi-VN") + " đ";
    }

    function updateUI() {
        let total = basePrice * (currentWeight / 250) * quantity;
        priceBox.innerText = formatPrice(total);
        qtyInput.value = quantity;
        if (formQuantity) formQuantity.value = quantity;
        if (formWeight) formWeight.value = currentWeight;
    }

    qtyInput.addEventListener("input", function() {
        let val = parseInt(this.value);
        if (!isNaN(val) && val > 0) {
            if (val > stock) {
                quantity = stock;
            } else {
                quantity = val;
            }
            updateUI();
        }
    });

    qtyInput.addEventListener("blur", function() {
        let val = parseInt(this.value);
        if (isNaN(val) || val < 1) {
            quantity = 1;
            updateUI();
        }
    });

    plus.onclick = function () {
        if (quantity < stock) {
            quantity++;
            updateUI();
        } else {
            alert("Số lượng sản phẩm trong kho chỉ còn " + stock);
        }
    };

    minus.onclick = function () {
        if (quantity > 1) {
            quantity--;
            updateUI();
        }
    };

    weightBtns.forEach(btn => {
        btn.onclick = function () {
            weightBtns.forEach(b => b.classList.remove("active"));
            this.classList.add("active");
            currentWeight = parseInt(this.dataset.weight);
            updateUI();
        };
    });

    updateUI();

    const btnFavorite = document.querySelector('.btn-favorite');
    if (btnFavorite) {
        btnFavorite.addEventListener('click', function(e) {
            e.preventDefault();
            this.classList.toggle('active');
            let icon = this.querySelector('i');
            if(this.classList.contains('active')) {
                icon.classList.remove('fa-regular');
                icon.classList.add('fa-solid');
            } else {
                icon.classList.remove('fa-solid');
                icon.classList.add('fa-regular');
            }
        });
    }

    const addToCartForm = document.getElementById("addToCartForm");
    if (addToCartForm) {
        addToCartForm.addEventListener("submit", function(e) {
            if (stock <= 0) {
                e.preventDefault();
                alert("Sản phẩm đã hết hàng!");
                return;
            }
            if (quantity > stock) {
                e.preventDefault();
                alert("Số lượng sản phẩm trong kho không đủ!");
                return;
            }
        });
    }

});