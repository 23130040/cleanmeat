package cleanmeat.cleanmeat.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "contact", value = "/contact")
public class Contact extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("pageTitle", "Liên hệ");
        request.setAttribute("pageContent", "/view/customer/contact.jsp");
        request.setAttribute("pageCss", "contact.css");
        request.setAttribute("active", "contact");
        request.getRequestDispatcher("/view/customer/base.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String message = request.getParameter("message");

        cleanmeat.cleanmeat.model.Contact contact = new cleanmeat.cleanmeat.model.Contact();
        contact.setFull_name(name);
        contact.setEmail(email);
        contact.setSubject("SĐT: " + phone);
        contact.setMessage(message);

        cleanmeat.cleanmeat.dao.ContactDAO contactDAO = new cleanmeat.cleanmeat.dao.ContactDAOImpl();
        boolean success = contactDAO.insert(contact);

        if (success) {
            request.setAttribute("successMessage", "Gửi yêu cầu liên hệ thành công! Chúng tôi sẽ phản hồi bạn sớm nhất.");
        } else {
            request.setAttribute("errorMessage", "Đã xảy ra lỗi khi gửi yêu cầu. Vui lòng thử lại sau.");
        }

        doGet(request, response);
    }
}