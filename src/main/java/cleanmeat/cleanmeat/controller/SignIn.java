package cleanmeat.cleanmeat.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "sign-in", value = "/sign-in")
public class SignIn extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("pageTitle", "Đăng nhập");
        request.setAttribute("pageContent", "/view/signin.jsp");
        request.setAttribute("pageCss", "signin.css");
        request.getRequestDispatcher( "/view/base.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}