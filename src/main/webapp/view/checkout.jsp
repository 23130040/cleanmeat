<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="checkout-section">
    <div class="container">
        <!-- Back Link -->
        <a href="${pageContext.request.contextPath}/cart" class="back-to-cart-link">
            <i class="fa-solid fa-arrow-left"></i> Quay lại giỏ hàng
        </a>
        
        <h2 class="checkout-page-title">Thông tin đặt hàng</h2>
        
        <div class="checkout-layout">
            <!-- Left: Checkout Forms -->
            <form action="${pageContext.request.contextPath}/checkout/confirm" method="post" class="checkout-form-container">
                
                <!-- Section: Recipient Information -->
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

                <!-- Section: Shipping Address -->
                <div class="checkout-card">
                    <h3 class="section-title">Địa chỉ giao hàng</h3>
                    <div class="form-row">
                        <div class="form-group col-6">
                            <label for="city">Tỉnh/Thành phố <span class="required">*</span></label>
                            <select id="city" name="city" required>
                                <option value="" disabled selected>Chọn tỉnh/thành phố</option>
                                <option value="Hồ Chí Minh">TP. Hồ Chí Minh</option>
                                <option value="Hà Nội">Hà Nội</option>
                                <option value="Đà Nẵng">Đà Nẵng</option>
                            </select>
                        </div>
                        <div class="form-group col-6">
                            <label for="district">Quận/Huyện <span class="required">*</span></label>
                            <input type="text" id="district" name="district" placeholder="Nhập quận/huyện" required>
                        </div>
                    </div>
                    <div class="form-group full-width">
                        <label for="address">Địa chỉ cụ thể <span class="required">*</span></label>
                        <input type="text" id="address" name="address" placeholder="Số nhà, tên đường..." required>
                    </div>
                    <div class="form-group full-width">
                        <label for="orderNote">Ghi chú đơn hàng</label>
                        <textarea id="orderNote" name="orderNote" placeholder="Ghi chú về đơn hàng, ví dụ: thời gian hay chỉ dẫn địa điểm giao hàng chi tiết hơn"></textarea>
                    </div>
                </div>

                <!-- Section: Payment Method -->
                <div class="checkout-card">
                    <h3 class="section-title">Phương thức thanh toán</h3>
                    <div class="payment-methods-list">
                        <!-- Option: COD -->
                        <label class="payment-method-option active">
                            <input type="radio" name="paymentOption" value="COD" checked>
                            <div class="payment-radio-custom"></div>
                            <div class="payment-method-icon">
                                <i class="fa-solid fa-hand-holding-dollar"></i>
                            </div>
                            <div class="payment-method-info">
                                <span class="payment-name">Thanh toán khi nhận hàng (COD)</span>
                                <span class="payment-description">Thanh toán bằng tiền mặt khi nhận hàng</span>
                            </div>
                        </label>

                        <!-- Option: Bank Transfer -->
                        <label class="payment-method-option">
                            <input type="radio" name="paymentOption" value="BANK">
                            <div class="payment-radio-custom"></div>
                            <div class="payment-method-icon">
                                <i class="fa-regular fa-credit-card"></i>
                            </div>
                            <div class="payment-method-info">
                                <span class="payment-name">Chuyển khoản ngân hàng</span>
                                <span class="payment-description">Chuyển khoản qua tài khoản ngân hàng</span>
                            </div>
                        </label>

                        <!-- Option: E-wallet -->
                        <label class="payment-method-option">
                            <input type="radio" name="paymentOption" value="WALLET">
                            <div class="payment-radio-custom"></div>
                            <div class="payment-method-icon">
                                <i class="fa-regular fa-wallet"></i>
                            </div>
                            <div class="payment-method-info">
                                <span class="payment-name">Ví điện tử (MoMo/ZaloPay)</span>
                                <span class="payment-description">Thanh toán qua ví điện tử MoMo hoặc ZaloPay</span>
                            </div>
                        </label>
                    </div>
                </div>
            </form>

            <!-- Right: Order Summary -->
            <div class="checkout-summary-container">
                <div class="summary-card">
                    <h3 class="summary-title">Đơn hàng của bạn</h3>
                    
                    <div class="order-items-list">
                        <c:choose>
                            <c:when test="${not empty cartItems}">
                                <c:forEach var="item" items="${cartItems}">
                                    <div class="order-item">
                                        <div class="order-item-image">
                                            <img src="${pageContext.request.contextPath}${item.productImage}">
                                        </div>
                                        <div class="order-item-details">
                                            <div class="name-qty">
                                                <span class="item-name">${item.productName}</span>
                                                <span class="item-qty">${item.price}đ x ${item.quantity}</span>
                                            </div>
                                            <span class="item-subtotal">${item.price * item.quantity}đ</span>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <!-- Sample item for visualization -->
                                <div class="order-item">
                                    <div class="order-item-image">
                                        <img src="${pageContext.request.contextPath}/images/pork.jpg">
                                    </div>
                                    <div class="order-item-details">
                                        <div class="name-qty">
                                            <span class="item-name">Thịt Heo Sạch</span>
                                            <span class="item-qty">180.000đ x 1</span>
                                        </div>
                                        <span class="item-subtotal">180.000đ</span>
                                    </div>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <div class="summary-divider"></div>

                    <div class="summary-details">
                        <div class="summary-row">
                            <span class="label">Tạm tính</span>
                            <span class="value">${subtotal != null ? subtotal : '180.000đ'}</span>
                        </div>
                        <div class="summary-row">
                            <span class="label">Phí vận chuyển</span>
                            <span class="value shipping-free">Miễn phí</span>
                        </div>
                        
                        <div class="summary-divider thick"></div>
                        
                        <div class="summary-row total-row">
                            <span class="label">Tổng cộng</span>
                            <span class="value total-price">${total != null ? total : '180.000đ'}</span>
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
