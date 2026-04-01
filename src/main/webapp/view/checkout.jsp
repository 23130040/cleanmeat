<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="checkout-section">
    <div class="container">
        <a href="${pageContext.request.contextPath}/cart" class="back-to-cart-link">
            <i class="fa-solid fa-arrow-left"></i> Quay lại giỏ hàng
        </a>
        
        <h2 class="checkout-page-title">Thông tin đặt hàng</h2>
        
        <div class="checkout-layout">
            <form action="${pageContext.request.contextPath}/checkout/confirm" method="post" class="checkout-form-container">

                <div class="checkout-card">
                    <h3 class="section-title">Thông tin người nhận</h3>
                    <div class="form-row">
                        <div class="form-group col-6">
                            <label for="fullName">Họ và tên <span class="required">*</span></label>
                            <input type="text" id="fullName" name="fullName" placeholder="Nhập họ và tên" required value="${user.name}">
                        </div>
                        <div class="form-group col-6">
                            <label for="phoneNumber">Số điện thoại <span class="required">*</span></label>
                            <input type="tel" id="phoneNumber" name="phoneNumber" placeholder="Nhập số điện thoại" required value="${user.phone}">
                        </div>
                    </div>
                    <div class="form-group full-width">
                        <label for="email">Email <span class="required">*</span></label>
                        <input type="email" id="email" name="email" placeholder="Nhập email" required value="${user.email}">
                    </div>
                </div>

                <div class="checkout-card">
                    <h3 class="section-title">Địa chỉ giao hàng</h3>
                    <div class="address-selection-list">
                        <c:forEach var="address" items="${addresses}">
                            <label class="address-option">
                                <input type="radio" name="addressOption" value="${address.id}" ${address.is_Default ? 'checked' : ''}>
                                <div class="address-radio-custom"></div>
                                <div class="address-info">
                                    <span class="receiver-name">${user.name} <c:if test="${address.is_Default}"><span class="tag-default">Mặc định</span></c:if></span>
                                    <span class="receiver-phone">${user.phone}</span>
                                    <span class="receiver-address">${address.address}</span>
                                </div>
                            </label>
                        </c:forEach>

                        <label class="address-option">
                            <input type="radio" name="addressOption" value="new" id="useNewAddress">
                            <div class="address-radio-custom"></div>
                            <div class="address-info">
                                <span class="receiver-name">Sử dụng địa chỉ khác</span>
                            </div>
                        </label>
                    </div>

                    <div id="newAddressForm" class="manual-address-form" style="display: none; border-top: 1px solid #f3f4f6; padding-top: 20px; margin-top: 15px;">
                        <div class="form-group full-width">
                            <label for="address">Địa chỉ cụ thể <span class="required">*</span></label>
                            <input type="text" id="address" name="address" placeholder="Số nhà, tên đường...">
                        </div>
                    </div>

                </div>

                <div class="checkout-card">
                    <h3 class="section-title">Phương thức vận chuyển</h3>
                    <div class="shipping-methods-list">
                        <c:forEach var="t" items="${transports}" varStatus="loop">
                            <label class="shipping-method-option">
                                <input type="radio" name="shippingOption" value="${t.id}" 
                                       data-fee="${t.base_fee}" 
                                       data-free-threshold="${t.free_ship != null ? t.free_ship : 9999999}"
                                       ${loop.first ? 'checked' : ''}>
                                <div class="shipping-radio-custom"></div>
                                <div class="shipping-method-icon">
                                    <i class="fa-solid ${t.name.contains('nhanh') ? 'fa-bolt' : 'fa-truck'}"></i>
                                </div>
                                <div class="shipping-method-info">
                                    <span class="shipping-name">${t.name}</span>
                                    <span class="shipping-description">Giao hàng trong khoảng ${t.estimate_day} ngày</span>
                                    <c:if test="${t.free_ship > 0}">
                                        <span class="free-ship-note">Miễn phí cho đơn từ <fmt:formatNumber value="${t.free_ship}" maxFractionDigits="0"/>đ</span>
                                    </c:if>
                                </div>
                                <span class="shipping-price dynamic-fee" data-base-fee="${t.base_fee}">
                                    <c:choose>
                                        <c:when test="${t.base_fee == 0}">Miễn phí</c:when>
                                        <c:otherwise><fmt:formatNumber value="${t.base_fee}" maxFractionDigits="0"/>đ</c:otherwise>
                                    </c:choose>
                                </span>
                            </label>
                        </c:forEach>
                    </div>
                </div>

                <div class="checkout-card">
                    <h3 class="section-title">Phương thức thanh toán</h3>
                    <div class="payment-methods-list">
                        <c:forEach var="p" items="${payments}" varStatus="loop">
                            <label class="payment-method-option ${loop.first ? 'active' : ''}">
                                <input type="radio" name="paymentOption" value="${p.id}" ${loop.first ? 'checked' : ''}>
                                <div class="payment-radio-custom"></div>
                                <div class="payment-method-icon">
                                    <c:choose>
                                        <c:when test="${p.name.contains('nhận hàng') || p.name.contains('COD')}">
                                            <i class="fa-solid fa-hand-holding-dollar"></i>
                                        </c:when>
                                        <c:when test="${p.name.contains('VNPay')}">
                                            <i class="fa-solid fa-qrcode"></i>
                                        </c:when>
                                        <c:when test="${p.name.contains('Momo')}">
                                            <i class="fa-regular fa-wallet"></i>
                                        </c:when>
                                        <c:otherwise>
                                            <i class="fa-solid fa-credit-card"></i>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="payment-method-info">
                                    <span class="payment-name">${p.name}</span>
                                    <span class="payment-description">
                                        <c:choose>
                                            <c:when test="${p.name.contains('nhận hàng') || p.name.contains('COD')}">
                                                Thanh toán bằng tiền mặt khi nhận hàng
                                            </c:when>
                                            <c:when test="${p.name.contains('VNPay')}">
                                                Thanh toán qua cổng thanh toán VNPay
                                            </c:when>
                                            <c:when test="${p.name.contains('Momo')}">
                                                Thanh toán qua ví điện tử Momo
                                            </c:when>
                                            <c:otherwise>
                                                Phương thức thanh toán an toàn
                                            </c:otherwise>
                                        </c:choose>
                                    </span>
                                </div>
                            </label>
                        </c:forEach>
                    </div>
                </div>
            </form>

            <div class="checkout-summary-container">
                <div class="summary-card">
                    <h3 class="summary-title">Đơn hàng của bạn</h3>
                    
                    <div class="order-items-list">
                        <c:forEach var="item" items="${cartItems}">
                            <div class="order-item">
                                <div class="order-item-image">
                                    <img src="${pageContext.request.contextPath}/images/${item.item.image}">
                                </div>
                                <div class="order-item-details">
                                    <div class="name-qty">
                                        <span class="item-name">${item.item.name}</span>
                                        <span class="item-qty">
                                            <fmt:formatNumber value="${item.item.price}" maxFractionDigits="0"/>đ x ${item.quantity}
                                        </span>
                                    </div>
                                    <span class="item-subtotal">
                                        <fmt:formatNumber value="${item.subTotal}" maxFractionDigits="0"/>đ
                                    </span>
                                </div>
                            </div>
                        </c:forEach>
                    </div>

                    <div class="summary-divider"></div>

                    <div class="summary-details">
                        <div class="summary-row">
                            <span class="label">Tạm tính</span>
                            <span class="value subtotal-value">
                                <fmt:formatNumber value="${subtotal}" maxFractionDigits="0"/>đ
                            </span>
                        </div>
                        <div class="summary-row">
                            <span class="label">Phí vận chuyển</span>
                            <span class="value shipping-value ${shipping == 0 ? 'shipping-free' : ''}">
                                <c:choose>
                                    <c:when test="${shipping == 0}">Miễn phí</c:when>
                                    <c:otherwise><fmt:formatNumber value="${shipping}" maxFractionDigits="0"/>đ</c:otherwise>
                                </c:choose>
                            </span>
                        </div>
                        
                        <div class="summary-divider thick"></div>
                        
                        <div class="summary-row total-row">
                            <span class="label">Tổng cộng</span>
                            <span class="value total-value">
                                <fmt:formatNumber value="${total}" maxFractionDigits="0"/>đ
                            </span>
                        </div>
                    </div>

                    <button type="submit" class="btn-confirm-order">Xác nhận đặt hàng</button>

                    <div class="security-note">
                        <i class="fa-solid fa-shield-check"></i>
                        <div class="note-text">
                            <strong>Đảm bảo an toàn</strong>
                            <span>Thông tin của bạn được bảo mật tuyệt đối</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
