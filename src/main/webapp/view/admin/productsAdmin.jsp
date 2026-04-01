<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="products-admin-wrapper">
    <div class="products-admin-header">
        <form action="${pageContext.request.contextPath}/products-admin" method="get" class="filter-group">
            <div class="search-box">
                <i class="fa-solid fa-magnifying-glass"></i>
                <input type="text" name="keyword" value="${keyword}" placeholder="Tìm sản phẩm...">
            </div>
            <select name="categoryId" class="filter-select" onchange="this.form.submit()">
                <option value="0" ${selectedCategoryId == 0 ? 'selected' : ''}>Tất cả danh mục</option>
                <c:forEach var="cat" items="${categories}">
                    <option value="${cat.id}" ${selectedCategoryId == cat.id ? 'selected' : ''}>${cat.name}</option>
                </c:forEach>
            </select>
            <button type="submit" style="display: none;"></button>
        </form>
        <button class="btn-add-product" onclick="openAddProductModal()">
            <i class="fa-solid fa-plus"></i> Thêm sản phẩm
        </button>
    </div>

    <div class="table-container">
        <table class="admin-table">
            <thead>
                <tr>
                    <th>Sản phẩm</th>
                    <th>Quy cách</th>
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
                                        </div>
                                    </div>
                                </td>
                                <td>${item.packaging}${item.unit_name}</td>
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
                                        <button class="btn-action view" title="Xem chi tiết" onclick="viewProduct(${item.id})"><i class="fa-regular fa-eye"></i></button>
                                        <button class="btn-action edit" title="Chỉnh sửa" onclick="editProduct(${item.id})"><i class="fa-solid fa-pen-to-square"></i></button>
                                        <button class="btn-action delete" title="Xóa" onclick="confirmDelete(${item.id}, '${item.name}')"><i class="fa-regular fa-trash-can"></i></button>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="8" class="text-center">Không có sản phẩm nào.</td>
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
                        <a href="?page=${currentPage - 1}&categoryId=${selectedCategoryId}&keyword=${keyword}" class="page-btn"><i class="fa-solid fa-angle-left"></i></a>
                    </c:when>
                    <c:otherwise>
                        <button class="page-btn disabled" disabled><i class="fa-solid fa-angle-left"></i></button>
                    </c:otherwise>
                </c:choose>
                
                <c:forEach begin="1" end="${totalPages}" var="i">
                    <a href="?page=${i}&categoryId=${selectedCategoryId}&keyword=${keyword}" class="page-btn ${currentPage == i ? 'active' : ''}">${i}</a>
                </c:forEach>
                
                <c:choose>
                    <c:when test="${currentPage < totalPages}">
                        <a href="?page=${currentPage + 1}&categoryId=${selectedCategoryId}&keyword=${keyword}" class="page-btn"><i class="fa-solid fa-angle-right"></i></a>
                    </c:when>
                    <c:otherwise>
                        <button class="page-btn disabled" disabled><i class="fa-solid fa-angle-right"></i></button>
                    </c:otherwise>
                </c:choose>
            </div>
        </c:if>
    </div>
</div>

<div class="admin-modal-overlay" id="addProductModal">
    <div class="admin-modal-container modal-lg">
        <div class="modal-topbar">
            <h2>Thêm sản phẩm mới</h2>
            <button class="btn-close-modal" onclick="closeModal('addProductModal')"><i class="fa-solid fa-xmark"></i></button>
        </div>
        
        <form action="${pageContext.request.contextPath}/products-admin" method="post" enctype="multipart/form-data" class="modal-form">
            <input type="hidden" name="action" value="add">
            <input type="hidden" name="primaryImageIndex" id="primaryIndex" value="0">
            
            <div class="form-row">
                <div class="admin-form-group col-12">
                    <label>Hình ảnh sản phẩm *</label>
                    <div class="upload-zone" id="uploadZone">
                        <div class="upload-content">
                            <i class="fa-solid fa-cloud-arrow-up"></i>
                            <p>Nhấp để tải ảnh lên hoặc kéo thả vào đây</p>
                            <span>Hỗ trợ: JPG, PNG, WEBP (Tối đa 10 ảnh)</span>
                        </div>
                        <input type="file" name="productImages" id="productImages" multiple accept="image/*" class="hidden-input" required>
                    </div>
                    <div class="image-preview-grid" id="imagePreviewContainer"></div>
                </div>
            </div>
            
            <div class="form-row">
                <div class="admin-form-group col-12">
                    <label>Tên sản phẩm *</label>
                    <input type="text" name="name" class="admin-input-control" placeholder="VD: Thịt bò Wagyu Úc A5" required>
                </div>
            </div>

            <div class="form-row">
                <div class="admin-form-group col-12">
                    <label>Mô tả ngắn *</label>
                    <input type="text" name="short_description" class="admin-input-control" placeholder="Mô tả ngắn gọn về sản phẩm" required>
                </div>
            </div>
            
            <div class="form-row">
                <div class="admin-form-group col-12">
                    <label>Mô tả chi tiết</label>
                    <textarea name="long_description" class="admin-input-control" rows="3" placeholder="Mô tả chi tiết về nguồn gốc, chất lượng, cách bảo quản..."></textarea>
                </div>
            </div>

            <div class="form-row">
                <div class="admin-form-group col-6">
                    <label>Danh mục</label>
                    <select name="category_id" class="admin-input-control" required>
                        <c:forEach var="cat" items="${categories}">
                            <option value="${cat.id}">${cat.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="admin-form-group col-6">
                    <label>Xuất xứ</label>
                    <select name="origin_id" class="admin-input-control" required>
                        <c:forEach var="ori" items="${origins}">
                            <option value="${ori.id}">${ori.name}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>

            <div class="form-row">
                <div class="admin-form-group col-6">
                    <label>Lượng (số)</label>
                    <input type="number" name="packaging" class="admin-input-control" placeholder="VD: 200, 500, 1...">
                </div>
                <div class="admin-form-group col-6">
                    <label>Đơn vị</label>
                    <input type="text" name="unit_name" class="admin-input-control" list="unit-list" placeholder="VD: g, kg, Cái..." required>
                    <datalist id="unit-list">
                        <c:forEach var="u" items="${units}">
                            <option value="${u.name}">
                        </c:forEach>
                    </datalist>
                </div>
            </div>
            
            <div class="form-row">
                <div class="admin-form-group col-6">
                    <label>Giá bán (đ) *</label>
                    <input type="number" name="price" class="admin-input-control" placeholder="VD: 250000" min="0" required>
                </div>
                <div class="admin-form-group col-6">
                    <label>Giảm giá (%)</label>
                    <input type="number" name="discount" class="admin-input-control" placeholder="0-100" min="0" max="100" step="0.1">
                </div>
            </div>
            
            <div class="form-row">
                <div class="admin-form-group col-6">
                    <label>Tồn kho hiện tại</label>
                    <input type="number" name="current_stock" class="admin-input-control" placeholder="VD: 100" min="0">
                </div>
                <div class="admin-form-group col-6">
                    <label>Tồn kho tối thiểu</label>
                    <input type="number" name="min_stock" class="admin-input-control" placeholder="VD: 10" min="0">
                </div>
            </div>
            
            <div class="form-actions-admin">
                <button type="submit" class="btn-submit-admin">Thêm sản phẩm</button>
                <button type="button" class="btn-cancel-admin" onclick="closeModal('addProductModal')">Huỷ</button>
            </div>
        </form>
    </div>
</div>

<!-- Product Detail Modal -->
<div class="admin-modal-overlay" id="productDetailModal">
    <div class="admin-modal-container detail-modal">
        <div class="modal-topbar">
            <h2 class="modal-title">Chi tiết sản phẩm</h2>
            <button class="btn-close-modal" onclick="closeModal('productDetailModal')"><i class="fa-solid fa-xmark"></i></button>
        </div>
        
        <div class="modal-content-scroll">
            <div class="detail-header">
                <div class="detail-img-wrapper">
                    <img id="detail-img" src="" alt="Product">
                </div>
                <div class="detail-main-info">
                    <h1 id="detail-name" class="detail-title"></h1>
                    <p id="detail-short-desc" class="detail-subtitle"></p>
                    <div class="detail-row-badges">
                        <span id="detail-cat-badge" class="badge-detail cat"></span>
                        <span id="detail-origin-badge" class="badge-detail origin"></span>
                        <span id="detail-discount-badge" class="badge-detail discount"></span>
                    </div>
                </div>
            </div>

            <div class="detail-stats-grid">
                <div class="stat-item">
                    <span class="stat-label">Giá bán</span>
                    <span class="stat-value"><span id="detail-price"></span>đ / <span id="detail-unit"></span></span>
                </div>
                <div class="stat-item">
                    <span class="stat-label">Tồn kho</span>
                    <span id="detail-stock" class="stat-value"></span>
                </div>
                <div class="stat-item">
                    <span class="stat-label">Ngày tạo</span>
                    <span id="detail-created" class="stat-value"></span>
                </div>
                <div class="stat-item">
                    <span class="stat-label">Cập nhật</span>
                    <span id="detail-updated" class="stat-value"></span>
                </div>
            </div>

            <div class="detail-section">
                <h3 class="section-title">Mô tả</h3>
                <div id="detail-long-desc" class="section-content text-justify"></div>
            </div>
        </div>

        <div class="modal-footer">
            <button class="btn-edit-product-detail" id="btn-edit-from-detail">
                <i class="fa-solid fa-pencil"></i> Chỉnh sửa sản phẩm
            </button>
        </div>
    </div>
</div>

<!-- Edit Product Modal -->
<div class="admin-modal-overlay" id="editProductModal">
    <div class="admin-modal-container modal-lg">
        <div class="modal-topbar">
            <h2>Chỉnh sửa sản phẩm</h2>
            <button class="btn-close-modal" onclick="closeModal('editProductModal')"><i class="fa-solid fa-xmark"></i></button>
        </div>
        
        <form action="${pageContext.request.contextPath}/products-admin" method="post" enctype="multipart/form-data" class="modal-form">
            <input type="hidden" name="action" value="edit">
            <input type="hidden" name="id" id="edit-id">
            <input type="hidden" name="primaryImageIndex" id="edit-primaryIndex" value="0">
            
            <div class="form-row">
                <div class="admin-form-group col-12">
                    <label>Hình ảnh sản phẩm (Thêm mới)</label>
                    <div class="upload-zone" id="edit-uploadZone">
                        <div class="upload-content">
                            <i class="fa-solid fa-cloud-arrow-up"></i>
                            <p>Nhấp để tải ảnh lên hoặc kéo thả vào đây</p>
                            <span>Hỗ trợ: JPG, PNG, WEBP</span>
                        </div>
                        <input type="file" name="productImages" id="edit-productImages" multiple accept="image/*" class="hidden-input">
                    </div>
                    <div class="image-preview-grid" id="edit-imagePreviewContainer"></div>
                </div>
            </div>
            
            <div class="form-row">
                <div class="admin-form-group col-12">
                    <label>Tên sản phẩm *</label>
                    <input type="text" name="name" id="edit-name" class="admin-input-control" required>
                </div>
            </div>

            <div class="form-row">
                <div class="admin-form-group col-12">
                    <label>Mô tả ngắn *</label>
                    <input type="text" name="short_description" id="edit-short-desc" class="admin-input-control" required>
                </div>
            </div>

            <div class="form-row">
                <div class="admin-form-group col-12">
                    <label>Mô tả chi tiết</label>
                    <textarea name="long_description" id="edit-long-desc" class="admin-input-control" rows="3"></textarea>
                </div>
            </div>

            <div class="form-row">
                <div class="admin-form-group col-6">
                    <label>Danh mục</label>
                    <select name="category_id" id="edit-category" class="admin-input-control" required>
                        <c:forEach var="cat" items="${categories}">
                            <option value="${cat.id}">${cat.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="admin-form-group col-6">
                    <label>Xuất xứ</label>
                    <select name="origin_id" id="edit-origin" class="admin-input-control" required>
                        <c:forEach var="ori" items="${origins}">
                            <option value="${ori.id}">${ori.name}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>

            <div class="form-row">
                <div class="admin-form-group col-6">
                    <label>Lượng (số)</label>
                    <input type="number" name="packaging" id="edit-packaging" class="admin-input-control" step="0.01">
                </div>
                <div class="admin-form-group col-6">
                    <label>Đơn vị</label>
                    <input type="text" name="unit_name" id="edit-unit" class="admin-input-control" list="unit-list" required>
                </div>
            </div>

            <div class="form-row">
                <div class="admin-form-group col-6">
                    <label>Giá bán (đ) *</label>
                    <input type="number" name="price" id="edit-price" class="admin-input-control" required>
                </div>
                <div class="admin-form-group col-6">
                    <label>Giảm giá (%)</label>
                    <input type="number" name="discount" id="edit-discount" class="admin-input-control" min="0" max="100" step="0.1">
                </div>
            </div>

            <div class="form-row">
                <div class="admin-form-group col-6">
                    <label>Tồn kho hiện tại</label>
                    <input type="number" name="current_stock" id="edit-current-stock" class="admin-input-control" min="0">
                </div>
                <div class="admin-form-group col-6">
                    <label>Tồn kho tối thiểu</label>
                    <input type="number" name="min_stock" id="edit-min-stock" class="admin-input-control" min="0">
                </div>
            </div>

            <div class="form-actions-admin">
                <button type="submit" class="btn-submit-admin">Lưu thay đổi</button>
                <button type="button" class="btn-cancel-admin" onclick="closeModal('editProductModal')">Huỷ</button>
            </div>
        </form>
    </div>
</div>
