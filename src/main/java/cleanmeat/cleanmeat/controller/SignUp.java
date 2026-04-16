package cleanmeat.cleanmeat.controller;

import cleanmeat.cleanmeat.service.UserService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "sign-up", value = "/sign-up")
public class SignUp extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("pageTitle", "Đăng ký");
        request.setAttribute("pageContent", "/view/customer/signup.jsp");
        request.setAttribute("pageCss", "signup.css");
        request.setAttribute("pageJs", "signup.js");
        request.getRequestDispatcher("/view/base.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        UserService userService = new UserService();
        String error = userService.validateSignUp(username, email, phone, password, confirmPassword);

        if (error != null) {
            request.setAttribute("error", error);
            request.setAttribute("pageTitle", "Đăng ký");
            request.setAttribute("pageContent", "/view/signup.jsp");
            request.setAttribute("pageCss", "signup.css");
            request.setAttribute("pageJs", "signup.js");
            request.getRequestDispatcher("/view/base.jsp").forward(request, response);
            return;
        }
        if (userService.signUp(username, email, phone, password)) {
            response.sendRedirect(request.getContextPath() + "/sign-up?signup=success");
        } else {
            response.sendRedirect(request.getContextPath() + "/sign-up?error=signup-failed");
        }
    }
}