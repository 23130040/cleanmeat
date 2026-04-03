<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="news-admin-container">
    <div class="toolbar">
        <form action="${pageContext.request.contextPath}/news-admin" method="get" class="search-form">
            <div class="search-bar">
                <i class="fa-solid fa-magnifying-glass"></i>
                <input type="text" name="search" placeholder="Tìm bài viết, tác giả..." value="${searchQuery}">
            </div>
            <div class="filter-chips">
                <button type="submit" name="filter" value="Tất cả" class="chip ${currentFilter eq 'Tất cả' || currentFilter eq null ? 'active' : ''}">Tất cả</button>
                <button type="submit" name="filter" value="Đã đăng" class="chip ${currentFilter eq 'Đã đăng' ? 'active' : ''}">Đã đăng</button>
                <button type="submit" name="filter" value="Nháp" class="chip ${currentFilter eq 'Nháp' ? 'active' : ''}">Nháp</button>
            </div>
        </form>
        <button class="btn-add" onclick="openAddNewsModal()">
            <i class="fa-solid fa-plus"></i> Thêm bài viết
        </button>
    </div>

    <div class="news-grid">
        <c:choose>
            <c:when test="${not empty newsList}">
                <c:forEach var="news" items="${newsList}">
                    <div class="news-card">
                        <div class="news-image">
                            <img src="${not empty news.picture_url ? (news.picture_url.startsWith('http') ? news.picture_url : pageContext.request.contextPath += news.picture_url) : pageContext.request.contextPath += '/images/news-placeholder.jpg'}" alt="${news.title}">
                            <span class="status-badge ${news.status eq 'Đã đăng' ? 'published' : 'draft'}">${news.status}</span>
                        </div>
                        <div class="news-content">
                            <h3 class="news-title">${news.title}</h3>
                            <div class="news-meta">
                                <span class="author"><i class="fa-regular fa-user"></i> ${news.author}</span>
                                <span class="date"><i class="fa-regular fa-calendar-days"></i> ${news.created_at.toLocalDate()}</span>
                            </div>
                            <p class="news-excerpt">${news.content}</p>
                        </div>
                        <div class="news-actions">
                            <button onclick="viewNews('${news.id}')" class="action-btn view"><i class="fa-regular fa-eye"></i> Xem</button>
                            <button onclick="editNews('${news.id}')" class="action-btn edit"><i class="fa-solid fa-pen-to-square"></i> Sửa</button>
                            <form action="${pageContext.request.contextPath}/news-admin" method="post" style="display:inline;">
                                <input type="hidden" name="action" value="toggleStatus">
                                <input type="hidden" name="id" value="${news.id}">
                                <button type="submit" class="action-btn hidden">
                                    <c:choose>
                                        <c:when test="${news.status eq 'Đã đăng'}">
                                            <i class="fa-solid fa-eye-slash"></i> Ẩn
                                        </c:when>
                                        <c:otherwise>
                                            <i class="fa-solid fa-eye"></i> Hiện
                                        </c:otherwise>
                                    </c:choose>
                                </button>
                            </form>
                            <button onclick="confirmDelete('${news.id}')" class="action-btn delete"><i class="fa-regular fa-trash-can"></i> Xoá</button>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
    <div class="empty-state">
                    <p>Không tìm thấy bài viết nào.</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<!-- Modal Thêm bài viết -->
<div class="admin-modal-overlay" id="addNewsModal">
    <div class="admin-modal-container news-modal">
        <div class="modal-topbar">
            <h2>Thêm bài viết mới</h2>
            <button class="btn-close-modal" onclick="closeAddNewsModal()"><i class="fa-solid fa-xmark"></i></button>
        </div>
        
        <form action="${pageContext.request.contextPath}/news-admin" method="post" enctype="multipart/form-data" class="admin-form">
            <input type="hidden" name="action" value="add">
            
            <div class="admin-form-group">
                <label>Hình ảnh bài viết</label>
                <div class="upload-zone" id="newsUploadZone">
                    <div class="upload-content" id="uploadContent">
                        <i class="fa-solid fa-cloud-arrow-up"></i>
                        <p>Nhấp để tải ảnh lên</p>
                        <span>Hỗ trợ: JPG, PNG, WEBP (Tối đa 10MB)</span>
                    </div>
                    <div class="image-preview-single" id="imagePreview" style="display: none;">
                        <img src="" alt="Preview">
                        <button type="button" class="btn-remove-preview" onclick="removePreview(event)">
                            <i class="fa-solid fa-xmark"></i>
                        </button>
                    </div>
                </div>
                <input type="file" name="picture" id="newsPicture" accept="image/*" class="hidden-input" required>
            </div>

            <div class="admin-form-group">
                <label>Tiêu đề *</label>
                <input type="text" name="title" class="admin-input-control" placeholder="Nhập tiêu đề bài viết..." required>
            </div>

            <div class="form-row">
                <div class="admin-form-group">
                    <label>Tác giả *</label>
                    <input type="text" name="author" class="admin-input-control" placeholder="Tên tác giả" required>
                </div>
                <div class="admin-form-group">
                    <label>Trạng thái</label>
                    <select name="status" class="admin-input-control">
                        <option value="Nháp">Nháp</option>
                        <option value="Đã đăng">Đã đăng</option>
                    </select>
                </div>
            </div>

            <div class="admin-form-group">
                <label>Nội dung *</label>
                <textarea name="content" class="admin-input-control" rows="6" placeholder="Nhập nội dung bài viết..." required></textarea>
            </div>

            <div class="modal-actions-form">
                <button type="submit" class="btn-add-submit">Thêm bài viết</button>
                <button type="button" class="btn-cancel-admin" onclick="closeAddNewsModal()">Huỷ</button>
            </div>
        </form>
    </div>
</div>

<!-- Modal Sửa bài viết -->
<div class="admin-modal-overlay" id="editNewsModal">
    <div class="admin-modal-container news-modal">
        <div class="modal-topbar">
            <h2>Chỉnh sửa bài viết</h2>
            <button class="btn-close-modal" onclick="closeEditNewsModal()"><i class="fa-solid fa-xmark"></i></button>
        </div>
        
        <form action="${pageContext.request.contextPath}/news-admin" method="post" enctype="multipart/form-data" class="admin-form">
            <input type="hidden" name="action" value="edit">
            <input type="hidden" name="id" id="editNewsId">
            
            <div class="admin-form-group">
                <label>Hình ảnh bài viết</label>
                <div class="upload-zone" id="editNewsUploadZone">
                    <div class="upload-content" id="editUploadContent" style="display: none;">
                        <i class="fa-solid fa-cloud-arrow-up"></i>
                        <p>Nhấp để tải ảnh lên</p>
                        <span>Hỗ trợ: JPG, PNG, WEBP (Tối đa 10MB)</span>
                    </div>
                    <div class="image-preview-single" id="editImagePreview">
                        <img src="" alt="Preview" id="editPreviewImg">
                        <button type="button" class="btn-remove-preview" onclick="removeEditPreview(event)">
                            <i class="fa-solid fa-xmark"></i>
                        </button>
                    </div>
                </div>
                <input type="file" name="picture" id="editNewsPicture" accept="image/*" class="hidden-input">
            </div>

            <div class="admin-form-group">
                <label>Tiêu đề *</label>
                <input type="text" name="title" id="editTitle" class="admin-input-control" required>
            </div>

            <div class="form-row">
                <div class="admin-form-group">
                    <label>Tác giả *</label>
                    <input type="text" name="author" id="editAuthor" class="admin-input-control" required>
                </div>
                <div class="admin-form-group">
                    <label>Trạng thái</label>
                    <select name="status" id="editStatus" class="admin-input-control">
                        <option value="Nháp">Nháp</option>
                        <option value="Đã đăng">Đã đăng</option>
                    </select>
                </div>
            </div>

            <div class="admin-form-group">
                <label>Nội dung *</label>
                <textarea name="content" id="editContent" class="admin-input-control" rows="6" required></textarea>
            </div>

            <div class="modal-actions-form">
                <button type="submit" class="btn-add-submit">Lưu thay đổi</button>
                <button type="button" class="btn-cancel-admin" onclick="closeEditNewsModal()">Huỷ</button>
            </div>
        </form>
    </div>
</div>

<!-- Modal Xem bài viết -->
<div class="admin-modal-overlay" id="viewNewsModal">
    <div class="admin-modal-container news-detail-modal">
        <div class="modal-topbar">
            <h2 id="viewNewsTitle">Chi tiết bài viết</h2>
            <button class="btn-close-modal" onclick="closeViewNewsModal()"><i class="fa-solid fa-xmark"></i></button>
        </div>
        <div class="modal-news-body">
            <div class="view-news-image">
                <img src="" alt="News Image" id="viewNewsImg">
            </div>
            <div class="view-news-info">
                <div class="view-news-meta">
                    <span id="viewNewsAuthor"><i class="fa-regular fa-user"></i> </span>
                    <span id="viewNewsDate"><i class="fa-regular fa-calendar-days"></i> </span>
                    <span id="viewNewsStatus" class="status-badge"></span>
                </div>
                <div class="view-news-content" id="viewNewsFullContent">
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Modal Xác nhận xoá -->
<div class="admin-modal-overlay" id="deleteNewsModal">
    <div class="admin-modal-container delete-confirm-modal">
        <div class="modal-body-confirm">
            <div class="confirm-icon"><i class="fa-solid fa-triangle-exclamation"></i></div>
            <h3>Khác nhận xoá bài viết?</h3>
            <p>Hành động này không thể hoàn tác. Bạn có chắc chắn muốn xoá bài viết này?</p>
            <form action="${pageContext.request.contextPath}/news-admin" method="post">
                <input type="hidden" name="action" value="delete">
                <input type="hidden" name="id" id="deleteNewsId">
                <div class="confirm-actions">
                    <button type="submit" class="btn-confirm-delete">Xoá ngay</button>
                    <button type="button" class="btn-cancel-confirm" onclick="closeDeleteModal()">Huỷ bỏ</button>
                </div>
            </form>
        </div>
    </div>
</div>
