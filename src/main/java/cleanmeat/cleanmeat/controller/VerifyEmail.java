package cleanmeat.cleanmeat.controller;

import cleanmeat.cleanmeat.service.UserService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "verify-email", value = "/verify-email")
public class VerifyEmail extends HttpServlet {
    UserService userService = new UserService();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String token = request.getParameter("token");
        boolean success = userService.verifyEmail(token);

        if (success) {
            response.sendRedirect(request.getContextPath() + "/sign-up?verified=true");
        } else {
            response.sendRedirect(request.getContextPath() + "/sign-up?error=invalid-token");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}