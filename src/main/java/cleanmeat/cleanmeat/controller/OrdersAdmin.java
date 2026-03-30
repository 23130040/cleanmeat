package cleanmeat.cleanmeat.controller;

import cleanmeat.cleanmeat.model.Orders;
import cleanmeat.cleanmeat.model.User;
import cleanmeat.cleanmeat.service.OrdersService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "orders-admin", value = "/orders-admin")
public class OrdersAdmin extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

        OrdersService ordersService = new OrdersService();

        int countPending = ordersService.countOrdersByStatus("pending");
        int countDelivery = ordersService.countOrdersByStatus("delivery");
        int countFinished = ordersService.countOrdersByStatus("finished");
        int countCancelled = ordersService.countOrdersByStatus("cancelled");
        
        request.setAttribute("countPending", countPending);
        request.setAttribute("countDelivery", countDelivery);
        request.setAttribute("countFinished", countFinished);
        request.setAttribute("countCancelled", countCancelled);

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
        
        int totalItems = ordersService.countAllOrders();
        int totalPages = (int) Math.ceil((double) totalItems / limit);
        
        if (page > totalPages && totalPages > 0) {
            page = totalPages;
        } else if (page < 1) {
            page = 1;
        }
        
        int offset = (page - 1) * limit;

        List<Orders> orders = ordersService.getOrdersByPage(limit, offset);
        
        request.setAttribute("orders", orders);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalItems", totalItems);
        request.setAttribute("limit", limit);
        request.setAttribute("offset", offset);
        
        request.setAttribute("adminTitle", "Quản lý đơn hàng");
        request.setAttribute("active", "orders-admin");
        request.setAttribute("user", currentUser);
        request.setAttribute("pageContent", "/view/admin/ordersAdmin.jsp");
        request.setAttribute("pageCss", "ordersAdmin.css");
        
        request.getRequestDispatcher("/view/admin/baseAdmin.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
