<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="cart-section-premium">
    <div class="container">
        <div class="cart-progress-stepper">
            <div class="step active">
                <span class="step-icon"><i class="fa-solid fa-cart-shopping"></i></span>
                <span class="step-label">Giỏ hàng</span>
            </div>
            <div class="step-line"></div>
            <div class="step">
                <span class="step-icon"><i class="fa-solid fa-credit-card"></i></span>
                <span class="step-label">Thanh toán</span>
            </div>
            <div class="step-line"></div>
            <div class="step">
                <span class="step-icon"><i class="fa-solid fa-circle-check"></i></span>
                <span class="step-label">Hoàn tất</span>
            </div>
        </div>

        <h2 class="cart-premium-title">Giỏ hàng của bạn</h2>
        
        <c:choose>
            <c:when test="${not empty cartItems}">
                <div class="cart-layout">
                    <div class="cart-items-container">
                        <c:forEach var="item" items="${cartItems}">
                            <div class="cart-item-card-premium">
                                <div class="cart-item-image">
                                    <img src="${pageContext.request.contextPath}${item.productImage}" alt="${item.productName}">
                                </div>
                                <div class="cart-item-info">
                                    <div class="item-main-details">
                                        <div class="name-unit">
                                            <h3 class="product-name">${item.productName}</h3>
                                            <span class="product-unit">${item.unit != null ? item.unit : '200g'}</span>
                                        </div>
                                        <button class="remove-btn-icon" title="Xóa">
                                            <i class="fa-regular fa-trash-can"></i>
                                        </button>
                                    </div>
                                    
                                    <div class="item-pricing-row">
                                        <div class="price-breakdown">
                                            <div class="price-detail">
                                                <span class="label">Đơn giá:</span>
                                                <span class="val">${item.price}đ</span>
                                            </div>
                                            <div class="price-detail total">
                                                <span class="label">Thành tiền:</span>
                                                <span class="val highlighted">${item.price * item.quantity}đ</span>
                                            </div>
                                        </div>
                                        <div class="quantity-picker">
                                            <button class="picker-btn minus">-</button>
                                            <span class="picker-val">${item.quantity}</span>
                                            <button class="picker-btn plus">+</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>

                    <div class="cart-summary-sidebar">
                        <div class="summary-card-premium sticky">
                            <h3 class="summary-card-title">Tóm tắt đơn hàng</h3>
                            
                            <div class="coupon-box">
                                <div class="coupon-input-wrapper">
                                    <i class="fa-solid fa-ticket"></i>
                                    <input type="text" placeholder="Mã giảm giá">
                                </div>
                                <button class="btn-apply-coupon">Áp dụng</button>
                            </div>

                            <div class="summary-bill-details">
                                <div class="bill-row">
                                    <span class="label">Tạm tính</span>
                                    <span class="val">${subtotal != null ? subtotal : '360.000đ'}</span>
                                </div>
                                <div class="bill-row">
                                    <span class="label">Khuyến mãi</span>
                                    <span class="val discount-val">-0đ</span>
                                </div>
                                <div class="bill-row">
                                    <span class="label">Phí vận chuyển</span>
                                    <span class="val shipping-free">Miễn phí</span>
                                </div>
                                
                                <div class="bill-divider"></div>
                                
                                <div class="bill-row grand-total">
                                    <span class="label">Tổng cộng</span>
                                    <span class="val final-price">${total != null ? total : '360.000đ'}</span>
                                </div>
                            </div>
                            
                            <div class="cart-actions-group">
                                <a href="${pageContext.request.contextPath}/checkout" class="btn-checkout-link">
                                    <button class="btn-checkout-premium">Thanh toán ngay <i class="fa-solid fa-arrow-right"></i></button>
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
                    <p>Có vẻ như bạn chưa chọn được món thịt nào ưng ý. Hãy khám phá ngay thế giới thịt sạch của chúng tôi!</p>
                    <a href="${pageContext.request.contextPath}/product" class="btn-start-shopping">
                        Khám phá sản phẩm <i class="fa-solid fa-arrow-right"></i>
                    </a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>
