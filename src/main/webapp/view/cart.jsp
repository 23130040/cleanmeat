<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="cart-section-premium">
    <div class="container">

        <div class="cart-header-row">
            <h2 class="cart-premium-title">Giỏ hàng của bạn</h2>
            <button class="btn-clear-cart" id="btn-clear-all" title="Xóa tất cả sản phẩm">
                <i class="fa-regular fa-trash-can"></i>
                Xóa tất cả
            </button>
        </div>

        <c:choose>
            <c:when test="${not empty cartItems}">
                <div class="cart-layout">
                    <div class="cart-items-container">
                        <c:forEach var="item" items="${cartItems}">
                            <div class="cart-item-card-premium">
                                <div class="cart-item-image">
                                    <img src="${pageContext.request.contextPath}/images/${item.item.image}"
                                         alt="${item.item.name}">
                                </div>
                                <div class="cart-item-info">
                                    <div class="item-main-details">
                                        <div class="name-unit">
                                            <h3 class="product-name">${item.item.name}</h3>
                                            <div class="weight-selector-cart">
                                                <span class="selector-label">Trọng lượng:</span>
                                                <div class="weight-select-wrapper">
                                                    <select class="cart-weight-select" data-item-id="${item.id}" data-old-weight="${item.weight}">
                                                        <option value="250" ${item.weight == 250 ? 'selected' : ''}>250g</option>
                                                        <option value="500" ${item.weight == 500 ? 'selected' : ''}>500g</option>
                                                        <option value="1000" ${item.weight == 1000 ? 'selected' : ''}>1kg</option>
                                                    </select>
                                                    <i class="fa-solid fa-chevron-down select-icon"></i>
                                                </div>
                                            </div>
                                        </div>
                                        <button class="remove-btn-icon btn-remove-cart" data-item-id="${item.id}"
                                                title="Xóa">
                                            <i class="fa-regular fa-trash-can"></i>
                                        </button>
                                    </div>

                                    <div class="item-pricing-row">
                                        <div class="price-breakdown">
                                            <div class="price-detail">
                                                <span class="label">Đơn giá:</span>
                                                <div class="unit-price-wrapper">
                                                    <c:if test="${item.item.discount > 0}">
                                                        <span class="old-val"><fmt:formatNumber value="${item.originalPrice}" maxFractionDigits="0"/>đ</span>
                                                    </c:if>
                                                    <span class="val current-unit-price"><fmt:formatNumber value="${item.unitPrice}" maxFractionDigits="0"/>đ</span>
                                                </div>
                                            </div>
                                            <div class="price-detail total">
                                                <span class="label">Thành tiền:</span>
                                                <span class="val highlighted"><fmt:formatNumber value="${item.subTotal}"
                                                                                                maxFractionDigits="0"/>đ</span>
                                            </div>
                                        </div>
                                        <div class="quantity-control-group">
                                            <span class="quantity-label">Số lượng:</span>
                                            <div class="quantity-picker">
                                                <button class="picker-btn minus btn-qty" data-item-id="${item.id}"
                                                        data-delta="-1">-
                                                </button>
                                                <span class="picker-val" id="qty-${item.id}">${item.quantity}</span>
                                                <button class="picker-btn plus btn-qty" data-item-id="${item.id}"
                                                        data-delta="1">+
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>

                    <div class="cart-summary-sidebar">
                        <div class="summary-card-premium sticky">
                            <h3 class="summary-card-title">Tóm tắt đơn hàng</h3>

                            <div class="summary-bill-details">
                                <div class="bill-row">
                                    <span class="label">Tạm tính</span>
                                    <span class="val"><fmt:formatNumber value="${subtotal}"
                                                                        maxFractionDigits="0"/>đ</span>
                                </div>
                                <div class="bill-row">
                                    <span class="label">Phí vận chuyển</span>
                                    <span class="val shipping-free">Miên phí</span>
                                </div>

                                <div class="bill-divider"></div>

                                <div class="bill-row grand-total">
                                    <span class="label">Tổng cộng</span>
                                    <span class="val final-price"><fmt:formatNumber value="${total}"
                                                                                    maxFractionDigits="0"/>đ</span>
                                </div>
                            </div>

                            <div class="cart-actions-group">
                                <a href="${pageContext.request.contextPath}/checkout" class="btn-checkout-link">
                                    <button class="btn-checkout-premium">Thanh toán ngay <i
                                            class="fa-solid fa-arrow-right"></i></button>
                                </a>
                                <a href="${pageContext.request.contextPath}/product" class="btn-continue-link">
                                    Tiếp tục mua sắm
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <div class="cart-empty-state">
                    <div class="empty-illustration">
                        <div class="bag-icon-wrapper">
                            <i class="fa-solid fa-basket-shopping"></i>
                        </div>
                    </div>
                    <h2>Giỏ hàng của bạn đang trống</h2>
                    <p>Có vẻ như bạn chưa chọn được món thịt nào ưng ý. Hãy khám phá ngay thế giới thịt sạch của chúng
                        tôi!</p>
                    <a href="${pageContext.request.contextPath}/product" class="btn-start-shopping">
                        Khám phá sản phẩm <i class="fa-solid fa-arrow-right"></i>
                    </a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>
