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
        <button class="btn-add">
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
                            <a href="#" class="action-btn view"><i class="fa-regular fa-eye"></i> Xem</a>
                            <a href="#" class="action-btn edit"><i class="fa-solid fa-pen-to-square"></i> Sửa</a>
                            <a href="#" class="action-btn hidden"><i class="fa-solid fa-eye-slash"></i> Ẩn</a>
                            <a href="#" class="action-btn delete"><i class="fa-regular fa-trash-can"></i> Xoá</a>
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
