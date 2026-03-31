package cleanmeat.cleanmeat.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import cleanmeat.cleanmeat.dao.ItemDAO;
import cleanmeat.cleanmeat.dao.ItemDAOImpl;
import cleanmeat.cleanmeat.model.Item;

import java.io.IOException;

@WebServlet(name = "product-detail", value = "/product-detail")
public class ProductDetail extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ItemDAO itemDAO = new ItemDAOImpl();
        int id = Integer.parseInt(request.getParameter("id"));
        Item item = itemDAO.findById(id);
        request.setAttribute("item", item);
        request.setAttribute("pageTitle", "Chi tiết sản phẩm");
        request.setAttribute("pageContent", "/view/productdetail.jsp");
        request.setAttribute("pageCss", "productdetail.css");
        request.setAttribute("active", "product");
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        request.getRequestDispatcher("/view/base.jsp").forward(request, response);
    }
}