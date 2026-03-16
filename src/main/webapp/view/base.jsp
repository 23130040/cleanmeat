<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Clean Meat -
        <c:out value="${requestScope.pageTitle}"></c:out></title>
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/base.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/${requestScope.pageCss}">
</head>
<body>
<nav>
    <div class="container">
        <div class="nav-logo">
            <img src="${pageContext.request.contextPath}/images/cleanmeat.png">
        </div>
        <ul class="nav-menu">
            <li class="${active == 'home' ? 'active' : ''}"><a href="${pageContext.request.contextPath}/home">Trang chủ</a></li>
            <li class="${active == 'products' ? 'active' : ''}"><a href="${pageContext.request.contextPath}/product">Sản phẩm</a></li>
            <li class="${active == 'about-us' ? 'active' : ''}"><a href="${pageContext.request.contextPath}/about-us">Về chúng tôi</a></li>
            <li class="${active == 'contact' ? 'active' : ''}"><a href="${pageContext.request.contextPath}/contact">Liên hệ</a></li>
        </ul>
        <ul class="nav-auth">
            <li class="${active == 'cart' ? 'active' : ''}"><a href="#">
                <span><i class="fa-solid fa-cart-shopping"></i></span>
                <span id="cart-quantity">0</span>
            </a>
            </li>
            <li>
                <c:choose>
                    <c:when test="${not empty user}">
                        <span class="auth-avatar">
                            N
                        </span>
                        <span class="auth-name">
                            Nguyen Bich Dan
                        </span>
                    </c:when>
                    <c:otherwise>
                        <i class="fa-regular fa-user"></i> Đăng nhập
                    </c:otherwise>
                </c:choose>
            </li>
        </ul>
    </div>
</nav>
<main>
    <c:import url="${requestScope.pageContent}"></c:import>
</main>
<footer>
    <div class="container">
        <div class="footer-row footer-info">
            <div class="footer-col footer-newsletter">
                <img src="${pageContext.request.contextPath}/images/cleanmeat.png">
                <ul>
                    <li>Địa chỉ:</li>
                    <li>Số điện thoại:</li>
                    <li>Email:</li>
                </ul>
            </div>
            <div class="footer-col footer-products">
                <h4 class="products-title small-title">Sản phẩm</h4>
                <ul>
                    <li><a>Thịt bò</a></li>
                    <li><a>Thịt heo</a></li>
                    <li><a>Thịt gà</a></li>
                </ul>
            </div>
            <div class="footer-col footer-support">
                <h4 class="products-title small-title">Hỗ trợ</h4>
                <ul>
                    <li><a>Chính sách đổi trả</a></li>
                    <li><a>Hướng dẫn đặt hàng</a></li>
                    <li><a>Thanh toán</a></li>
                    <li><a>Vận chuyển</a></li>
                </ul>
            </div>
            <div class="footer-col footer-about">
                <h4 class="products-title small-title">Về chúng tôi</h4>
                <ul>
                    <li><a>Giới thiệu</a></li>
                    <li><a>Liên hệ</a></li>
                </ul>
            </div>
        </div>
        <div class="footer-row footer-copyright">
            <p>© 2026 Thịt Sạch. Tất cả quyền được bảo lưu.</p>
        </div>
    </div>
</footer>
</body>
</html>