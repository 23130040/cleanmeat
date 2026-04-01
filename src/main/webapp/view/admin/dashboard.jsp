<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="dashboard-welcome">
    <p>Chào mừng trở lại! Đây là tổng quan hệ thống hôm nay.</p>
</div>

<div class="stats-grid">
    <div class="dashboard-card">
        <div class="card-icon-wrapper icon-emerald">
            <i class="fa-regular fa-user"></i>
        </div>
        <div class="card-content">
            <span class="card-label">Tổng người dùng</span>
            <span class="card-value"><fmt:formatNumber type="number" groupingUsed="true" value="${totalUsers}" /></span>
            <span class="card-trend ${userGrowth >= 0 ? 'trend-up' : 'trend-down'}">
                <i class="fa-solid ${userGrowth >= 0 ? 'fa-angle-up' : 'fa-angle-down'}"></i> 
                ${userGrowth >= 0 ? '+' : ''}<fmt:formatNumber value="${userGrowth}" maxFractionDigits="1" />% so với tháng trước
            </span>
        </div>
    </div>
    <div class="dashboard-card">
        <div class="card-icon-wrapper icon-amber">
            <i class="fa-solid fa-bag-shopping"></i>
        </div>
        <div class="card-content">
            <span class="card-label">Tổng đơn hàng</span>
            <span class="card-value"><fmt:formatNumber type="number" groupingUsed="true" value="${totalOrders}" /></span>
            <span class="card-trend ${orderGrowth >= 0 ? 'trend-up' : 'trend-down'}">
                <i class="fa-solid ${orderGrowth >= 0 ? 'fa-angle-up' : 'fa-angle-down'}"></i> 
                ${orderGrowth >= 0 ? '+' : ''}<fmt:formatNumber value="${orderGrowth}" maxFractionDigits="1" />% so với tháng trước
            </span>
        </div>
    </div>
    <div class="dashboard-card">
        <div class="card-icon-wrapper icon-emerald">
            <i class="fa-solid fa-dollar-sign"></i>
        </div>
        <div class="card-content">
            <span class="card-label">Doanh thu</span>
            <span class="card-value">
                <c:choose>
                    <c:when test="${totalRevenue >= 1000000}">
                        <fmt:formatNumber type="number" groupingUsed="true" maxFractionDigits="1" value="${totalRevenue / 1000000}" />Mđ
                    </c:when>
                    <c:otherwise>
                        <fmt:formatNumber type="number" groupingUsed="true" value="${totalRevenue}" />đ
                    </c:otherwise>
                </c:choose>
            </span>
            <span class="card-trend ${revenueGrowth >= 0 ? 'trend-up' : 'trend-down'}">
                <i class="fa-solid ${revenueGrowth >= 0 ? 'fa-angle-up' : 'fa-angle-down'}"></i> 
                ${revenueGrowth >= 0 ? '+' : ''}<fmt:formatNumber value="${revenueGrowth}" maxFractionDigits="1" />% so với tháng trước
            </span>
        </div>
    </div>
    <div class="dashboard-card">
        <div class="card-icon-wrapper icon-red">
            <i class="fa-solid fa-store"></i>
        </div>
        <div class="card-content">
            <span class="card-label">Sản phẩm</span>
            <span class="card-value"><fmt:formatNumber type="number" groupingUsed="true" value="${totalProducts}" /></span>
            <span class="card-trend trend-down">
                ${lowStockProducts} sản phẩm sắp hết hàng
            </span>
        </div>
    </div>
</div>

<div class="stats-grid">
    <div class="dashboard-card dashboard-card-sm">
        <div class="card-icon-wrapper icon-blue">
            <i class="fa-regular fa-clock"></i>
        </div>
        <div class="card-content">
            <span class="card-label">Đơn hôm nay</span>
            <span class="card-value"><fmt:formatNumber type="number" groupingUsed="true" value="${todayOrders}" /></span>
        </div>
    </div>
    <div class="dashboard-card dashboard-card-sm">
        <div class="card-icon-wrapper icon-emerald">
            <i class="fa-solid fa-wallet"></i>
        </div>
        <div class="card-content">
            <span class="card-label">Doanh thu hôm nay</span>
            <span class="card-value">
                <c:choose>
                    <c:when test="${todayRevenue >= 1000000}">
                        <fmt:formatNumber type="number" groupingUsed="true" maxFractionDigits="1" value="${todayRevenue / 1000000}" />Mđ
                    </c:when>
                    <c:otherwise>
                        <fmt:formatNumber type="number" groupingUsed="true" value="${todayRevenue}" />đ
                    </c:otherwise>
                </c:choose>
            </span>
        </div>
    </div>
    <div class="dashboard-card dashboard-card-sm">
        <div class="card-icon-wrapper icon-amber">
            <i class="fa-solid fa-rotate"></i>
        </div>
        <div class="card-content">
            <span class="card-label">Đơn chờ xử lý</span>
            <span class="card-value"><fmt:formatNumber type="number" groupingUsed="true" value="${pendingOrders}" /></span>
        </div>
    </div>
    <div class="dashboard-card dashboard-card-sm">
        <div class="card-icon-wrapper icon-red">
            <i class="fa-solid fa-circle-exclamation"></i>
        </div>
        <div class="card-content">
            <span class="card-label">Sắp hết hàng</span>
            <span class="card-value"><fmt:formatNumber type="number" groupingUsed="true" value="${lowStockProducts}" /></span>
        </div>
    </div>
</div>

<div class="dashboard-section-row">
    <div class="section-card">
        <div class="section-header">
            <div class="section-title">
                <h3>Doanh thu theo tháng</h3>
                <span>Năm 2026</span>
            </div>
            <div class="card-trend trend-up">
                <i class="fa-solid fa-square" style="color:#10b981"></i> Doanh thu
            </div>
        </div>
        <div class="chart-container">
            <div class="chart-bar-wrapper">
                <div class="chart-bar" style="height: 35%;"></div>
                <span class="chart-label">T1</span>
            </div>
            <div class="chart-bar-wrapper">
                <div class="chart-bar" style="height: 45%;"></div>
                <span class="chart-label">T2</span>
            </div>
            <div class="chart-bar-wrapper">
                <div class="chart-bar" style="height: 40%;"></div>
                <span class="chart-label">T3</span>
            </div>
            <div class="chart-bar-wrapper">
                <div class="chart-bar" style="height: 55%;"></div>
                <span class="chart-label">T4</span>
            </div>
            <div class="chart-bar-wrapper">
                <div class="chart-bar" style="height: 50%;"></div>
                <span class="chart-label">T5</span>
            </div>
            <div class="chart-bar-wrapper">
                <div class="chart-bar" style="height: 60%;"></div>
                <span class="chart-label">T6</span>
            </div>
            <div class="chart-bar-wrapper">
                <div class="chart-bar" style="height: 58%;"></div>
                <span class="chart-label">T7</span>
            </div>
            <div class="chart-bar-wrapper">
                <div class="chart-bar" style="height: 52%;"></div>
                <span class="chart-label">T8</span>
            </div>
            <div class="chart-bar-wrapper">
                <div class="chart-bar" style="height: 65%;"></div>
                <span class="chart-label">T9</span>
            </div>
            <div class="chart-bar-wrapper">
                <div class="chart-bar" style="height: 70%;"></div>
                <span class="chart-label">T10</span>
            </div>
            <div class="chart-bar-wrapper">
                <div class="chart-bar" style="height: 62%;"></div>
                <span class="chart-label">T11</span>
            </div>
            <div class="chart-bar-wrapper">
                <div class="chart-bar" style="height: 78%;"></div>
                <span class="chart-label">T12</span>
            </div>
        </div>
    </div>
    
    <div class="section-card">
        <div class="section-header">
            <div class="section-title">
                <h3>Sản phẩm bán chạy</h3>
            </div>
        </div>
        <div class="top-products-list">
            <c:choose>
                <c:when test="${not empty topSellingItems}">
                    <c:forEach var="item" items="${topSellingItems}">
                        <div class="product-item">
                            <div class="product-info-row">
                                <span class="product-name">${item.name}</span>
                                <span class="product-sales"><fmt:formatNumber type="number" groupingUsed="true" value="${item.total_sold}" /> đã bán</span>
                            </div>
                            <div class="progress-bar">
                                <div class="progress-fill" style="width: ${(item.total_sold * 100.0) / maxSold}%"></div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="no-data-msg" style="text-align: center; color: var(--text-muted); padding: 20px 0;">
                        Chưa có dữ liệu sản phẩm bán chạy
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<div class="dashboard-section-row">
    <div class="section-card">
        <div class="section-header">
            <div class="section-title">
                <h3>Đơn hàng gần đây</h3>
            </div>
            <a href="${pageContext.request.contextPath}/orders-admin" class="btn-view-all">Xem tất cả</a>
        </div>
        <c:choose>
            <c:when test="${not empty recentOrders}">
                <table class="recent-orders-table">
                    <thead>
                        <tr>
                            <th>Mã đơn</th>
                            <th>Khách hàng</th>
                            <th>Tổng tiền</th>
                            <th>Trạng thái</th>
                            <th>Ngày đặt</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="order" items="${recentOrders}">
                            <tr>
                                <td><a href="#" class="order-id">#${order.id}</a></td>
                                <td>${order.user_name}</td>
                                <td><fmt:formatNumber type="number" groupingUsed="true" value="${order.total_price}" />đ</td>
                                <td>
                                    <span class="badge ${order.status == 'Hoàn thành' ? 'badge-done' : 
                                                       (order.status == 'Đang xử lý' ? 'badge-processing' : 
                                                       (order.status == 'Chờ duyệt' ? 'badge-pending' : 'badge-cancelled'))}">
                                        ${order.status}
                                    </span>
                                </td>
                                <td><fmt:formatDate value="${order.created_at_as_date}" pattern="dd/MM/yyyy" /></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:when>
            <c:otherwise>
                <div class="no-data-msg" style="text-align: center; color: var(--text-muted); padding: 40px 0;">
                    Hiện tại chưa có đơn hàng nào
                </div>
            </c:otherwise>
        </c:choose>
    </div>
    
    <div class="section-card">
        <div class="section-header">
            <div class="section-title">
                <h3>Tỷ lệ đơn hàng</h3>
            </div>
        </div>
        <div class="order-distribution">
            <div class="status-item">
                <div class="status-indicator indicator-done"></div>
                <div class="status-info">
                    <div class="status-label-group">
                        <span class="status-name">Hoàn thành</span>
                        <span class="status-percent"><fmt:formatNumber value="${percentCompleted}" maxFractionDigits="0" />%</span>
                    </div>
                    <div class="progress-bar">
                        <div class="progress-fill" style="width: ${percentCompleted}%"></div>
                    </div>
                </div>
            </div>
            <div class="status-item">
                <div class="status-indicator indicator-processing"></div>
                <div class="status-info">
                    <div class="status-label-group">
                        <span class="status-name">Đang xử lý</span>
                        <span class="status-percent"><fmt:formatNumber value="${percentProcessing}" maxFractionDigits="0" />%</span>
                    </div>
                    <div class="progress-bar">
                        <div class="progress-fill" style="width: ${percentProcessing}%; background-color: #f59e0b;"></div>
                    </div>
                </div>
            </div>
            <div class="status-item">
                <div class="status-indicator indicator-pending"></div>
                <div class="status-info">
                    <div class="status-label-group">
                        <span class="status-name">Chờ duyệt</span>
                        <span class="status-percent"><fmt:formatNumber value="${percentPending}" maxFractionDigits="0" />%</span>
                    </div>
                    <div class="progress-bar">
                        <div class="progress-fill" style="width: ${percentPending}%; background-color: #64748b;"></div>
                    </div>
                </div>
            </div>
            <div class="status-item">
                <div class="status-indicator indicator-cancelled"></div>
                <div class="status-info">
                    <div class="status-label-group">
                        <span class="status-name">Đã huỷ</span>
                        <span class="status-percent"><fmt:formatNumber value="${percentCancelled}" maxFractionDigits="0" />%</span>
                    </div>
                    <div class="progress-bar">
                        <div class="progress-fill" style="width: ${percentCancelled}%; background-color: #ef4444;"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
