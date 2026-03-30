<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="inventory-admin-wrapper">
    <div class="stat-cards-container">
        <div class="stat-card">
            <div class="stat-icon icon-import"><i class="fa-solid fa-arrow-down"></i></div>
            <div class="stat-info">
                <span class="stat-title">Tổng nhập kho</span>
                <span class="stat-number number-import">+${sumImport}</span>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon icon-export"><i class="fa-solid fa-arrow-up"></i></div>
            <div class="stat-info">
                <span class="stat-title">Tổng xuất kho</span>
                <span class="stat-number number-export">${sumExport > 0 ? '-' : ''}${sumExport}</span>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon icon-total"><i class="fa-solid fa-box-archive"></i></div>
            <div class="stat-info">
                <span class="stat-title">Tổng lượt giao dịch</span>
                <span class="stat-number">${totalItems}</span>
            </div>
        </div>
    </div>

    <div class="inventory-filter-row">
        <div class="filter-left">
            <div class="search-box">
                <i class="fa-solid fa-magnifying-glass"></i>
                <input type="text" placeholder="Tìm sản phẩm, người thực hiện...">
            </div>
            <div class="filter-tabs">
                <button class="filter-tab active">Tất cả</button>
                <button class="filter-tab">Nhập kho</button>
                <button class="filter-tab">Xuất kho</button>
            </div>
        </div>
    </div>

    <div class="table-container">
        <table class="admin-table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Sản phẩm</th>
                    <th>Loại</th>
                    <th>Số lượng</th>
                    <th>Thực hiện bởi</th>
                    <th>Thời gian</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty historyList}">
                        <c:forEach var="history" items="${historyList}">
                            <tr>
                                <td>
                                    <span class="history-id-text">#${history.id}</span>
                                </td>
                                <td>
                                    <span class="item-name-bold">${history.item_name != null ? history.item_name : 'Unknown Item'}</span>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${history.type == 'import' || history.type == 'Nhập kho'}">
                                            <span class="badge badge-import">Nhập kho</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge badge-export">Xuất kho</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${history.type == 'import' || history.type == 'Nhập kho'}">
                                            <span class="quantity-import">+${history.quantity}</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="quantity-export">-${history.quantity}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <span class="user-text">
                                        <c:choose>
                                            <c:when test="${history.created_by == 0 || empty history.user_name}">System</c:when>
                                            <c:otherwise>${history.user_name}</c:otherwise>
                                        </c:choose>
                                    </span>
                                </td>
                                <td>
                                    <span class="time-text">${fn:replace(history.created_day, 'T', ' ')}</span>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="6" class="text-center">Không có lịch sử giao dịch nào.</td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>

    <div class="pagination-container">
        <span class="pagination-info">
            Hiển thị ${totalItems > 0 ? offset + 1 : 0}-${offset + fn:length(historyList)} / ${totalItems}
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
