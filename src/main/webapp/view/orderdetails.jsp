<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="order-details-container">
    <div class="container">
        <div class="details-header">
            <div class="order-title-group">
                <a href="${pageContext.request.contextPath}/order-history" class="back-link">
                    <i class="fa-solid fa-arrow-left"></i> Lịch sử đơn hàng
                </a>
                <h1>Đơn hàng ${order.shortOrderID}</h1>
                <div class="order-meta-info">
                    <fmt:parseDate value="${order.created_at}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDate" type="both" />
                    <span><i class="fa-regular fa-calendar-check" style="margin-right: 5px;"></i> <fmt:formatDate value="${parsedDate}" pattern="dd MMMM, yyyy" /></span>
                    <span class="order-dot"></span>
                    <span><i class="fa-regular fa-clock" style="margin-right: 5px;"></i> <fmt:formatDate value="${parsedDate}" pattern="HH:mm" /></span>
                </div>
            </div>
            <div class="header-actions">
                <button class="btn-print" onclick="window.print()">
                    <i class="fa-solid fa-file-invoice"></i> In hóa đơn
                </button>
            </div>
        </div>

        <div class="stepper-card">
            <c:set var="statusKey" value="all" />
            <c:choose>
                <c:when test="${order.status eq 'pending' || order.status eq 'Chờ xác nhận'}"><c:set var="statusKey" value="pending" /></c:when>
                <c:when test="${order.status eq 'in progress' || order.status eq 'processing' || order.status eq 'Đang xử lý'}"><c:set var="statusKey" value="processing" /></c:when>
                <c:when test="${order.status eq 'delivery' || order.status eq 'Đang giao hàng'}"><c:set var="statusKey" value="delivery" /></c:when>
                <c:when test="${order.status eq 'finished' || order.status eq 'Hoàn thành'}"><c:set var="statusKey" value="finished" /></c:when>
                <c:when test="${order.status eq 'cancled' || order.status eq 'Đã hủy'}"><c:set var="statusKey" value="cancled" /></c:when>
            </c:choose>

            <div class="order-stepper">
                <div class="step ${statusKey eq 'pending' ? 'active' : 'completed'}">
                    <div class="step-circle"><i class="fa-solid fa-receipt"></i></div>
                    <span class="step-text">Đặt hàng</span>
                </div>
                <div class="step-line ${statusKey ne 'pending' ? 'completed' : ''}"></div>
                
                <div class="step ${statusKey eq 'processing' ? 'active' : (statusKey eq 'delivery' || statusKey eq 'finished' ? 'completed' : '')}">
                    <div class="step-circle"><i class="fa-solid fa-box"></i></div>
                    <span class="step-text">Xử lý</span>
                </div>
                <div class="step-line ${statusKey eq 'delivery' || statusKey eq 'finished' ? 'completed' : ''}"></div>
                
                <div class="step ${statusKey eq 'delivery' ? 'active' : (statusKey eq 'finished' ? 'completed' : '')}">
                    <div class="step-circle"><i class="fa-solid fa-truck-fast"></i></div>
                    <span class="step-text">Vận chuyển</span>
                </div>
                <div class="step-line ${statusKey eq 'finished' ? 'completed' : ''}"></div>
                
                <div class="step ${statusKey eq 'finished' ? 'active' : ''}">
                    <div class="step-circle"><i class="fa-solid fa-circle-check"></i></div>
                    <span class="step-text">Hoàn thành</span>
                </div>
            </div>
            <c:if test="${statusKey eq 'cancled'}">
                <div style="text-align: center; margin-top: 20px; color: #ef4444; font-weight: 700;">
                    <i class="fa-solid fa-circle-xmark"></i> ĐƠN HÀNG ĐÃ HỦY
                </div>
            </c:if>
        </div>

        <div class="details-grid">
            <div class="info-card">
                <h3 class="card-title">
                    <div class="icon-box"><i class="fa-solid fa-truck-ramp-box"></i></div>
                    Vận chuyển
                </h3>
                <div class="info-item">
                    <span class="info-label">Người nhận</span>
                    <span class="info-value">${user.name}</span>
                </div>
                <div class="info-item">
                    <span class="info-label">Số điện thoại</span>
                    <span class="info-value">${user.phone}</span>
                </div>
                <div class="info-item">
                    <span class="info-label">Địa chỉ</span>
                    <span class="info-value">${order.address.address}</span>
                </div>
            </div>

            <div class="info-card">
                <h3 class="card-title">
                    <div class="icon-box"><i class="fa-solid fa-wallet"></i></div>
                    Thanh toán
                </h3>
                <div class="info-item">
                    <span class="info-label">Phương thức</span>
                    <span class="info-value">${order.payment_method != null ? order.payment_method : 'Thanh toán khi nhận hàng'}</span>
                </div>
                <div class="info-item">
                    <span class="info-label">Đơn vị vận chuyển</span>
                    <span class="info-value">${order.transport_method != null ? order.transport_method : 'Clean Meat Delivery'}</span>
                </div>
                <div class="info-item">
                    <span class="info-label">Trạng thái</span>
                    <span class="info-value text-success">Đã thanh toán</span>
                </div>
            </div>

            <div class="info-card">
                <h3 class="card-title">
                    <div class="icon-box"><i class="fa-solid fa-clock-rotate-left"></i></div>
                    Hoạt động
                </h3>
                <div class="info-item">
                    <span class="info-label">Gần nhất</span>
                    <span class="info-value">Đơn hàng đang được chuẩn bị để giao cho đối tác vận chuyển.</span>
                </div>
                <div style="margin-top: 20px;">
                    <div style="display: flex; align-items: center; gap: 10px; margin-bottom: 8px; font-size: 0.9rem; color: #10b981;">
                        <i class="fa-solid fa-circle-check"></i> <span>Đã xác nhận thanh toán</span>
                    </div>
                    <div style="display: flex; align-items: center; gap: 10px; font-size: 0.9rem; color: #10b981;">
                        <i class="fa-solid fa-circle-check"></i> <span>Đơn hàng hợp lệ</span>
                    </div>
                </div>
            </div>
        </div>

        <div class="items-card">
            <div class="items-header">
                <h3 class="card-title" style="margin-bottom: 0;">
                    <div class="icon-box"><i class="fa-solid fa-cubes"></i></div>
                    Sản phẩm đã chọn
                </h3>
            </div>
            <table class="order-table">
                <thead>
                    <tr>
                        <th>Sản phẩm</th>
                        <th>Đơn giá</th>
                        <th>Số lượng</th>
                        <th style="text-align: right;">Thành tiền</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="item" items="${order.items}">
                        <tr>
                            <td>
                                <div class="product-cell">
                                    <c:choose>
                                        <c:when test="${item.itemImage.startsWith('http')}">
                                            <img src="${item.itemImage}" class="product-img" onerror="this.src='${pageContext.request.contextPath}/images/placeholder.png'">
                                        </c:when>
                                        <c:when test="${item.itemImage.startsWith('/')}">
                                            <img src="${pageContext.request.contextPath}${item.itemImage}" class="product-img" onerror="this.src='${pageContext.request.contextPath}/images/placeholder.png'">
                                        </c:when>
                                        <c:otherwise>
                                            <img src="${pageContext.request.contextPath}/images/${item.itemImage}" class="product-img" onerror="this.src='${pageContext.request.contextPath}/images/placeholder.png'">
                                        </c:otherwise>
                                    </c:choose>
                                    <div class="product-info">
                                        <h4>${item.itemName}</h4>
                                        <span>${item.weight}g / ${item.unitName}</span>
                                    </div>
                                </div>
                            </td>
                            <td><fmt:formatNumber value="${item.price / (item.quantity > 0 ? item.quantity : 1)}" currencySymbol="đ" type="currency" maxFractionDigits="0"/></td>
                            <td style="font-weight: 700; color: #0f172a;">x${item.quantity}</td>
                            <td style="text-align: right; font-weight: 800; color: #0f172a;">
                                <fmt:formatNumber value="${item.price}" currencySymbol="đ" type="currency" maxFractionDigits="0"/>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <div class="summary-container">
            <div class="summary-card">
                <div class="summary-row">
                    <span>Tạm tính</span>
                    <span><fmt:formatNumber value="${order.total_price - 25000}" currencySymbol="đ" type="currency" maxFractionDigits="0"/></span>
                </div>
                <div class="summary-row">
                    <span>Phí giao hàng</span>
                    <span>25.000đ</span>
                </div>
                <div class="summary-row" style="color: #10b981;">
                    <span>Giảm giá</span>
                    <span>-0đ</span>
                </div>
                <div class="summary-row total">
                    <span>Tổng cộng</span>
                    <span class="value"><fmt:formatNumber value="${order.total_price}" currencySymbol="đ" type="currency" maxFractionDigits="0"/></span>
                </div>
            </div>
        </div>
    </div>
</div>
