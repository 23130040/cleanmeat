<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

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
        <div class="filter-box">
            <div class="filter-item">
                <span class="filter-title">Danh mục</span>
                <div class="category-buttons">
                    <button class="active">Tất cả</button>
                    <button>Thịt Bò</button>
                    <button>Thịt Heo</button>
                </div>
            </div>

            <div class="filter-item">
                <span class="filter-title">Khoảng giá</span>
                <select>
                    <option>Tất cả</option>
                    <option>Dưới 200.000đ</option>
                    <option>200.000đ - 500.000đ</option>
                    <option>Trên 500.000đ</option>
                </select>
            </div>

            <div class="filter-item">
                <span class="filter-title">Sắp xếp theo</span>
                <select>
                    <option>Mới nhất</option>
                    <option>Giá tăng dần</option>
                    <option>Giá giảm dần</option>
                    <option>Bán chạy</option>
                </select>
            </div>
        </div>
    </div>
</div>

<div class="products-list">
    <div class="container">
        <p class="products-count">
            Tìm thấy <b>6</b> sản phẩm
        </p>

        <div class="products-grid">

            <c:choose>
                <c:when test="${not empty items}">
                    <c:forEach var="item" items="${items}">
                        <div class="product-card">

                            <div class="product-image">
                                <c:if test="${item.discount > 0}">
                                    <span class="product-tag">SALE</span>
                                </c:if>

                                <img src="${pageContext.request.contextPath}/${item.image}"
                                     alt="${item.name}">
                            </div>

                            <div class="product-info">
                                <p class="product-category">
                                        ${item.category_name}
                                </p>

                                <h3 class="product-name">
                                        ${item.name}
                                </h3>

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
                                ${item.price}đ/${item.unit_name}
                            </span>

                                    <c:if test="${item.discount > 0}">
                                <span class="old-price">
                                    ${item.price + item.discount}đ
                                </span>
                                    </c:if>
                                </div>

                                <button>Xem chi tiết</button>
                            </div>

                        </div>
                    </c:forEach>
                </c:when>

                <c:otherwise>
                    <p>Không có sản phẩm nào</p>
                </c:otherwise>
            </c:choose>
                </div>
            </div>
        </div>
    </div>
</div>