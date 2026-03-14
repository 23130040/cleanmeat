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
            <div class="product-card">
                <div class="product-image">
                    <span class="product-tag">BÁN CHẠY</span>
                    <img src="${pageContext.request.contextPath}/images/#">
                </div>
                <div class="product-info">
                    <p class="product-category">Thịt Bò</p>
                    <h3 class="product-name">Thịt Bò Úc</h3>
                    <p class="product-description">Phi lê cao cấp mềm ngon tự nhiên</p>

                    <div class="product-rating">
                        <i class="fa-solid fa-star"></i>
                        <i class="fa-solid fa-star"></i>
                        <i class="fa-solid fa-star"></i>
                        <i class="fa-solid fa-star"></i>
                        <i class="fa-regular fa-star"></i>
                        <span>(328)</span>
                    </div>

                    <div class="product-price">
                        <span class="new-price">450.000đ/kg</span>
                        <span class="old-price">520.000đ</span>
                    </div>

                    <button>Xem chi tiết</button>
                </div>
            </div>

            <div class="product-card">
                <div class="product-image">
                    <img src="${pageContext.request.contextPath}/images/#">
                </div>
                <div class="product-info">
                    <p class="product-category">Thịt Heo</p>
                    <h3 class="product-name">Thịt Heo Sạch</h3>
                    <p class="product-description">Ba chỉ tươi ngon phù hợp mọi bữa ăn</p>

                    <div class="product-rating">
                        <i class="fa-solid fa-star"></i>
                        <i class="fa-solid fa-star"></i>
                        <i class="fa-solid fa-star"></i>
                        <i class="fa-solid fa-star"></i>
                        <i class="fa-regular fa-star"></i>
                        <span>(215)</span>
                    </div>

                    <div class="product-price">
                        <span class="new-price">180.000đ/kg</span>
                    </div>

                    <button>Xem chi tiết</button>
                </div>
            </div>

            <div class="product-card">
                <div class="product-image">
                    <span class="product-tag">CAO CẤP</span>
                    <img src="${pageContext.request.contextPath}/images/#">
                </div>
                <div class="product-info">
                    <p class="product-category">Thịt Bò</p>
                    <h3 class="product-name">Thịt Bò Wagyu</h3>
                    <p class="product-description">Thăn nội cao cấp hương vị đậm đà</p>

                    <div class="product-rating">
                        <i class="fa-solid fa-star"></i>
                        <i class="fa-solid fa-star"></i>
                        <i class="fa-solid fa-star"></i>
                        <i class="fa-solid fa-star"></i>
                        <i class="fa-solid fa-star"></i>
                        <span>(89)</span>
                    </div>

                    <div class="product-price">
                        <span class="new-price">1.200.000đ/kg</span>
                    </div>

                    <button>Xem chi tiết</button>
                </div>
            </div>

            <div class="product-card">
                <div class="product-image">
                    <img src="${pageContext.request.contextPath}/images/#">
                </div>
                <div class="product-info">
                    <p class="product-category">Thịt Bò</p>
                    <h3 class="product-name">Sườn Bò Non</h3>
                    <p class="product-description">Phần sườn mềm ngon thích hợp nướng</p>

                    <div class="product-rating">
                        <i class="fa-solid fa-star"></i>
                        <i class="fa-solid fa-star"></i>
                        <i class="fa-solid fa-star"></i>
                        <i class="fa-solid fa-star"></i>
                        <i class="fa-regular fa-star"></i>
                        <span>(156)</span>
                    </div>

                    <div class="product-price">
                        <span class="new-price">320.000đ/kg</span>
                    </div>

                    <button>Xem chi tiết</button>
                </div>
            </div>

            <div class="product-card">
                <div class="product-image">
                    <img src="${pageContext.request.contextPath}/images/#" >
                </div>
                <div class="product-info">
                    <p class="product-category">Thịt Heo</p>
                    <h3 class="product-name">Ba Chỉ Heo</h3>
                    <p class="product-description">Tươi sạch loại 1 nhiều nạc ít mỡ</p>

                    <div class="product-rating">
                        <i class="fa-solid fa-star"></i>
                        <i class="fa-solid fa-star"></i>
                        <i class="fa-solid fa-star"></i>
                        <i class="fa-solid fa-star"></i>
                        <i class="fa-regular fa-star"></i>
                        <span>(134)</span>
                    </div>

                    <div class="product-price">
                        <span class="new-price">170.000đ/kg</span>
                    </div>

                    <button>Xem chi tiết</button>
                </div>
            </div>

            <div class="product-card">
                <div class="product-image">
                    <img src="${pageContext.request.contextPath}/images/#">
                </div>
                <div class="product-info">
                    <p class="product-category">Thịt Heo</p>
                    <h3 class="product-name">Thăn Heo</h3>
                    <p class="product-description">Nạc mềm dễ chế biến cho gia đình</p>

                    <div class="product-rating">
                        <i class="fa-solid fa-star"></i>
                        <i class="fa-solid fa-star"></i>
                        <i class="fa-solid fa-star"></i>
                        <i class="fa-solid fa-star"></i>
                        <i class="fa-regular fa-star"></i>
                        <span>(96)</span>
                    </div>

                    <div class="product-price">
                        <span class="new-price">190.000đ/kg</span>
                    </div>

                    <button>Xem chi tiết</button>
                </div>
            </div>
        </div>
    </div>
</div>