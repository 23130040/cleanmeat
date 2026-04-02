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

    plus.onclick = function () {
        quantity++;
        updateUI();
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

});