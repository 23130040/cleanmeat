<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="product-detail-wrapper">
    <div class="container">

        <div class="productdetail">

            <div class="product-image">
                <img src="${pageContext.request.contextPath}/images/${item.image}" alt="${item.name}">
            </div>

            <div class="product-info">
                <h1>${item.name}</h1>

                <div class="price">
                    <fmt:formatNumber value="${item.price}" maxFractionDigits="0"/> đ / ${item.unit_name}
                </div>

                <p>${item.short_description}</p>

                <p><b>Danh mục:</b> ${item.category_name}</p>
                <p><b>Xuất xứ:</b> ${item.origin_name}</p>
                <p><b>Tồn kho:</b> ${item.current_stock}</p>

                <div class="actions">
                    <form action="${pageContext.request.contextPath}/add-to-cart" method="post" id="addToCartForm">
                        <input type="hidden" name="itemId" value="${item.id}">
                        <input type="hidden" name="quantity" id="form-quantity" value="1">
                        <button type="submit" class="btn-add-to-cart">
                            <i class="fa-solid fa-cart-plus"></i> Thêm vào giỏ
                        </button>
                    </form>
                    <button class="btn-buy-now">Mua ngay</button>
                </div>
            </div>
        </div>

        <div class="product-extra">
            <h2>Chi tiết sản phẩm</h2>
            <p>${item.long_description}</p>
        </div>

    </div>
</div>