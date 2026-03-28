<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Clean Meat -
        <c:out value="${requestScope.pageTitle}"></c:out></title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
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
            <li class="${active == 'product' ? 'active' : ''}"><a href="${pageContext.request.contextPath}/product">Sản phẩm</a></li>
            <li class="${active == 'news' ? 'active' : ''}"><a href="${pageContext.request.contextPath}/news">Tin tức</a></li>
            <li class="${active == 'about-us' ? 'active' : ''}"><a href="${pageContext.request.contextPath}/about-us">Về chúng tôi</a></li>
            <li class="${active == 'contact' ? 'active' : ''}"><a href="${pageContext.request.contextPath}/contact">Liên hệ</a></li>
        </ul>
        <ul class="nav-auth">
            <li class="${active == 'cart' ? 'active' : ''}"><a href="#">
                <span><i class="fa-solid fa-cart-shopping"></i></span>
                <span id="cart-quantity">0</span>
            </a>
            </li>
            <c:choose>
                <c:when test="${not empty user}">
                    <li class="nav-notification">
                        <div class="notification-icon-wrapper">
                            <i class="fa-regular fa-bell"></i>
                            <span class="notification-badge">4</span>
                        </div>
                    </li>
                    <li class="nav-user-profile" id="userProfileDropdown">
                        <div class="user-avatar">
                            <c:choose>
                                <c:when test="${not empty user.avatar}">
                                    <img src="${pageContext.request.contextPath}${user.avatar}">
                                </c:when>
                                <c:otherwise>
                                    <i class="fa-solid fa-user"></i>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="user-info">
                            <span class="user-name">${user.name}</span>
                            <span class="user-role">${user.role == 'admin' ? 'Quản trị viên' : 'Khách hàng'}</span>
                        </div>
                        <i class="fa-solid fa-chevron-down dropdown-icon"></i>
                        <ul class="dropdown-menu">
                            <li><a href="${pageContext.request.contextPath}/profile"><i
                                    class="fa-regular fa-circle-user"></i> Tài khoản</a></li>
                            <li><a href="${pageContext.request.contextPath}/sign-out"><i
                                    class="fa-solid fa-arrow-right-from-bracket"></i> Đăng xuất</a></li>
                        </ul>
                    </li>
                </c:when>
                <c:otherwise>
                    <li class="nav-login-btn">
                        <a href="${pageContext.request.contextPath}/sign-in"><i class="fa-regular fa-user"></i> Đăng
                            nhập</a>
                    </li>
                </c:otherwise>
            </c:choose>
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
                <h4 class="product-title small-title">Sản phẩm</h4>
                <ul>
                    <li><a>Thịt bò</a></li>
                    <li><a>Thịt heo</a></li>
                    <li><a>Thịt gà</a></li>
                </ul>
            </div>
            <div class="footer-col footer-support">
                <h4 class="support-title small-title">Hỗ trợ</h4>
                <ul>
                    <li><a href="${pageContext.request.contextPath}/returns-policy">Chính sách đổi trả</a></li>
                    <li><a href="${pageContext.request.contextPath}/order-guide">Hướng dẫn đặt hàng</a></li>
                    <li><a href="${pageContext.request.contextPath}/">Thanh toán</a></li>
                    <li><a href="${pageContext.request.contextPath}/">Vận chuyển</a></li>
                </ul>
            </div>
            <div class="footer-col footer-about">
                <h4 class="about-us-title small-title">Về chúng tôi</h4>
                <ul>
                    <li><a href="${pageContext.request.contextPath}/about-us">Giới thiệu</a></li>
                    <li><a href="${pageContext.request.contextPath}/contact">Liên hệ</a></li>
                </ul>
            </div>
        </div>
        <div class="footer-row footer-copyright">
            <p>© 2026 Clean Meat. Tất cả quyền được bảo lưu.</p>
        </div>
    </div>
</footer>
</body>
<script src = "${pageContext.request.contextPath}/js/base.js"></script>
<script src="${pageContext.request.contextPath}/js/${requestScope.pageJs}"></script>
</html>