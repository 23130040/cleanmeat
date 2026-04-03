package cleanmeat.cleanmeat.controller;

import cleanmeat.cleanmeat.service.UserService;
import cleanmeat.cleanmeat.validate.UserValidate;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "reset-password", value = "/reset-password")
public class ResetPassword extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String token = request.getParameter("token");
        
        if (token == null || token.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/sign-in");
            return;
        }

        request.setAttribute("token", token);
        request.setAttribute("pageTitle", "Đặt lại mật khẩu");
        request.setAttribute("pageContent", "/view/resetpassword.jsp");
        request.setAttribute("pageCss", "signin.css");
        request.getRequestDispatcher("/view/base.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String token = request.getParameter("token");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        
        UserService userService = new UserService();
        
        String error = null;
        if (password == null || password.trim().isEmpty()) {
            error = "Mật khẩu không được để trống!";
        } else if (!password.equals(confirmPassword)) {
            error = "Mật khẩu xác nhận không khớp!";
        } else if (!UserValidate.passwordValidate(password)) {
            error = "Mật khẩu không đủ mạnh! (Ít nhất 8 ký tự, bao gồm chữ hoa, chữ thường, số và ký tự đặc biệt)";
        }
        
        if (error != null) {
            request.setAttribute("error", error);
            request.setAttribute("token", token);
            request.setAttribute("pageTitle", "Đặt lại mật khẩu");
            request.setAttribute("pageContent", "/view/resetpassword.jsp");
            request.setAttribute("pageCss", "signin.css");
            request.getRequestDispatcher("/view/base.jsp").forward(request, response);
            return;
        }

        boolean success = userService.resetPasswordWithToken(token, password);
        if (success) {
            request.setAttribute("message", "Đặt lại mật khẩu thành công! Vui lòng đăng nhập lại.");
            request.setAttribute("pageTitle", "Đăng nhập");
            request.setAttribute("pageContent", "/view/signin.jsp");
            request.setAttribute("pageCss", "signin.css");
            request.getRequestDispatcher("/view/base.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Link đã hết hạn hoặc không hợp lệ!");
            request.setAttribute("token", token);
            request.setAttribute("pageTitle", "Đặt lại mật khẩu");
            request.setAttribute("pageContent", "/view/resetpassword.jsp");
            request.setAttribute("pageCss", "signin.css");
            request.getRequestDispatcher("/view/base.jsp").forward(request, response);
        }
    }
}
