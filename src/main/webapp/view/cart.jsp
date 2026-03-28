<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="cart-section">
    <div class="container">
        <h2 class="cart-page-title">Giỏ hàng của bạn</h2>
        
        <div class="cart-layout">
            <div class="cart-items-container">
                <c:choose>
                    <c:when test="${not empty cartItems}">
                        <c:forEach var="item" items="${cartItems}">
                            <div class="cart-item-card">
                                <div class="cart-item-image">
                                    <img src="${pageContext.request.contextPath}${item.productImage}" alt="${item.productName}">
                                </div>
                                <div class="cart-item-details">
                                    <div class="item-header">
                                        <h3 class="item-name">${item.productName}</h3>
                                        <button class="remove-item-btn" title="Xóa sản phẩm">
                                            <i class="fa-regular fa-trash-can"></i>
                                        </button>
                                    </div>
                                    <p class="item-unit">${item.unit != null ? item.unit : '200g'}</p>
                                    <p class="item-price">${item.price}đ</p>
                                    <div class="item-footer">
                                        <div class="quantity-controls">
                                            <button class="qty-btn minus">-</button>
                                            <span class="qty-value">${item.quantity}</span>
                                            <button class="qty-btn plus">+</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="cart-item-card">
                            <div class="cart-item-image">
                                <img src="${pageContext.request.contextPath}/images/pork.jpg" alt="Thịt Heo Sạch">
                            </div>
                            <div class="cart-item-details">
                                <div class="item-header">
                                    <h3 class="item-name">Thịt Heo Sạch</h3>
                                    <button class="remove-item-btn" title="Xóa sản phẩm">
                                        <i class="fa-regular fa-trash-can"></i>
                                    </button>
                                </div>
                                <p class="item-unit">200g</p>
                                <p class="item-price">180.000đ</p>
                                <div class="item-footer">
                                    <div class="quantity-controls">
                                        <button class="qty-btn minus">-</button>
                                        <span class="qty-value">2</span>
                                        <button class="qty-btn plus">+</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="cart-summary-container">
                <div class="summary-card">
                    <h3 class="summary-title">Tóm tắt đơn hàng</h3>
                    
                    <div class="summary-details">
                        <div class="summary-row">
                            <span class="label">Tạm tính</span>
                            <span class="value">${subtotal != null ? subtotal : '360.000đ'}</span>
                        </div>
                        <div class="summary-row">
                            <span class="label">Phí vận chuyển</span>
                            <span class="value shipping-free">Miễn phí</span>
                        </div>
                        
                        <div class="summary-divider"></div>
                        
                        <div class="summary-row total-row">
                            <span class="label">Tổng cộng</span>
                            <span class="value total-price">${total != null ? total : '360.000đ'}</span>
                        </div>
                    </div>
                    
                    <div class="summary-actions">
                        <a href="${pageContext.request.contextPath}/checkout"><button class="btn-checkout">Tiến hành đặt hàng</button></a>
                        <a href="${pageContext.request.contextPath}/product"><button class="btn-continue">Tiếp tục mua sắm</button></a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
