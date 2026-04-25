package cleanmeat.cleanmeat.controller;

import cleanmeat.cleanmeat.model.Orders;
import cleanmeat.cleanmeat.model.User;
import cleanmeat.cleanmeat.service.OrdersService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "orderDetails", value = "/order-details")
public class OrderDetails extends HttpServlet {
    private OrdersService ordersService = new OrdersService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/signin");
            return;
        }

        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/order-history");
            return;
        }

        try {
            int orderId = Integer.parseInt(idParam);
            Orders order = ordersService.getOrderDetail(orderId);

            if (order == null || order.getUser_id() != user.getId()) {
                response.sendRedirect(request.getContextPath() + "/order-history");
                return;
            }

            request.setAttribute("order", order);
            request.setAttribute("pageTitle", "Chi tiết đơn hàng " + order.getShortOrderID());
            request.setAttribute("pageContent", "/view/customer/orderdetails.jsp");
            request.setAttribute("pageCss", "orderdetails.css");
            request.getRequestDispatcher("/view/customer/base.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/order-history");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
