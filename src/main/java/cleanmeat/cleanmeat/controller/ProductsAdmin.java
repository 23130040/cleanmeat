package cleanmeat.cleanmeat.controller;

import cleanmeat.cleanmeat.model.Item;
import cleanmeat.cleanmeat.model.User;
import cleanmeat.cleanmeat.service.ItemService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "products-admin", value = "/products-admin")
public class ProductsAdmin extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

        ItemService itemService = new ItemService();

        int page = 1;
        int limit = 10;
        
        String pageParam = request.getParameter("page");
        if (pageParam != null && !pageParam.isEmpty()) {
            try {
                page = Integer.parseInt(pageParam);
            } catch (NumberFormatException e) {
                page = 1;
            }
        }
        
        int totalItems = itemService.countAllItems();
        int totalPages = (int) Math.ceil((double) totalItems / limit);
        
        if (page > totalPages && totalPages > 0) {
            page = totalPages;
        } else if (page < 1) {
            page = 1;
        }
        
        int offset = (page - 1) * limit;

        List<Item> items = itemService.getItemsByPage(limit, offset);
        
        request.setAttribute("items", items);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalItems", totalItems);
        request.setAttribute("limit", limit);
        request.setAttribute("offset", offset);
        
        request.setAttribute("adminTitle", "Quản lý sản phẩm");
        request.setAttribute("active", "productsAdmin");
        request.setAttribute("user", currentUser);
        request.setAttribute("pageContent", "/view/admin/productsAdmin.jsp");
        request.setAttribute("pageCss", "productsAdmin.css");
        
        request.getRequestDispatcher("/view/admin/baseAdmin.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
