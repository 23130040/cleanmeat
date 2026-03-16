package cleanmeat.cleanmeat.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "returns-policy", value = "/returns-policy")
public class ReturnsPolicy extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("pageTitle", "Chính sách đổi trả");
        request.setAttribute("pageContent", "/view/returnspolicy.jsp");
        request.setAttribute("pageCss", "returnspolicy.css");
        request.getRequestDispatcher( "/view/base.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}