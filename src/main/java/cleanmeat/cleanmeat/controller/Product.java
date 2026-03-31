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
        int page = 1;
        int pageSize = 6;
        String pageParam = request.getParameter("page");
        if (pageParam != null) {
            page = Integer.parseInt(pageParam);
        }
        String category = request.getParameter("category");
        String price = request.getParameter("price");
        String sort = request.getParameter("sort");
        int totalItems = itemDAO.countItems();
        int totalPages = (int) Math.ceil((double) totalItems / pageSize);
        List<Item> items = itemDAO.getItemsByPage(page, pageSize, category, price, sort);

        request.setAttribute("items", items);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalItems", totalItems);
        request.setAttribute("pageTitle", "Sản phẩm");
        request.setAttribute("pageContent", "/view/product.jsp");
        request.setAttribute("pageCss", "product.css");
        request.setAttribute("active", "product");

        request.getRequestDispatcher("/view/base.jsp").forward(request, response);
    }
}