package cleanmeat.cleanmeat.controller;

import cleanmeat.cleanmeat.service.UserService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "forgot-password", value = "/forgot-password")
public class ForgotPassword extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        UserService userService = new UserService();
        
        String error = userService.initiateForgotPassword(email);
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        if (error == null) {
            response.getWriter().write("{\"success\": true}");
        } else {
            response.getWriter().write("{\"success\": false, \"message\": \"" + error + "\"}");
        }
    }
}
