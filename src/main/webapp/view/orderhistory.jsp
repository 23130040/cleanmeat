<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="order-history-premium">
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
                        <span class="stat-value">12</span>
                        <span class="stat-label">Tổng đơn hàng</span>
                    </div>
                </div>
                <div class="stat-card glass accent">
                    <div class="stat-icon"><i class="fa-solid fa-truck-fast"></i></div>
                    <div class="stat-data">
                        <span class="stat-value">1</span>
                        <span class="stat-label">Đang giao</span>
                    </div>
                </div>
                <div class="stat-card glass">
                    <div class="stat-icon"><i class="fa-solid fa-circle-check"></i></div>
                    <div class="stat-data">
                        <span class="stat-value">11</span>
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
                <button class="pill-tab">Chờ xác nhận</button>
                <button class="pill-tab">Đang giao</button>
                <button class="pill-tab">Hoàn thành</button>
                <button class="pill-tab">Đã hủy</button>
            </div>
        </div>

        <div class="order-list">
            <c:choose>
                <c:when test="${not empty orders}">
                </c:when>
                <c:otherwise>
                    <div class="premium-order-card is-active">
                        <div class="card-status-bar status-shipping"></div>
                        <div class="card-content">
                            <div class="order-summary-row">
                                <div class="order-meta">
                                    <span class="order-id">Đơn hàng #CM12345</span>
                                    <span class="order-date">28/03/2026 • 14:30</span>
                                </div>
                                <div class="order-status-pill status-shipping">
                                    <i class="fa-solid fa-truck"></i> Đang giao hàng
                                </div>
                            </div>

                            <div class="order-timeline-mini">
                                <div class="step completed">
                                    <div class="step-dot"></div>
                                    <span class="step-label">Đã xác nhận</span>
                                </div>
                                <div class="step active">
                                    <div class="step-dot"></div>
                                    <span class="step-label">Đang giao</span>
                                    <div class="step-line"></div>
                                </div>
                                <div class="step">
                                    <div class="step-dot"></div>
                                    <span class="step-label">Đã nhận</span>
                                </div>
                            </div>

                            <div class="order-product-details">
                                <div class="product-info-group">
                                    <div class="product-thumb">
                                        <img src="${pageContext.request.contextPath}/images/pork.jpg" alt="Thịt Heo">
                                    </div>
                                    <div class="product-text">
                                        <h3 class="product-name">Thịt Heo Sạch (Combo Tiết Kiệm)</h3>
                                        <p class="product-qty">2 sản phẩm • Gói 500g</p>
                                    </div>
                                </div>
                                <div class="order-price-group">
                                    <span class="price-label">Tổng thanh toán</span>
                                    <span class="price-amount">360.000đ</span>
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

                    <div class="premium-order-card">
                        <div class="card-status-bar status-completed"></div>
                        <div class="card-content">
                            <div class="order-summary-row">
                                <div class="order-meta">
                                    <span class="order-id">Đơn hàng #CM12344</span>
                                    <span class="order-date">25/03/2026 • 09:15</span>
                                </div>
                                <div class="order-status-pill status-completed">
                                    <i class="fa-solid fa-circle-check"></i> Đã hoàn thành
                                </div>
                            </div>

                            <div class="order-product-details">
                                <div class="product-info-group">
                                    <div class="product-thumb">
                                        <img src="${pageContext.request.contextPath}/images/beef.jpg" alt="Thịt Bò">
                                    </div>
                                    <div class="product-text">
                                        <h3 class="product-name">Thịt Bò Mỹ Cao Cấp</h3>
                                        <p class="product-qty">1 sản phẩm • 300g</p>
                                    </div>
                                </div>
                                <div class="order-price-group">
                                    <span class="price-label">Đã thanh toán</span>
                                    <span class="price-amount">450.000đ</span>
                                </div>
                            </div>

                            <div class="card-footer-actions">
                                <a href="#" class="btn-text-only">Xem chi tiết đơn hàng</a>
                                <div class="btn-group">
                                    <button class="btn-secondary-outline">Đánh giá sản phẩm</button>
                                    <button class="btn-primary-gradient">Mua lại</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>
