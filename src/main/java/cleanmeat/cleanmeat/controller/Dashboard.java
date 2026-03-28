package cleanmeat.cleanmeat.controller;

import cleanmeat.cleanmeat.model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "dashboard", value = "/dashboard")
public class Dashboard extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        request.setAttribute("pageContent", "/view/admin/dashboard.jsp");
        request.setAttribute("pageCss", "dashboard.css");
        request.setAttribute("active", "dashboard");
        request.setAttribute("user", user);
        request.getRequestDispatcher("/view/admin/baseAdmin.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}