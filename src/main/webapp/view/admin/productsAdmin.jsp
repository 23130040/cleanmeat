<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="products-admin-wrapper">
    <div class="products-admin-header">
        <div class="filter-group">
            <div class="search-box">
                <i class="fa-solid fa-magnifying-glass"></i>
                <input type="text" placeholder="Tìm sản phẩm...">
            </div>
            <select class="filter-select">
                <option value="all">Tất cả danh mục</option>
                <option value="beef">Thịt bò</option>
                <option value="pork">Thịt lợn</option>
                <option value="chicken">Thịt gà</option>
                <option value="seafood">Hải sản</option>
            </select>
        </div>
        <button class="btn-add-product">
            <i class="fa-solid fa-plus"></i> Thêm sản phẩm
        </button>
    </div>

    <div class="table-container">
        <table class="admin-table">
            <thead>
                <tr>
                    <th>Sản phẩm</th>
                    <th>Danh mục</th>
                    <th>Xuất xứ</th>
                    <th>Giá</th>
                    <th>Giảm giá</th>
                    <th>Tồn kho</th>
                    <th>Thao tác</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty items}">
                        <c:forEach var="item" items="${items}">
                            <tr>
                                <td>
                                    <div class="product-cell">
                                        <div class="product-img">
                                            <c:choose>
                                                <c:when test="${not empty item.image}">
                                                    <img src="${pageContext.request.contextPath}${item.image}" alt="${item.name}">
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="img-placeholder"><i class="fa-solid fa-image"></i></div>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div class="product-info-col">
                                            <span class="product-name-bold">${item.name}</span>
                                            <span class="product-unit-text">Đơn vị: ${item.unit_name}</span>
                                        </div>
                                    </div>
                                </td>
                                <td>${item.category_name}</td>
                                <td>${item.origin_name != null ? item.origin_name : 'N/A'}</td>
                                <td>
                                    <span class="product-price"><fmt:formatNumber value="${item.price}" type="number" groupingUsed="true"/>đ</span>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${item.discount > 0}">
                                            <span class="badge badge-discount">-<fmt:formatNumber value="${item.discount}" type="number"/>%</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-muted">—</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <div class="stock-cell">
                                        <span class="stock-current">${item.current_stock}</span>
                                        <span class="stock-min">Tối thiểu: ${item.min_stock}</span>
                                    </div>
                                </td>
                                <td>
                                    <div class="actions">
                                        <button class="btn-action view" title="Xem chi tiết"><i class="fa-regular fa-eye"></i></button>
                                        <button class="btn-action edit" title="Chỉnh sửa"><i class="fa-solid fa-pen-to-square"></i></button>
                                        <button class="btn-action delete" title="Xóa"><i class="fa-regular fa-trash-can"></i></button>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="7" class="text-center">Không có sản phẩm nào.</td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>

    <div class="pagination-container">
        <span class="pagination-info">
            Hiển thị ${totalItems > 0 ? offset + 1 : 0}-${offset + fn:length(items)} / ${totalItems}
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
