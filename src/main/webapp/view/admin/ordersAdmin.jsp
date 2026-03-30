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
            <div class="search-box">
                <i class="fa-solid fa-magnifying-glass"></i>
                <input type="text" placeholder="Tìm mã đơn, tên khách...">
            </div>
            <div class="filter-tabs">
                <button class="filter-tab active">Tất cả</button>
                <button class="filter-tab">Chờ duyệt</button>
                <button class="filter-tab">Đang xử lý</button>
                <button class="filter-tab">Hoàn thành</button>
                <button class="filter-tab">Đã huỷ</button>
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
                            <tr>
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
                                <td>
                                    <c:choose>
                                        <c:when test="${order.status == 'pending'}">
                                            <span class="badge badge-pending">Chờ duyệt</span>
                                        </c:when>
                                        <c:when test="${order.status == 'delivery'}">
                                            <span class="badge badge-delivery">Đang xử lý</span>
                                        </c:when>
                                        <c:when test="${order.status == 'finished'}">
                                            <span class="badge badge-finished">Hoàn thành</span>
                                        </c:when>
                                        <c:when test="${order.status == 'cancelled'}">
                                            <span class="badge badge-cancelled">Đã huỷ</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge">${order.status}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>${fn:substring(order.created_at, 0, 10)}</td>
                                <td>
                                    <div class="actions">
                                        <button class="btn-action view" title="Xem chi tiết"><i class="fa-regular fa-eye"></i></button>
                                        
                                        <c:choose>
                                            <c:when test="${order.status == 'pending'}">
                                                <button class="btn-pill btn-approve"><i class="fa-solid fa-check"></i> Duyệt đơn</button>
                                                <button class="btn-pill btn-cancel"><i class="fa-solid fa-xmark"></i> Huỷ đơn</button>
                                            </c:when>
                                            <c:when test="${order.status == 'delivery'}">
                                                <button class="btn-pill btn-finish"><i class="fa-regular fa-circle-check"></i> Hoàn thành</button>
                                                <button class="btn-pill btn-cancel"><i class="fa-solid fa-xmark"></i> Huỷ đơn</button>
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
            <div class="pagination-controls">
                <c:choose>
                    <c:when test="${currentPage > 1}">
                        <a href="?page=${currentPage - 1}" class="page-btn"><i class="fa-solid fa-angle-left"></i></a>
                    </c:when>
                    <c:otherwise>
                        <button class="page-btn disabled" disabled><i class="fa-solid fa-angle-left"></i></button>
                    </c:otherwise>
                </c:choose>
                
                <c:forEach begin="1" end="${totalPages}" var="i">
                    <a href="?page=${i}" class="page-btn ${currentPage == i ? 'active' : ''}">${i}</a>
                </c:forEach>
                
                <c:choose>
                    <c:when test="${currentPage < totalPages}">
                        <a href="?page=${currentPage + 1}" class="page-btn"><i class="fa-solid fa-angle-right"></i></a>
                    </c:when>
                    <c:otherwise>
                        <button class="page-btn disabled" disabled><i class="fa-solid fa-angle-right"></i></button>
                    </c:otherwise>
                </c:choose>
            </div>
        </c:if>
    </div>
</div>
