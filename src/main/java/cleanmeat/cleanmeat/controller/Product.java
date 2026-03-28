package cleanmeat.cleanmeat.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import cleanmeat.cleanmeat.dao.ItemDAO;
import cleanmeat.cleanmeat.dao.ItemDAOImpl;
import cleanmeat.cleanmeat.model.Item;
import java.util.List;
import java.io.IOException;

@WebServlet(name = "product", value = "/product")
public class Product extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ItemDAO itemDAO = new ItemDAOImpl();
        List<Item> items = itemDAO.findAll();
        request.setAttribute("items", items);

        request.setAttribute("pageTitle", "Sản phẩm");
        request.setAttribute("pageContent", "/view/product.jsp");
        request.setAttribute("pageCss", "product.css");
        request.setAttribute("active", "product");
        request.getRequestDispatcher("/view/base.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}