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
        String keyword = request.getParameter("keyword");

        List<Item> fetchItems = itemDAO.getItemsByPage(1, Integer.MAX_VALUE, "", price, sort);
        List<Item> finalItems = new java.util.ArrayList<>();

        int targetCat = -1;
        if (category != null && !category.trim().isEmpty()) {
            targetCat = Integer.parseInt(category.trim());
        }

        String query = "";
        if (keyword != null && !keyword.trim().isEmpty()) {
            query = keyword.trim().toLowerCase();
        }

        for (Item it : fetchItems) {
            boolean matchCat = (targetCat == -1) || (it.getCategory_id() == targetCat);
            boolean matchKw = query.isEmpty() || it.getName().toLowerCase().contains(query);
            if (matchCat && matchKw) {
                finalItems.add(it);
            }
        }

        int totalItems = finalItems.size();
        int totalPages = (int) Math.ceil((double) totalItems / pageSize);

        int start = (page - 1) * pageSize;
        int end = Math.min(start + pageSize, totalItems);

        List<Item> items = new java.util.ArrayList<>();
        if (start < totalItems) {
            items = finalItems.subList(start, end);
        }

        request.setAttribute("items", items);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalItems", totalItems);
        request.setAttribute("pageTitle", "Sản phẩm");
        request.setAttribute("pageContent", "/view/product.jsp");
        request.setAttribute("pageCss", "product.css");
        request.setAttribute("active", "product");
        request.setAttribute("pageJs", "product.js");
        request.getRequestDispatcher("/view/base.jsp").forward(request, response);
    }
}