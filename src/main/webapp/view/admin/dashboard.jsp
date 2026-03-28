<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
            <span class="card-value">1,284</span>
            <span class="card-trend trend-up">
                <i class="fa-solid fa-angle-up"></i> +12% so với tháng trước
            </span>
        </div>
    </div>
    <div class="dashboard-card">
        <div class="card-icon-wrapper icon-amber">
            <i class="fa-solid fa-bag-shopping"></i>
        </div>
        <div class="card-content">
            <span class="card-label">Tổng đơn hàng</span>
            <span class="card-value">3,472</span>
            <span class="card-trend trend-up">
                <i class="fa-solid fa-angle-up"></i> +8% so với tháng trước
            </span>
        </div>
    </div>
    <div class="dashboard-card">
        <div class="card-icon-wrapper icon-emerald">
            <i class="fa-solid fa-dollar-sign"></i>
        </div>
        <div class="card-content">
            <span class="card-label">Doanh thu</span>
            <span class="card-value">847.6Mđ</span>
            <span class="card-trend trend-up">
                <i class="fa-solid fa-angle-up"></i> +15% so với tháng trước
            </span>
        </div>
    </div>
    <div class="dashboard-card">
        <div class="card-icon-wrapper icon-red">
            <i class="fa-solid fa-store"></i>
        </div>
        <div class="card-content">
            <span class="card-label">Sản phẩm</span>
            <span class="card-value">86</span>
            <span class="card-trend trend-down">
                8 sản phẩm sắp hết hàng
            </span>
        </div>
    </div>
</div>

<!-- Secondary Stats Grid -->
<div class="stats-grid">
    <div class="dashboard-card dashboard-card-sm">
        <div class="card-icon-wrapper icon-blue">
            <i class="fa-regular fa-clock"></i>
        </div>
        <div class="card-content">
            <span class="card-label">Đơn hôm nay</span>
            <span class="card-value">24</span>
        </div>
    </div>
    <div class="dashboard-card dashboard-card-sm">
        <div class="card-icon-wrapper icon-emerald">
            <i class="fa-solid fa-wallet"></i>
        </div>
        <div class="card-content">
            <span class="card-label">Doanh thu hôm nay</span>
            <span class="card-value">12.5Mđ</span>
        </div>
    </div>
    <div class="dashboard-card dashboard-card-sm">
        <div class="card-icon-wrapper icon-amber">
            <i class="fa-solid fa-rotate"></i>
        </div>
        <div class="card-content">
            <span class="card-label">Đơn chờ xử lý</span>
            <span class="card-value">47</span>
        </div>
    </div>
    <div class="dashboard-card dashboard-card-sm">
        <div class="card-icon-wrapper icon-red">
            <i class="fa-solid fa-circle-exclamation"></i>
        </div>
        <div class="card-content">
            <span class="card-label">Sắp hết hàng</span>
            <span class="card-value">8</span>
        </div>
    </div>
</div>

<!-- Revenue and Top Products Row -->
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
            <div class="product-item">
                <div class="product-info-row">
                    <span class="product-name">Thịt bò Wagyu Úc</span>
                    <span class="product-sales">342 đã bán</span>
                </div>
                <div class="progress-bar">
                    <div class="progress-fill" style="width: 85%"></div>
                </div>
            </div>
            <div class="product-item">
                <div class="product-info-row">
                    <span class="product-name">Ức gà hữu cơ</span>
                    <span class="product-sales">518 đã bán</span>
                </div>
                <div class="progress-bar">
                    <div class="progress-fill" style="width: 95%"></div>
                </div>
            </div>
            <div class="product-item">
                <div class="product-info-row">
                    <span class="product-name">Thịt lợn rừng</span>
                    <span class="product-sales">284 đã bán</span>
                </div>
                <div class="progress-bar">
                    <div class="progress-fill" style="width: 70%"></div>
                </div>
            </div>
            <div class="product-item">
                <div class="product-info-row">
                    <span class="product-name">Cá hồi Na Uy</span>
                    <span class="product-sales">196 đã bán</span>
                </div>
                <div class="progress-bar">
                    <div class="progress-fill" style="width: 55%"></div>
                </div>
            </div>
            <div class="product-item">
                <div class="product-info-row">
                    <span class="product-name">Thịt bê non Nhật</span>
                    <span class="product-sales">147 đã bán</span>
                </div>
                <div class="progress-bar">
                    <div class="progress-fill" style="width: 40%"></div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Recent Orders and Order Distribution Row -->
<div class="dashboard-section-row">
    <div class="section-card">
        <div class="section-header">
            <div class="section-title">
                <h3>Đơn hàng gần đây</h3>
            </div>
            <a href="#" class="btn-view-all">Xem tất cả</a>
        </div>
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
                <tr>
                    <td><a href="#" class="order-id">ORD-0472</a></td>
                    <td>Nguyễn Văn An</td>
                    <td>485.000đ</td>
                    <td><span class="badge badge-done">Hoàn thành</span></td>
                    <td>2026-03-27</td>
                </tr>
                <tr>
                    <td><a href="#" class="order-id">ORD-0471</a></td>
                    <td>Trần Thị Bình</td>
                    <td>1.250.000đ</td>
                    <td><span class="badge badge-processing">Đang xử lý</span></td>
                    <td>2026-03-27</td>
                </tr>
                <tr>
                    <td><a href="#" class="order-id">ORD-0470</a></td>
                    <td>Lê Hoàng Nam</td>
                    <td>320.000đ</td>
                    <td><span class="badge badge-pending">Chờ duyệt</span></td>
                    <td>2026-03-26</td>
                </tr>
                <tr>
                    <td><a href="#" class="order-id">ORD-0469</a></td>
                    <td>Phạm Thị Lan</td>
                    <td>780.000đ</td>
                    <td><span class="badge badge-done">Hoàn thành</span></td>
                    <td>2026-03-26</td>
                </tr>
                <tr>
                    <td><a href="#" class="order-id">ORD-0468</a></td>
                    <td>Hoàng Minh Tú</td>
                    <td>560.000đ</td>
                    <td><span class="badge badge-cancelled">Đã huỷ</span></td>
                    <td>2026-03-25</td>
                </tr>
                <tr>
                    <td><a href="#" class="order-id">ORD-0467</a></td>
                    <td>Võ Thị Hoa</td>
                    <td>990.000đ</td>
                    <td><span class="badge badge-done">Hoàn thành</span></td>
                    <td>2026-03-25</td>
                </tr>
            </tbody>
        </table>
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
                        <span class="status-percent">68%</span>
                    </div>
                    <div class="progress-bar">
                        <div class="progress-fill" style="width: 68%"></div>
                    </div>
                </div>
            </div>
            <div class="status-item">
                <div class="status-indicator indicator-processing"></div>
                <div class="status-info">
                    <div class="status-label-group">
                        <span class="status-name">Đang xử lý</span>
                        <span class="status-percent">18%</span>
                    </div>
                    <div class="progress-bar">
                        <div class="progress-fill" style="width: 18%; background-color: #f59e0b;"></div>
                    </div>
                </div>
            </div>
            <div class="status-item">
                <div class="status-indicator indicator-pending"></div>
                <div class="status-info">
                    <div class="status-label-group">
                        <span class="status-name">Chờ duyệt</span>
                        <span class="status-percent">9%</span>
                    </div>
                    <div class="progress-bar">
                        <div class="progress-fill" style="width: 9%; background-color: #64748b;"></div>
                    </div>
                </div>
            </div>
            <div class="status-item">
                <div class="status-indicator indicator-cancelled"></div>
                <div class="status-info">
                    <div class="status-label-group">
                        <span class="status-name">Đã huỷ</span>
                        <span class="status-percent">5%</span>
                    </div>
                    <div class="progress-bar">
                        <div class="progress-fill" style="width: 5%; background-color: #ef4444;"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
