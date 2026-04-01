package cleanmeat.cleanmeat.controller;

import cleanmeat.cleanmeat.dao.ItemDAO;
import cleanmeat.cleanmeat.dao.ItemDAOImpl;
import cleanmeat.cleanmeat.model.Item;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "home", value = "/home")
public class Home extends HttpServlet {
    private ItemDAO itemDAO = new ItemDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Item> bestSellers = itemDAO.findBestSellers(6);
        request.setAttribute("bestSellers", bestSellers);
        
        request.setAttribute("pageTitle", "Trang chủ");
        request.setAttribute("pageContent", "/view/home.jsp");
        request.setAttribute("pageCss", "home.css");
        request.setAttribute("active", "home");
        request.getRequestDispatcher( "/view/base.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}