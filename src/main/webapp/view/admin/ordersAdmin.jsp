<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="orders-admin-wrapper">

    <div class="stat-cards-container">
        <div class="stat-card">
            <div class="stat-icon icon-pending"><i class="fa-regular fa-clock"></i></div>
            <div class="stat-info">
                <span class="stat-title">Chờ duyệt</span>
                <span class="stat-number">${countPending}</span>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon icon-delivery"><i class="fa-solid fa-rotate-right"></i></div>
            <div class="stat-info">
                <span class="stat-title">Đang xử lý</span>
                <span class="stat-number">${countDelivery}</span>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon icon-finished"><i class="fa-regular fa-circle-check"></i></div>
            <div class="stat-info">
                <span class="stat-title">Hoàn thành</span>
                <span class="stat-number">${countFinished}</span>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon icon-cancelled"><i class="fa-regular fa-circle-xmark"></i></div>
            <div class="stat-info">
                <span class="stat-title">Đã huỷ</span>
                <span class="stat-number">${countCancelled}</span>
            </div>
        </div>
    </div>

    <div class="orders-filter-row">
        <div class="filter-left">
            <form action="${pageContext.request.contextPath}/orders-admin" method="get" class="search-box" id="searchForm">
                <i class="fa-solid fa-magnifying-glass" onclick="document.getElementById('searchForm').submit()" style="cursor:pointer"></i>
                <input type="text" name="search" placeholder="Tìm mã đơn, tên khách..." value="${currentSearch}">
                <c:if test="${not empty currentStatus}">
                    <input type="hidden" name="status" value="${currentStatus}">
                </c:if>
            </form>
            <div class="filter-tabs">
                <a href="?status=" class="filter-tab ${empty currentStatus ? 'active' : ''}">Tất cả</a>
                <a href="?status=pending&search=${currentSearch}" class="filter-tab ${currentStatus == 'pending' ? 'active' : ''}">Chờ duyệt</a>
                <a href="?status=processing&search=${currentSearch}" class="filter-tab ${currentStatus == 'processing' ? 'active' : ''}">Đang xử lý</a>
                <a href="?status=finished&search=${currentSearch}" class="filter-tab ${currentStatus == 'finished' ? 'active' : ''}">Hoàn thành</a>
                <a href="?status=cancelled&search=${currentSearch}" class="filter-tab ${currentStatus == 'cancelled' ? 'active' : ''}">Đã huỷ</a>
            </div>
        </div>
        <div class="filter-right">
            <i class="fa-solid fa-box-open"></i> ${totalItems} đơn hàng
        </div>
    </div>

    <div class="table-container">
        <table class="admin-table">
            <thead>
                <tr>
                    <th>Mã đơn</th>
                    <th>Khách hàng</th>
                    <th>Tổng tiền</th>
                    <th>Thanh toán</th>
                    <th>Vận chuyển</th>
                    <th>Trạng thái</th>
                    <th>Ngày đặt</th>
                    <th>Thao tác</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty orders}">
                        <c:forEach var="order" items="${orders}">
                            <tr id="order-row-${order.id}">
                                <td>
                                    <span class="order-id-bold">${order.shortOrderID}</span>
                                </td>
                                <td>
                                    <div class="customer-cell">
                                        <span class="customer-name">${order.user_name != null ? order.user_name : 'Unknown User'}</span>
                                        <span class="customer-email">${order.user_email != null ? order.user_email : 'No email'}</span>
                                    </div>
                                </td>
                                <td>
                                    <span class="order-price-bold"><fmt:formatNumber value="${order.total_price}" type="number" groupingUsed="true"/>đ</span>
                                </td>
                                <td>${order.payment_method != null ? order.payment_method : 'N/A'}</td>
                                <td>${order.transport_method != null ? order.transport_method : 'N/A'}</td>
                                <td id="status-cell-${order.id}">
                                    <c:choose>
                                        <c:when test="${order.status == 'pending' || order.status == 'Chờ xác nhận'}">
                                            <span class="badge badge-pending">Chờ duyệt</span>
                                        </c:when>
                                        <c:when test="${order.status == 'delivery' || order.status == 'Đang xử lý'}">
                                            <span class="badge badge-delivery">Đang xử lý</span>
                                        </c:when>
                                        <c:when test="${order.status == 'finished' || order.status == 'Hoàn thành'}">
                                            <span class="badge badge-finished">Hoàn thành</span>
                                        </c:when>
                                        <c:when test="${order.status == 'cancelled' || order.status == 'Đã huỷ' || order.status == 'Đã hủy'}">
                                            <span class="badge badge-cancelled">Đã huỷ</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge">${order.status}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>${fn:substring(order.created_at, 0, 10)}</td>
                                <td id="actions-cell-${order.id}">
                                    <div class="actions">
                                        <button class="btn-action view" title="Xem chi tiết" onclick="viewOrder('${order.id}')"><i class="fa-regular fa-eye"></i></button>
                                        
                                        <c:choose>
                                            <c:when test="${order.status == 'pending' || order.status == 'Chờ xác nhận'}">
                                                <button class="btn-pill btn-approve" onclick="updateStatus('${order.id}', 'Đang xử lý', 'Duyệt đơn hàng')"><i class="fa-solid fa-check"></i> Duyệt đơn</button>
                                                <button class="btn-pill btn-cancel" onclick="updateStatus('${order.id}', 'Đã hủy', 'Hủy đơn hàng')"><i class="fa-solid fa-xmark"></i> Huỷ đơn</button>
                                            </c:when>
                                            <c:when test="${order.status == 'delivery' || order.status == 'Đang xử lý'}">
                                                <button class="btn-pill btn-finish" onclick="updateStatus('${order.id}', 'Hoàn thành', 'Hoàn thành đơn hàng')"><i class="fa-regular fa-circle-check"></i> Hoàn thành</button>
                                                <button class="btn-pill btn-cancel" onclick="updateStatus('${order.id}', 'Đã hủy', 'Hủy đơn hàng')"><i class="fa-solid fa-xmark"></i> Huỷ đơn</button>
                                            </c:when>
                                        </c:choose>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="8" class="text-center">Không có đơn hàng nào.</td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>

    <div class="pagination-container">
        <span class="pagination-info">
            Hiển thị ${totalItems > 0 ? offset + 1 : 0}-${offset + fn:length(orders)} / ${totalItems}
        </span>
        <c:if test="${totalPages > 1}">
            <c:set var="urlParams" value="&status=${currentStatus}&search=${currentSearch}" />
            <div class="pagination-controls">
                <c:choose>
                    <c:when test="${currentPage > 1}">
                        <a href="?page=${currentPage - 1}${urlParams}" class="page-btn"><i class="fa-solid fa-angle-left"></i></a>
                    </c:when>
                    <c:otherwise>
                        <button class="page-btn disabled" disabled><i class="fa-solid fa-angle-left"></i></button>
                    </c:otherwise>
                </c:choose>
                
                <c:forEach begin="1" end="${totalPages}" var="i">
                    <a href="?page=${i}${urlParams}" class="page-btn ${currentPage == i ? 'active' : ''}">${i}</a>
                </c:forEach>
                
                <c:choose>
                    <c:when test="${currentPage < totalPages}">
                        <a href="?page=${currentPage + 1}${urlParams}" class="page-btn"><i class="fa-solid fa-angle-right"></i></a>
                    </c:when>
                    <c:otherwise>
                        <button class="page-btn disabled" disabled><i class="fa-solid fa-angle-right"></i></button>
                    </c:otherwise>
                </c:choose>
            </div>
        </c:if>
    </div>
</div>

<!-- Order Detail Modal -->
<div class="modal-overlay" id="orderDetailModal">
    <div class="modal-container">
        <div class="modal-header">
            <h2 class="modal-title" id="modalOrderCode">Chi tiết đơn hàng</h2>
            <button class="btn-close-modal" onclick="closeModal('orderDetailModal')">
                <i class="fa-solid fa-xmark"></i>
            </button>
        </div>
        <div class="modal-body">
            <div class="info-grid">
                <div class="info-box">
                    <span class="info-label">Khách hàng</span>
                    <div class="info-value">
                        <strong id="modalCustomerName">-</strong>
                        <span id="modalCustomerEmail">-</span>
                    </div>
                </div>
                <div class="info-box">
                    <span class="info-label">Địa chỉ giao hàng</span>
                    <div class="info-value">
                        <span id="modalShippingAddress">-</span>
                    </div>
                </div>
                <div class="info-box">
                    <span class="info-label">Thanh toán</span>
                    <div class="info-value">
                        <span id="modalPaymentMethod">-</span>
                    </div>
                </div>
                <div class="info-box">
                    <span class="info-label">Vận chuyển</span>
                    <div class="info-value">
                        <span id="modalTransportMethod">-</span>
                    </div>
                </div>
            </div>

            <span class="section-label">Sản phẩm</span>
            <table class="modal-product-table">
                <thead>
                    <tr>
                        <th>Tên</th>
                        <th>Đơn giá</th>
                        <th>SL</th>
                        <th style="text-align: right;">Thành tiền</th>
                    </tr>
                </thead>
                <tbody id="modalProductList">
                    <!-- Products will be injected here -->
                </tbody>
            </table>

            <div class="order-total-summary">
                <span class="total-label-text">Tổng cộng</span>
                <span class="total-value-text" id="modalTotalValue">0đ</span>
            </div>

            <span class="section-label">Lịch sử trạng thái</span>
            <div class="timeline" id="modalTimeline">
                <!-- Timeline items will be injected here -->
            </div>
        </div>
        <div class="modal-footer" id="modalActions">
            <!-- Action buttons will be injected here -->
        </div>
    </div>
</div>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/ordersAdmin.css">
<script src="${pageContext.request.contextPath}/js/ordersAdmin.js"></script>
