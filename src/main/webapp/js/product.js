document.addEventListener("DOMContentLoaded", () => {
    const products = document.querySelectorAll(".product-card");
    const buttons = document.querySelectorAll(".category-buttons button");
    const searchInput = document.getElementById("searchInput");
    const container = document.getElementById("productContainer");
    let currentCategory = "all";
    let currentPrice = "all";
    let currentSort = "new";

    function filter() {

        const keyword = searchInput.value.trim().toLowerCase();
        let list = Array.from(products);

        list.forEach(product => {

            const name = product.dataset.name.toLowerCase();
            const category = product.dataset.category;
            const price = parseFloat(product.dataset.price);

            let show = true;

            if (currentCategory !== "all" && category !== currentCategory) {
                show = false;
            }

            if (keyword !== "" && !name.includes(keyword)) {
                show = false;
            }

            if (currentPrice === "low" && price >= 200000) {
                show = false;
            }

            if (currentPrice === "mid" && (price < 200000 || price > 500000)) {
                show = false;
            }

            if (currentPrice === "high" && price <= 500000) {
                show = false;
            }

            product.style.display = show ? "block" : "none";
        });

        if (currentSort === "asc") {
            list.sort((a, b) => parseFloat(a.dataset.price) - parseFloat(b.dataset.price));
        }

        if (currentSort === "desc") {
            list.sort((a, b) => parseFloat(b.dataset.price) - parseFloat(a.dataset.price));
        }

        list.forEach(product => {
            container.appendChild(product);
        });
    }

    buttons.forEach(button => {
        button.addEventListener("click", () => {

            // reset active
            buttons.forEach(btn => btn.classList.remove("active"));
            button.classList.add("active");

            // update state
            currentCategory = button.dataset.category;

            // call filter
            filter();
        });
    });
    searchInput.addEventListener("input", () => {
        filter();
    });

    function setupSelect(id, callback) {
        const select = document.getElementById(id);
        const selected = select.querySelector(".select-selected");
        const options = select.querySelectorAll(".select-options div");
        selected.addEventListener("click", () => {
            select.classList.toggle("active");
        });

        options.forEach(option => {
            option.addEventListener("click", () => {

                selected.textContent = option.textContent;
                select.classList.remove("active");

                callback(option.dataset.value);
            });
        });
    }

    setupSelect("priceFilter", value => {
        currentPrice = value;
        filter();
    });

    setupSelect("sortFilter", value => {
        currentSort = value;
        filter();
    });

});