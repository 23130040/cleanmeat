<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Clean Meat - Admin</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/baseAdmin.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/${requestScope.pageCss}">
</head>
<body>
<nav>
    <div class="nav-logo">
        <img src="${pageContext.request.contextPath}/images/cleanmeat.png">
    </div>
    <ul class="nav-menu">
        <li class="${active == 'dashboard' ? 'active' : ''}"><a href="${pageContext.request.contextPath}/dashboard"><i
                class="fa-solid fa-chart-column"></i> Dashboard</a>
        </li>
        <li class="${active == 'user-admin' ? 'active' : ''}"><a href="${pageContext.request.contextPath}/user-admin"><i
                class="fa-regular fa-user"></i> Người dùng</a></li>
        <li class="${active == 'products-admin' ? 'active' : ''}"><a
                href="${pageContext.request.contextPath}/products-admin"><i
                class="fa-solid fa-store"></i> Sản phẩm</a></li>
        <li class="${active == 'orders-admin' ? 'active' : ''}"><a
                href="${pageContext.request.contextPath}/orders-admin"><i
                class="fa-solid fa-bag-shopping"></i> Đơn hàng</a></li>
        <li class="${active == 'stock-history-admin' ? 'active' : ''}"><a
                href="${pageContext.request.contextPath}/stock-history-admin"><i
                class="fa-brands fa-stack-overflow"></i> Lịch sử kho</a></li>
        <li class="${active == 'news-admin' ? 'active' : ''}"><a
                href="${pageContext.request.contextPath}/news-admin"><i class="fa-regular fa-newspaper"></i>
            Tin tức</a></li>
        <li class="${active == 'payment-admin' ? 'active' : ''}"><a
                href="${pageContext.request.contextPath}/payment-admin"><i class="fa-regular fa-credit-card"></i>
            Thanh toán</a></li>
        <li class="${active == 'transport-admin' ? 'active' : ''}"><a
                href="${pageContext.request.contextPath}/transport-admin"><i class="fa-regular fa-truck"></i>
            Vận chuyển</a></li>
        <li class="${active == 'origin-admin' ? 'active' : ''}"><a
                href="${pageContext.request.contextPath}/origin-admin"><i class="fa-solid fa-location-dot"></i>
            Xuất xứ</a></li>
        <li class="${active == 'feedback-admin' ? 'active' : ''}"><a
                href="${pageContext.request.contextPath}/feedback-admin"><i class="fa-regular fa-star"></i>
            Phản hồi</a></li>
        <li class="${active == 'system-admin' ? 'active' : ''}"><a
                href="${pageContext.request.contextPath}/system-admin"><i class="fa-solid fa-gear"></i>
            Cấu hình hệ thống</a></li>

    </ul>
    <div class="nav-footer">
        <p>© 2026 CleanMeat Admin</p>
    </div>
</nav>
<main>
    <div class="container">
        <header class="main-header">
            <button class="header-btn"><i class="fa-solid fa-outdent"></i></button>
            <h1 class="header-title">${requestScope.adminTitle}</h1>
            <div class="header-user">
                <button class="header-btn">
                    <i class="fa-regular fa-bell"></i>
                    <span id="noti-count">0</span>
                </button>
                <div class="user-info">
                    <div class="user-name">
                        <span>${user.name}</span>
                        <span>Quản trị viên</span>
                    </div>
                    <img src="${pageContext.request.contextPath}${user.avatar}" class="user-avatar">
                    <button class="user-down"><i class="fa-solid fa-angle-down"></i></button>
                </div>
            </div>
        </header>
        <div class="page-content">
            <c:import url="${requestScope.pageContent}"></c:import>
        </div>
    </div>
</main>
</body>
</html>
