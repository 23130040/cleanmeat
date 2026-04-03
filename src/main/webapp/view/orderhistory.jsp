<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="order-history-container">
    <div class="container">
        <div class="history-header">
            <h1 class="page-title">Lịch sử đơn hàng</h1>
            <p class="page-subtitle">Quản lý và theo dõi hành trình các đơn hàng của bạn</p>
            
            <div class="stats-grid">
                <div class="stat-item">
                    <div class="stat-icon total"><i class="fa-solid fa-box"></i></div>
                    <div class="stat-info">
                        <span class="stat-value">${fn:length(orders)}</span>
                        <span class="stat-label">Tổng đơn</span>
                    </div>
                </div>
                <div class="stat-item">
                    <div class="stat-icon shipping"><i class="fa-solid fa-truck-fast"></i></div>
                    <div class="stat-info">
                        <span class="stat-value">${fn:length(deliveringOrders)}</span>
                        <span class="stat-label">Đang giao</span>
                    </div>
                </div>
                <div class="stat-item">
                    <div class="stat-icon completed"><i class="fa-solid fa-check-double"></i></div>
                    <div class="stat-info">
                        <span class="stat-value">${fn:length(finishedOrders)}</span>
                        <span class="stat-label">Hoàn thành</span>
                    </div>
                </div>
            </div>
        </div>

        <div class="order-filters">
            <div class="filter-tabs">
                <button class="filter-tab active" data-status="all">Tất cả</button>
                <button class="filter-tab" data-status="pending">Chờ xác nhận</button>
                <button class="filter-tab" data-status="processing">Đang xử lý</button>
                <button class="filter-tab" data-status="delivery">Đang giao</button>
                <button class="filter-tab" data-status="finished">Hoàn thành</button>
                <button class="filter-tab" data-status="cancled">Đã hủy</button>
            </div>
        </div>

        <div class="order-cards-list">
            <c:choose>
                <c:when test="${not empty orders}">
                    <c:forEach var="order" items="${orders}">
                        <c:set var="statusKey" value="all" />
                        <c:choose>
                            <c:when test="${order.status eq 'pending' || order.status eq 'Chờ xác nhận'}"><c:set var="statusKey" value="pending" /></c:when>
                            <c:when test="${order.status eq 'in progress' || order.status eq 'processing' || order.status eq 'Đang xử lý'}"><c:set var="statusKey" value="processing" /></c:when>
                            <c:when test="${order.status eq 'delivery' || order.status eq 'Đang giao hàng'}"><c:set var="statusKey" value="delivery" /></c:when>
                            <c:when test="${order.status eq 'finished' || order.status eq 'Hoàn thành'}"><c:set var="statusKey" value="finished" /></c:when>
                            <c:when test="${order.status eq 'cancled' || order.status eq 'Đã hủy'}"><c:set var="statusKey" value="cancled" /></c:when>
                        </c:choose>
                        
                        <div class="order-card" data-order-status="${statusKey}">
                            <div class="card-header">
                                <div class="order-main-info">
                                    <span class="order-id">Mã đơn: <strong>${order.shortOrderID}</strong></span>
                                    <span class="order-dot"></span>
                                    <span class="order-time">
                                        <fmt:parseDate value="${order.created_at}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDate" type="both" />
                                        <fmt:formatDate value="${parsedDate}" pattern="dd/MM/yyyy HH:mm" />
                                    </span>
                                </div>
                                <div class="order-status-badge status-${fn:toLowerCase(fn:replace(statusKey, ' ', '-'))}">
                                    <c:choose>
                                        <c:when test="${statusKey eq 'pending'}">Chờ xác nhận</c:when>
                                        <c:when test="${statusKey eq 'processing'}">Đang xử lý</c:when>
                                        <c:when test="${statusKey eq 'delivery'}">Đang giao hàng</c:when>
                                        <c:when test="${statusKey eq 'finished'}">Hoàn thành</c:when>
                                        <c:when test="${statusKey eq 'cancled'}">Đã hủy</c:when>
                                        <c:otherwise>${order.status}</c:otherwise>
                                    </c:choose>
                                </div>
                            </div>

                            <!-- Horizontal Status Stepper -->
                            <c:if test="${statusKey ne 'cancled'}">
                                <div class="order-stepper">
                                    <div class="step ${statusKey eq 'pending' ? 'active' : 'completed'}">
                                        <div class="step-circle"><i class="fa-solid fa-clipboard-list"></i></div>
                                        <span class="step-text">Chờ xác nhận</span>
                                    </div>
                                    <div class="step-line ${statusKey ne 'pending' ? 'completed' : ''}"></div>
                                    
                                    <div class="step ${statusKey eq 'processing' ? 'active' : (statusKey eq 'delivery' || statusKey eq 'finished' ? 'completed' : '')}">
                                        <div class="step-circle"><i class="fa-solid fa-box-open"></i></div>
                                        <span class="step-text">Đang xử lý</span>
                                    </div>
                                    <div class="step-line ${statusKey eq 'delivery' || statusKey eq 'finished' ? 'completed' : ''}"></div>
                                    
                                    <div class="step ${statusKey eq 'delivery' ? 'active' : (statusKey eq 'finished' ? 'completed' : '')}">
                                        <div class="step-circle"><i class="fa-solid fa-truck"></i></div>
                                        <span class="step-text">Đang giao</span>
                                    </div>
                                    <div class="step-line ${statusKey eq 'finished' ? 'completed' : ''}"></div>
                                    
                                    <div class="step ${statusKey eq 'finished' ? 'active' : ''}">
                                        <div class="step-circle"><i class="fa-solid fa-house-chimney-check"></i></div>
                                        <span class="step-text">Hoàn thành</span>
                                    </div>
                                </div>
                            </c:if>

                            <div class="card-items">
                                <c:forEach var="item" items="${order.items}">
                                    <div class="item-row">
                                        <div class="item-img">
                                            <c:choose>
                                                <c:when test="${item.itemImage.startsWith('http')}">
                                                    <img src="${item.itemImage}" alt="${item.itemName}" onerror="this.src='${pageContext.request.contextPath}/images/placeholder.png'">
                                                </c:when>
                                                <c:when test="${item.itemImage.startsWith('/')}">
                                                    <img src="${pageContext.request.contextPath}${item.itemImage}" alt="${item.itemName}" onerror="this.src='${pageContext.request.contextPath}/images/placeholder.png'">
                                                </c:when>
                                                <c:otherwise>
                                                    <img src="${pageContext.request.contextPath}/images/${item.itemImage}" alt="${item.itemName}" onerror="this.src='${pageContext.request.contextPath}/images/placeholder.png'">
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div class="item-details">
                                            <h4 class="item-name">${item.itemName}</h4>
                                            <div class="item-meta">
                                                <span class="item-weight">${item.weight}g</span>
                                                <span class="item-qty">x ${item.quantity}</span>
                                                <span class="item-unit">${item.unitName}</span>
                                            </div>
                                        </div>
                                        <div class="item-price">
                                            <fmt:formatNumber value="${item.price}" type="currency" currencySymbol="đ" maxFractionDigits="0" />
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>

                            <div class="card-footer">
                                <div class="order-total-group">
                                    <span class="total-label">Tổng cộng:</span>
                                    <span class="total-amount"><fmt:formatNumber value="${order.total_price}" type="currency" currencySymbol="đ" maxFractionDigits="0" /></span>
                                </div>
                                <div class="order-actions">
                                    <a href="${pageContext.request.contextPath}/order-details?id=${order.id}" class="btn-outline">Chi tiết</a>
                                    <c:if test="${statusKey eq 'finished'}">
                                        <button class="btn-primary reorder-btn">Mua lại</button>
                                    </c:if>
                                    <c:if test="${statusKey eq 'pending'}">
                                        <button class="btn-danger cancel-order-btn" data-id="${order.id}">Hủy đơn</button>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                    <div id="emptyFilterResult" class="empty-state" style="display: none; padding: 60px 0;">
                        <img src="${pageContext.request.contextPath}/images/empty-orders.svg" alt="No orders" style="width: 180px; margin-bottom: 20px;">
                        <h3 style="font-size: 1.4rem;">Không tìm thấy đơn hàng nào</h3>
                        <p>Trạng thái này hiện chưa có đơn hàng nào.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <img src="${pageContext.request.contextPath}/images/empty-orders.svg" alt="No orders">
                        <h3>Bạn chưa có đơn hàng nào</h3>
                        <p>Hãy khám phá các sản phẩm tươi ngon từ Clean Meat nhé!</p>
                        <a href="${pageContext.request.contextPath}/product" class="btn-primary">Mua sắm ngay</a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const tabs = document.querySelectorAll('.filter-tab');
        const cards = document.querySelectorAll('.order-card');
        const emptyMsg = document.getElementById('emptyFilterResult');

        tabs.forEach(tab => {
            tab.addEventListener('click', function() {
                const status = this.dataset.status;
                
                tabs.forEach(t => t.classList.remove('active'));
                this.classList.add('active');

                let visibleCount = 0;
                cards.forEach(card => {
                    const cardStatus = card.dataset.orderStatus;
                    if (status === 'all' || cardStatus === status) {
                        card.style.display = 'block';
                        visibleCount++;
                    } else {
                        card.style.display = 'none';
                    }
                });

                if (visibleCount === 0) {
                    emptyMsg.style.display = 'block';
                } else {
                    emptyMsg.style.display = 'none';
                }
            });
        });
    });
</script>
