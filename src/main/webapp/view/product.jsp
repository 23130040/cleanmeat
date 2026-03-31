<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="products-header">
    <div class="container">
        <h1 class="products-title">SẢN PHẨM CỦA CHÚNG TÔI</h1>
        <p class="products-description">
            Thịt sạch cao cấp - Nguồn gốc rõ ràng - Chất lượng đảm bảo
        </p>
        <div class="products-search">
            <i class="fa-solid fa-magnifying-glass"></i>
            <input type="text" placeholder="Tìm kiếm sản phẩm...">
        </div>
    </div>
</div>

<div class="products-filter">
    <div class="container">
        <form method="get" action="${pageContext.request.contextPath}/product">
            <div class="filter-box">
                <div class="filter-item">
                    <span class="filter-title">Danh mục</span>
                    <div class="category-buttons">
                        <button type="submit" name="category" value=""
                                class="${empty param.category ? 'active' : ''}">
                            Tất cả
                        </button>

                        <button type="submit" name="category" value="1"
                                class="${param.category == '1' ? 'active' : ''}">
                            Thịt Bò
                        </button>

                        <button type="submit" name="category" value="2"
                                class="${param.category == '2' ? 'active' : ''}">
                            Thịt Heo
                        </button>

                        <button type="submit" name="category" value="3"
                                class="${param.category == '3' ? 'active' : ''}">
                            Thịt Gà
                        </button>
                    </div>
                </div>

                <div class="filter-item">
                    <span class="filter-title">Khoảng giá</span>
                    <select name="price" onchange="this.form.submit()">
                        <option value="">Tất cả</option>
                        <option value="1" ${param.price == '1' ? 'selected' : ''}>Dưới 200.000đ</option>
                        <option value="2" ${param.price == '2' ? 'selected' : ''}>200.000đ - 500.000đ</option>
                        <option value="3" ${param.price == '3' ? 'selected' : ''}>Trên 500.000đ</option>
                    </select>
                </div>

                <div class="filter-item">
                    <span class="filter-title">Sắp xếp theo</span>
                    <select name="sort" onchange="this.form.submit()">
                        <option value="new" ${param.sort == 'new' ? 'selected' : ''}>Mới nhất</option>
                        <option value="asc" ${param.sort == 'asc' ? 'selected' : ''}>Giá tăng dần</option>
                        <option value="desc" ${param.sort == 'desc' ? 'selected' : ''}>Giá giảm dần</option>
                        <option value="hot" ${param.sort == 'hot' ? 'selected' : ''}>Bán chạy</option>
                    </select>
                </div>
            </div>
        </form>
    </div>
</div>

<div class="products-list">
    <div class="container">
        <p class="products-count">
            Tìm thấy <b>${totalItems}</b> sản phẩm
        </p>

        <div class="products-grid">
            <c:choose>
                <c:when test="${not empty items}">
                    <c:forEach var="item" items="${items}">
                        <a href="${pageContext.request.contextPath}/product-detail?id=${item.id}" class="product-link">
                            <div class="product-card">

                                <div class="product-image">
                                    <c:if test="${item.discount > 0}">
                                        <span class="product-tag">SALE</span>
                                    </c:if>

                                    <c:choose>
                                        <c:when test="${not empty item.image}">
                                            <img src="${pageContext.request.contextPath}/images/${item.image}"
                                                 alt="${item.name}">
                                        </c:when>
                                        <c:otherwise>
                                            <img src="${pageContext.request.contextPath}/images/default.png">
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                                <div class="product-info">
                                    <p class="product-category">${item.category_name}</p>

                                    <h3 class="product-name">${item.name}</h3>

                                    <p class="product-description">
                                            ${item.short_description}
                                    </p>

                                    <div class="product-rating">
                                        <i class="fa-solid fa-star"></i>
                                        <i class="fa-solid fa-star"></i>
                                        <i class="fa-solid fa-star"></i>
                                        <i class="fa-solid fa-star"></i>
                                        <i class="fa-regular fa-star"></i>
                                        <span>(0)</span>
                                    </div>

                                    <div class="product-price">
                                <span class="new-price">
                                    <fmt:formatNumber value="${item.price}" maxFractionDigits="0"/>đ/${item.unit_name}
                                </span>

                                        <c:if test="${item.discount > 0}">
                                    <span class="old-price">
                                        <fmt:formatNumber value="${item.price + item.discount}" maxFractionDigits="0"/>đ
                                    </span>
                                        </c:if>
                                    </div>

                                    <button>Xem chi tiết</button>
                                </div>

                            </div>
                        </a>
                    </c:forEach>
                </c:when>

                <c:otherwise>
                    <p>Không có sản phẩm nào</p>
                </c:otherwise>
            </c:choose>
        </div>
        <c:set var="start" value="${currentPage}"/>
        <c:set var="end" value="${currentPage + 2}"/>

        <c:if test="${end > totalPages}">
            <c:set var="end" value="${totalPages}"/>
            <c:set var="start" value="${totalPages - 2}"/>
        </c:if>

        <c:if test="${start < 1}">
            <c:set var="start" value="1"/>
        </c:if>

        <div class="pagination">
            <ul>

                <c:if test="${currentPage > 1}">
                    <li>
                        <a href="${pageContext.request.contextPath}/product?page=${currentPage - 1}&category=${param.category}&price=${param.price}&sort=${param.sort}">&laquo;</a>
                    </li>
                </c:if>

                <c:forEach begin="${start}" end="${end}" var="i">
                    <li class="${i == currentPage ? 'active' : ''}">
                        <a href="${pageContext.request.contextPath}/product?page=${i}&category=${param.category}&price=${param.price}&sort=${param.sort}">${i}
                        </a>
                    </li>
                </c:forEach>

                <c:if test="${currentPage < totalPages}">
                    <li>
                        <a href="${pageContext.request.contextPath}/product?page=${currentPage + 1}&category=${param.category}&price=${param.price}&sort=${param.sort}">&raquo;</a>
                    </li>
                </c:if>
            </ul>
        </div>
    </div>
</div>
