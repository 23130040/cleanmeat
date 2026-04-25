package cleanmeat.cleanmeat.controller;

import cleanmeat.cleanmeat.model.ItemImages;
import cleanmeat.cleanmeat.model.User;
import cleanmeat.cleanmeat.service.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "order-history", value = "/order-history")
public class OrderHistory extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/sign-in");
            return;
        }

        OrdersService ordersService = new OrdersService();
        java.util.List<cleanmeat.cleanmeat.model.Orders> allOrders = ordersService.getOrdersDetailedByUserId(user.getId());
        
        request.setAttribute("orders", allOrders);
        request.setAttribute("deliveringOrders", allOrders.stream()
                .filter(o -> "delivery".equalsIgnoreCase(o.getStatus()))
                .toList());
        request.setAttribute("finishedOrders", allOrders.stream()
                .filter(o -> "finished".equalsIgnoreCase(o.getStatus()))
                .toList());

        request.setAttribute("pageTitle", "Lịch sử đơn hàng");
        request.setAttribute("pageContent", "/view/customer/orderhistory.jsp");
        request.setAttribute("pageCss", "orderhistory.css");
        request.getRequestDispatcher("/view/customer/base.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }
}