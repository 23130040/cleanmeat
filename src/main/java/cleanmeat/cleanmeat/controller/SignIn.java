package cleanmeat.cleanmeat.controller;

import cleanmeat.cleanmeat.model.User;
import cleanmeat.cleanmeat.service.UserService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "sign-in", value = "/sign-in")
public class SignIn extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("pageTitle", "Đăng nhập");
        request.setAttribute("pageContent", "/view/customer/signin.jsp");
        request.setAttribute("pageCss", "signin.css");
        request.getRequestDispatcher("/view/customer/base.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserService userService = new UserService();
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        String error = userService.validateSignIn(email, password);
        if (error != null) {
            request.setAttribute("error", error);
            request.setAttribute("pageTitle", "Đăng nhập");
            request.setAttribute("pageContent", "/view/signin.jsp");
            request.setAttribute("pageCss", "signin.css");
            request.getRequestDispatcher("/view/base.jsp").forward(request, response);
            return;
        }

        User user = userService.signin(email, password);
        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            if (user.getRole().equalsIgnoreCase("admin")) {
                response.sendRedirect(request.getContextPath() + "/dashboard");
            }
            if (user.getRole().equalsIgnoreCase("customer")) {
                response.sendRedirect(request.getContextPath() + "/home");
            }
        }
    }
}