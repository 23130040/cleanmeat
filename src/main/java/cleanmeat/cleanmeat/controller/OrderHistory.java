package cleanmeat.cleanmeat.controller;

import cleanmeat.cleanmeat.model.Item;
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
        request.setAttribute("pageTitle", "Lịch sử đơn hàng");
        request.setAttribute("pageContent", "/view/orderhistory.jsp");
        request.setAttribute("pageCss", "orderhistory.css");

        response.setContentType("text/html;charset=UTF-8");
        OrdersService ordersService = new OrdersService();
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/sign-in");
            return;
        }

        request.setAttribute("orders", ordersService.findByUserId(user.getId()));
        request.setAttribute("deliveringOrders", ordersService.findByStatus("delivery", user.getId()));
        request.setAttribute("finishedOrders", ordersService.findByStatus("finished", user.getId()));

        OrderItemService orderItemService = new OrderItemService();
        if (request.getParameter("orderId") != null) {
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            request.setAttribute("orderItems", orderItemService.findByOrderId(orderId));
        }

        ItemService itemService = new ItemService();
        if (request.getParameter("itemId") != null) {
            int itemId = Integer.parseInt(request.getParameter("itemId"));
            Item item = itemService.findById(itemId);
            request.setAttribute("item", item);
            ItemImageService itemImageService = new ItemImageService();
            request.setAttribute("itemPrimaryImageUrl", itemImageService.getPrimaryImageUrl(itemId));
            UnitService unitService = new UnitService();
            request.setAttribute("packaging", unitService.getPackage(item.getUnit_id()));
        }
        request.getRequestDispatcher("/view/base.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }
}