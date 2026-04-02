<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="news-header">
    <div class="container">
        <h1 class="news-title big-title">
            TIN TỨC CẬP NHẬT
        </h1>
        <p class="news-description">
            Cập nhật những thông tin về thịt, bí quyết nấu ăn ngon và các chương trình khuyến mãi từ Clean Meat.
        </p>
    </div>
</div>

<div class="news-list">
    <div class="container">
        <div class="news-layout">
            <div class="main-news">
                <div class="news-grid">
                    <c:choose>
                        <c:when test="${not empty newsList}">
                            <c:forEach var="news" items="${newsList}">
                                <div class="news-card">
                                    <div class="news-image">
                                        <img src="${news.picture_url}" alt="${news.title}" onerror="this.src='https://placehold.co/600x400/png?text=News'">
                                        <div class="news-date">
                                            <span class="day">${news.created_at.dayOfMonth}</span>
                                            <span class="month">Th${news.created_at.monthValue}</span>
                                        </div>
                                    </div>
                                    <div class="news-info">
                                        <p class="news-category">Tin tức</p>
                                        <h3 class="news-name"><a href="${pageContext.request.contextPath}/news-detail?id=${news.id}">${news.title}</a></h3>
                                        <p class="news-excerpt">
                                            ${news.content}
                                        </p>
                                        <a href="${pageContext.request.contextPath}/news-detail?id=${news.id}" class="read-more">Đọc tiếp <i class="fa-solid fa-arrow-right"></i></a>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <p style="grid-column: 1 / -1; text-align: center; color: #6b7280; padding: 40px 0;">Hiện chưa có bài viết nào.</p>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <div class="sidebar-news">
                <h3 class="sidebar-title">TIN TỨC MỚI NHẤT</h3>
                <div class="latest-news-list">
                    <c:forEach var="ln" items="${latestNews}">
                        <div class="latest-news-item">
                            <div class="latest-img">
                                <img src="${ln.picture_url}" alt="${ln.title}" onerror="this.src='https://placehold.co/100x100/png?text=News'">
                            </div>
                            <div class="latest-info">
                                <h4><a href="${pageContext.request.contextPath}/news-detail?id=${ln.id}">${ln.title}</a></h4>
                                <span class="latest-date">${ln.created_at.dayOfMonth}/${ln.created_at.monthValue}/${ln.created_at.year}</span>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>

        <c:if test="${totalPages > 1}">
            <div class="pagination">
                <ul>
                    <c:if test="${currentPage > 1}">
                        <li><a href="${pageContext.request.contextPath}/news?page=${currentPage - 1}"><i class="fa-solid fa-chevron-left"></i></a></li>
                    </c:if>
                    <c:if test="${currentPage <= 1}">
                        <li class="disabled"><a href="javascript:void(0)"><i class="fa-solid fa-chevron-left"></i></a></li>
                    </c:if>
                    
                    <c:forEach var="i" begin="1" end="${totalPages}">
                        <c:choose>
                            <c:when test="${currentPage == i}">
                                <li class="active"><a href="javascript:void(0)">${i}</a></li>
                            </c:when>
                            <c:otherwise>
                                <li><a href="${pageContext.request.contextPath}/news?page=${i}">${i}</a></li>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                    
                    <c:if test="${currentPage < totalPages}">
                        <li><a href="${pageContext.request.contextPath}/news?page=${currentPage + 1}"><i class="fa-solid fa-chevron-right"></i></a></li>
                    </c:if>
                    <c:if test="${currentPage >= totalPages}">
                        <li class="disabled"><a href="javascript:void(0)"><i class="fa-solid fa-chevron-right"></i></a></li>
                    </c:if>
                </ul>
            </div>
        </c:if>
    </div>
</div>
