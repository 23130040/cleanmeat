<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="product-detail-wrapper">
    <div class="container">

        <div class="productdetail">
            <div class="product-image">
                <img src="${pageContext.request.contextPath}/images/${item.image}" alt="${item.name}">
            </div>

            <div class="product-info">
                <h1>${item.name}</h1>

                <div class="rating">
                    <c:choose>
                        <c:when test="${totalFeedback > 0}">
                            <c:forEach begin="1" end="5" var="i">
                                <c:choose>
                                    <c:when test="${i <= avgRating}">
                                        <i class="fa-solid fa-star"></i>
                                    </c:when>
                                    <c:otherwise>
                                        <i class="fa-regular fa-star"></i>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                            (${totalFeedback} đánh giá)
                        </c:when>
                        <c:otherwise>
                            <c:forEach begin="1" end="5">
                                <i class="fa-solid fa-star"></i>
                            </c:forEach>
                            (0 đánh giá)
                        </c:otherwise>
                    </c:choose>
                </div>

                <div class="price" id="price" data-base="${item.price}">
                    <fmt:formatNumber value="${item.price}" maxFractionDigits="0"/> đ / 250g
                </div>

                <p>${item.short_description}</p>

                <p><b>Danh mục:</b> ${item.category_name}</p>
                <p><b>Xuất xứ:</b> ${item.origin_name}</p>

                <div class="weight">
                    <label>Chọn khối lượng:</label>
                    <div class="weight-options">
                        <button type="button" class="weight-btn active" data-weight="250">250g</button>
                        <button type="button" class="weight-btn" data-weight="500">500g</button>
                        <button type="button" class="weight-btn" data-weight="1000">1kg</button>
                    </div>
                </div>

                <div class="quantity">
                    <button type="button" id="minus">-</button>
                    <input type="text" id="qty" value="1">
                    <button type="button" id="plus">+</button>
                </div>

                <div class="actions">
                    <button class="add" ${item.current_stock == 0 ? "disabled" : ""}>Thêm vào giỏ</button>
                    <button class="buy" ${item.current_stock == 0 ? "disabled" : ""}>Mua ngay</button>
                </div>
            </div>
        </div>

        <div class="product-extra">
            <h2>Chi tiết sản phẩm</h2>
            <p>${item.long_description}</p>
        </div>

        <div class="product-comments">
            <h2>Đánh giá sản phẩm</h2>

            <c:choose>
                <c:when test="${not empty feedbacks}">
                    <c:forEach var="f" items="${feedbacks}">
                        <div class="comment-item">
                            <div class="avatar">
                                <img src="${pageContext.request.contextPath}/images/${f.avatar}" alt="">
                            </div>

                            <div class="content">
                                <b>${f.name}</b>

                                <div class="stars">
                                    <c:forEach begin="1" end="5" var="i">
                                        <c:choose>
                                            <c:when test="${i <= f.rating}">
                                                <i class="fa-regular fa-star"></i>
                                            </c:when>
                                            <c:otherwise>
                                                <i class="fa-regular fa-star"></i>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                </div>

                                <p>${f.comment}</p>
                                <small>${f.created_at}</small>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <p>Chưa có đánh giá</p>
                </c:otherwise>
            </c:choose>

        </div>

    </div>
</div>
