<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="home-slider">
    <div class="container">
        <h1 class="slider-title">
            <span class="white-title">Thịt Sạch Tươi Ngon</span>
            <span class="green-title">Chất Lượng Hàng Đầu</span>
        </h1>
        <p class="slider-description">
            Nguồn gốc rõ ràng, an toàn tuyệt đối. Thịt bò, thịt heo, thịt gà cao cấp được chọn lọc kỹ càng, đảm bảo dinh
            dưỡng và hương vị tuyệt hảo cho gia đình bạn.
        </p>
        <a href="${pageContext.request.contextPath}/product">
            <button>ĐẶT HÀNG NGAY</button>
        </a>
    </div>
</div>
<div class="home-best-sellers">
    <div class="container">
        <div class="best-sellers-title">
            <h3>Sản Phẩm Bán Chạy</h3>
            <p>Những sản phẩm thịt sạch được khách hàng yêu thích và tin dùng nhất</p>
        </div>
        <div class="best-sellers-products">
            <c:choose>
                <c:when test="${not empty bestSellers}">
                    <div class="product-grid">
                        <c:forEach var="item" items="${bestSellers}">
                            <div class="home-product-card">
                                <div class="card-image-wrapper">
                                    <img src="${pageContext.request.contextPath}/images/${item.image}"
                                         alt="${item.name}">
                                    <c:if test="${item.discount > 0}">
                                        <span class="badge badge-sale">SALE</span>
                                    </c:if>
                                    <c:choose>
                                        <c:when test="${item.price > 500000}">
                                            <span class="badge badge-caocap">CAO CẤP</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge badge-banchay">BÁN CHẠY</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="card-content">
                                    <h4 class="product-title">${item.name}</h4>
                                    <p class="product-subtitle">${item.short_description != null ? item.short_description : item.category_name}</p>
                                    <div class="rating-row">
                                        <div class="stars">
                                            <i class="fa-solid fa-star"></i>
                                            <i class="fa-solid fa-star"></i>
                                            <i class="fa-solid fa-star"></i>
                                            <i class="fa-solid fa-star"></i>
                                            <i class="fa-solid fa-star"></i>
                                        </div>
                                        <span class="rating-count">(99)</span>
                                    </div>
                                    <div class="price-row">
                                        <span class="current-price">
                                            <fmt:formatNumber value="${item.price * (1 - item.discount/100.0)}"
                                                              maxFractionDigits="0"/>đ</span>
                                        <c:if test="${item.discount > 0}">
                                            <span class="old-price"><fmt:formatNumber value="${item.price}"
                                                                                      maxFractionDigits="0"/>đ</span>
                                        </c:if>
                                        <span class="unit">/ ${item.unit_name}</span>
                                    </div>
                                    <div class="card-actions">
                                        <a href="${pageContext.request.contextPath}/product-detail?id=${item.id}"
                                           class="btn-detail">Xem chi tiết</a>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <p>Chưa có sản phẩm.</p>
                </c:otherwise>
            </c:choose>
        </div>
        <div class="view-all-container">
            <a href="${pageContext.request.contextPath}/product" class="btn-view-all">
                Xem Tất Cả Sản Phẩm <i class="fa-solid fa-arrow-right"></i>
            </a>
        </div>
    </div>
</div>
<div class="home-conversion">
    <div class="container">
        <img src="${pageContext.request.contextPath}/images/cut.jpg" alt="Thịt sạch">
        <p class="italic">Đặt hàng dễ dàng</p>
        <p class="bold">Nhận hàng nhanh chóng</p>
        <p class="italic">Thưởng thức ngay hôm nay</p>
        <a href="${pageContext.request.contextPath}/product">
            <button class="link-products">Xem sản phẩm</button>
        </a>
    </div>
</div>
