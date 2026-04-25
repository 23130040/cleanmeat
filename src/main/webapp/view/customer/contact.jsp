<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="contact-page">
  <div class="container">

    <div class="contact-header">
      <h1 class="normal-title">LIÊN HỆ VỚI CHÚNG TÔI</h1>
      <p class="contact-description">
        Chúng tôi luôn sẵn sàng lắng nghe và hỗ trợ bạn. Hãy để lại thông tin,
        chúng tôi sẽ liên hệ lại trong thời gian sớm nhất.
      </p>
    </div>

    <div class="contact-wrapper">

      <div class="contact-info">

        <h3 class="sub-normal-title">Thông Tin Liên Hệ</h3>

        <div class="contact-item">
          <div class="contact-icon location-icon">
            <i class="fa-solid fa-location-dot"></i>
          </div>
          <div class="contact-detail">
            <h4>Địa Chỉ</h4>
            <p>123 Đường Nguyễn Văn Linh, Quận 7</p>
            <p>Thành phố Hồ Chí Minh, Việt Nam</p>
          </div>
        </div>

        <div class="contact-item">
          <div class="contact-icon phone-icon">
            <i class="fa-solid fa-phone"></i>
          </div>
          <div class="contact-detail">
            <h4>Điện Thoại</h4>
            <p>Hotline: 1900 xxxx</p>
            <p>Mobile: 0901 xxx xxx</p>
          </div>
        </div>

        <div class="contact-item">
          <div class="contact-icon email-icon">
            <i class="fa-solid fa-envelope"></i>
          </div>
          <div class="contact-detail">
            <h4>Email</h4>
            <p>info@thitsach.vn</p>
            <p>support@thitsach.vn</p>
          </div>
        </div>

        <div class="contact-item">
          <div class="contact-icon time-icon">
            <i class="fa-solid fa-clock"></i>
          </div>
          <div class="contact-detail">
            <h4>Giờ Làm Việc</h4>
            <p>Thứ 2 - Thứ 7: 7:00 - 21:00</p>
            <p>Chủ Nhật: 8:00 - 20:00</p>
          </div>
        </div>

        <div class="contact-social">
          <h4>Theo Dõi Chúng Tôi</h4>

          <div class="social-list">
            <a><i class="fa-brands fa-facebook-f"></i></a>
            <a><i class="fa-brands fa-instagram"></i></a>
            <a><i class="fa-brands fa-youtube"></i></a>
            <a><i class="fa-brands fa-twitter"></i></a>
          </div>
        </div>

      </div>

      <div class="contact-form">

        <h3 class="sub-normal-title">Gửi Tin Nhắn</h3>

        <c:if test="${not empty successMessage}">
            <div style="color: #10b981; background: #d1fae5; padding: 15px; border-radius: 8px; margin-bottom: 20px; font-weight: bold;">
                <i class="fa-solid fa-circle-check"></i> ${successMessage}
            </div>
        </c:if>

        <c:if test="${not empty errorMessage}">
            <div style="color: #ef4444; background: #fee2e2; padding: 15px; border-radius: 8px; margin-bottom: 20px; font-weight: bold;">
                <i class="fa-solid fa-circle-exclamation"></i> ${errorMessage}
            </div>
        </c:if>

        <form method="post">

          <label>Họ và tên *</label>
          <input type="text" name="name">

          <label>Email *</label>
          <input type="email" name="email">

          <label>Số điện thoại</label>
          <input type="text" name="phone">

          <label>Tin nhắn *</label>
          <textarea name="message"></textarea>

          <button type="submit">GỬI TIN NHẮN</button>

        </form>

      </div>

    </div>

  </div>
</div>