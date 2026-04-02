<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/newsdetail.css">



        <div class="news-list">
            <div class="container">
                <div class="news-layout">
                    <div class="main-news newsdetail-main">

                        <h1 class="newsdetail-title">
                            ${news.title}</h1>
                        <p class="newsdetail-meta">
                            <i class="fa-solid fa-calendar-days"></i>
                            ${news.created_at.dayOfMonth}/${news.created_at.monthValue}/${news.created_at.year}
                            &nbsp;&nbsp;&nbsp;
                            <i class="fa-solid fa-user"></i> ${news.author}
                        </p>

                        <div class="newsdetail-image">
                            <img src="${news.picture_url}" alt="${news.title}"
                                onerror="this.src='https://placehold.co/800x400/png?text=News'">
                        </div>

                        <div class="newsdetail-content">
                            ${news.content}
                        </div>
                        
                        <div style="margin-top: 40px;">
                            <a href="${pageContext.request.contextPath}/news" class="read-more"><i
                                    class="fa-solid fa-arrow-left"></i> Quay lại trang tin tức</a>
                        </div>
                    </div>
                    <div class="sidebar-news">
                        <h3 class="sidebar-title">TIN TỨC MỚI NHẤT</h3>
                        <div class="latest-news-list">
                            <c:forEach var="ln" items="${latestNews}">
                                <div class="latest-news-item">
                                    <div class="latest-img">
                                        <img src="${ln.picture_url}" alt="${ln.title}"
                                            onerror="this.src='https://placehold.co/100x100/png?text=News'">
                                    </div>
                                    <div class="latest-info">
                                        <h4><a
                                                href="${pageContext.request.contextPath}/newsdetail?id=${ln.id}">${ln.title}</a>
                                        </h4>
                                        <span
                                            class="latest-date">${ln.created_at.dayOfMonth}/${ln.created_at.monthValue}/${ln.created_at.year}</span>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
        </div>