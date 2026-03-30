package cleanmeat.cleanmeat.controller;

import cleanmeat.cleanmeat.model.User;
import cleanmeat.cleanmeat.service.UserService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "user-admin", value = "/user-admin")
public class UserAdmin extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

        UserService userService = new UserService();
        List<User> users = userService.getAllUsers();
        
        request.setAttribute("users", users);
        request.setAttribute("adminTitle", "Quản lý người dùng");
        request.setAttribute("active", "user-admin");
        request.setAttribute("user", currentUser);
        request.setAttribute("pageContent", "/view/admin/userAdmin.jsp");
        request.setAttribute("pageCss", "userAdmin.css");
        
        request.getRequestDispatcher("/view/admin/baseAdmin.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
