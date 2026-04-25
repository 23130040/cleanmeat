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

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}