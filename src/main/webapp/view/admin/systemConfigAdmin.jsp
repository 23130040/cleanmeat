<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="system-config-wrapper">
    <div class="config-card">
        <form action="${pageContext.request.contextPath}/system-admin" method="post" id="configForm">
            <input type="hidden" name="id" value="${config.id}">
            
            <div class="config-grid">
                <div class="logo-config">
                    <div class="logo-preview-container">
                        <img src="${not empty config.logo_url ? config.logo_url : pageContext.request.contextPath.concat('/images/cleanmeat.png')}" id="logoPreview">
                    </div>
                    <div class="admin-form-group">
                        <label>Đường dẫn Logo (URL)</label>
                        <input type="text" class="admin-input-control" name="logo_url" value="${config.logo_url}" id="logoUrlInput" placeholder="https://example.com/cleanmeat.png">
                    </div>
                    <p class="config-hint">Dán URL hình ảnh logo của bạn vào đây. Logo sẽ được cập nhật ngay lập tức trong phần xem trước.</p>
                </div>

                <div class="info-config">
                    <div class="admin-form-group">
                        <label>Tên cửa hàng / Website</label>
                        <input type="text" class="admin-input-control" name="name" value="${config.name}" required>
                    </div>
                    
                    <div class="form-row">
                        <div class="admin-form-group">
                            <label>Email liên hệ</label>
                            <input type="email" class="admin-input-control" name="email" value="${config.email}" required>
                        </div>
                        <div class="admin-form-group">
                            <label>Hotline</label>
                            <input type="text" class="admin-input-control" name="hotline" value="${config.hotline}" required>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="admin-form-group">
                            <label>Mã số thuế</label>
                            <input type="text" class="admin-input-control" name="tax_code" value="${config.tax_code}">
                        </div>
                        <div class="admin-form-group">
                            <label>Link Facebook</label>
                            <input type="text" class="admin-input-control" name="facebook" value="${config.facebook}">
                        </div>
                    </div>

                    <div class="admin-form-group">
                        <label>Địa chỉ văn phòng / Cửa hàng</label>
                        <textarea class="admin-input-control" name="address" rows="3" required>${config.address}</textarea>
                    </div>

                    <div class="form-actions">
                        <button type="submit" class="btn-save-config">
                            <i class="fa-solid fa-floppy-disk"></i> Lưu cấu hình
                        </button>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>
