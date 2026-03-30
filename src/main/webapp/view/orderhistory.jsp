<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<form class="order-history-premium" action="${pageContext.request.contextPath}/order-history" method="get">
    <div class="container">
        <div class="premium-header">
            <div class="header-content">
                <h1 class="page-title">Lịch sử đơn hàng</h1>
                <p class="page-subtitle">Theo dõi và quản lý các đơn hàng của bạn</p>
            </div>
            <div class="stats-overview">
                <div class="stat-card glass">
                    <div class="stat-icon"><i class="fa-solid fa-box-archive"></i></div>
                    <div class="stat-data">
                        <span class="stat-value">${fn:length(orders)}</span>
                        <span class="stat-label">Tổng đơn hàng</span>
                    </div>
                </div>
                <div class="stat-card glass accent">
                    <div class="stat-icon"><i class="fa-solid fa-truck-fast"></i></div>
                    <div class="stat-data">
                        <span class="stat-value">${fn:length(deliveringOrders)}</span>
                        <span class="stat-label">Đang giao</span>
                    </div>
                </div>
                <div class="stat-card glass">
                    <div class="stat-icon"><i class="fa-solid fa-circle-check"></i></div>
                    <div class="stat-data">
                        <span class="stat-value">${fn:length(finishedOrders)}</span>
                        <span class="stat-label">Đã hoàn thành</span>
                    </div>
                </div>
            </div>
        </div>

        <div class="order-controls glass">
            <div class="search-box">
                <i class="fa-solid fa-magnifying-glass"></i>
                <input type="text" placeholder="Tìm theo mã đơn hàng hoặc tên sản phẩm...">
            </div>
            <div class="pill-tabs">
                <button class="pill-tab active">Tất cả</button>
                <button class="pill-tab">Chờ duyệt</button>
                <button class="pill-tab">Đang xử lý</button>
                <button class="pill-tab">Đang giao hàng</button>
                <button class="pill-tab">Hoàn thành</button>
                <button class="pill-tab">Đã hủy</button>
            </div>
        </div>

        <div class="order-list">
            <c:choose>
            <c:when test="${not empty orders}">
            <c:forEach var="order" items="${orders}">
            <input type="hidden" name="orderId" value="${order.id}">
            <div class="premium-order-card is-active">
                <div class="card-status-bar status-shipping"></div>
                <div class="card-content">
                    <div class="order-summary-row">
                        <div class="order-meta">
                            <span class="order-id">Đơn hàng ${order.orderIDFormatted}</span>
                            <span class="order-date">${order.created_at.dayOfMonth}/${order.created_at.month}/${order.created_at.year} • ${order.created_at.hour}:${order.created_at.minute}:${order.created_at.second}</span>
                        </div>
                        <div class="order-status-pill status-shipping">
                            <c:if test="${order.status eq 'pending'}">
                                <i class="fa-solid fa-spinner"></i> Chờ duyệt
                            </c:if>
                            <c:if test="${order.status eq 'in progress'}">
                                <i class="fa-solid fa-gear"></i> Đang xử lý
                            </c:if>
                            <c:if test="${order.status eq 'delivery'}">
                                <i class="fa-regular fa-truck"></i> Đang giao hàng
                            </c:if>
                            <c:if test="${order.status eq 'finished'}">
                                <i class="fa-regular fa-circle-check"></i> Hoàn thành
                            </c:if>
                            <c:if test="${order.status eq 'cancled'}">
                                <i class="fa-regular fa-circle-xmark"></i> Đã hủy
                            </c:if>
                        </div>
                    </div>
                    <c:if test="${order.status ne 'finished' || order.status ne 'cancled'}">
                    <div class="order-timeline-mini">
                        <div class="step
                                        <c:if test="${order.status eq 'in progress' || order.status eq 'delivery' || order.status eq 'finished'}">completed</c:if>
                                        <c:if test="${order.status eq 'pending'}">active</c:if>">
                            <div class="step-dot"></div>
                            <span class="step-label">Đã duyệt</span>
                            <c:if test="${order.status eq 'pending'}">
                                <div class="step-line"></div>
                            </c:if>
                        </div>
                        <div class="step completed">
                            <div class="step
                                        <c:if test="${order.status eq 'delivery' || order.status eq 'finished'}">completed</c:if>
                                        <c:if test="${order.status eq 'in progress'}">active</c:if>">
                                <div class="step-dot"></div>
                                <span class="step-label">Đã xử lý</span>
                                <c:if test="${order.status eq 'in progress'}">
                                    <div class="step-line"></div>
                                </c:if>
                            </div>
                            <div class="step active">
                                <div class="step
                                        <c:if test="${order.status eq 'finished'}">completed</c:if>
                                        <c:if test="${order.status eq 'delivery'}">active</c:if>">
                                    <div class="step-dot"></div>
                                    <span class="step-label">Đang giao</span>
                                    <c:if test="${order.status eq 'delivery'}">
                                        <div class="step-line"></div>
                                    </c:if>
                                </div>
                                <div class="step">
                                    <c:if test="${order.status eq 'finished'}">active</c:if>">
                                    <div class="step-dot"></div>
                                    <span class="step-label">Đã nhận</span>
                                </div>
                            </div>
                            </c:if>
                            <div class="order-product-details">
                                <c:forEach var="oi" items="${orderItems}">
                                    <input type="hidden" name="itemId" value="${oi.item_id}">
                                    <div class="product-info-group">
                                        <div class="product-thumb">
                                            <img src="${pageContext.request.contextPath}${itemPrimaryImageUrl}"
                                                 alt="${item.name}">
                                        </div>
                                        <div class="product-text">
                                            <h3 class="product-name">${item.name}</h3>
                                            <p class="product-qty">${oi.quantity} sản phẩm • Gói ${packaging}</p>
                                        </div>
                                    </div>
                                </c:forEach>
                                <div class="order-price-group">
                                    <span class="price-label">Tổng thanh toán</span>
                                    <span class="price-amount">${order.total_price} đ</span>
                                </div>
                            </div>

                            <div class="card-footer-actions">
                                <a href="#" class="btn-text-only">Xem chi tiết đơn hàng</a>
                                <div class="btn-group">
                                    <button class="btn-secondary-outline">Liên hệ hỗ trợ</button>
                                    <button class="btn-primary-gradient">Mua lại</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <p style="font-style: italic; color:#9ca3b7">Chưa có đơn hàng nào.</p>
                    </c:otherwise>
                    </c:choose>
                </div>
            </div>
</form>
