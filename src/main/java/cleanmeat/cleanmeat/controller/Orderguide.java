package cleanmeat.cleanmeat.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "order-guide", value = "/order-guide")
public class Orderguide extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("pageTitle", "Hướng dẫn đặt hàng");
        request.setAttribute("pageContent", "/view/customer/orderguide.jsp");
        request.setAttribute("pageCss", "orderguide.css");

        request.getRequestDispatcher("/view/customer/base.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }
}