package cleanmeat.cleanmeat.controller;

import cleanmeat.cleanmeat.model.User;
import cleanmeat.cleanmeat.service.ItemService;
import cleanmeat.cleanmeat.service.OrdersService;
import cleanmeat.cleanmeat.service.UserService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "dashboard", value = "/dashboard")
public class Dashboard extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        UserService userService = new UserService();
        OrdersService ordersService = new OrdersService();
        ItemService itemService = new ItemService();

        int totalUsers = userService.countTotalUsers();
        int totalOrders = ordersService.countAllOrders();
        double totalRevenue = ordersService.sumTotalRevenue();
        int totalProducts = itemService.countAllItems();

        int todayOrders = ordersService.countTodayOrders();
        double todayRevenue = ordersService.sumTodayRevenue();
        int pendingOrders = ordersService.countOrdersByStatus("Chờ duyệt") + ordersService.countOrdersByStatus("Đang xử lý");
        int lowStockProducts = itemService.countLowStockItems();

        double userGrowth = userService.calculateUserGrowth();
        double orderGrowth = ordersService.calculateOrderGrowth();
        double revenueGrowth = ordersService.calculateRevenueGrowth();

        java.util.List<cleanmeat.cleanmeat.model.Item> topSellingItems = itemService.getTopSellingItems(5);
        int maxSold = topSellingItems.isEmpty() ? 1 : topSellingItems.get(0).getTotal_sold();
        if (maxSold == 0) maxSold = 1;

        java.util.List<cleanmeat.cleanmeat.model.Orders> recentOrders = ordersService.getOrdersByPage(5, 0);

        int countCompleted = ordersService.countOrdersByStatus("Hoàn thành");
        int countProcessing = ordersService.countOrdersByStatus("Đang xử lý");
        int countPending = ordersService.countOrdersByStatus("Chờ duyệt");
        int countCancelled = ordersService.countOrdersByStatus("Đã hủy");
        
        double percentCompleted = totalOrders > 0 ? (countCompleted * 100.0 / totalOrders) : 0;
        double percentProcessing = totalOrders > 0 ? (countProcessing * 100.0 / totalOrders) : 0;
        double percentPending = totalOrders > 0 ? (countPending * 100.0 / totalOrders) : 0;
        double percentCancelled = totalOrders > 0 ? (countCancelled * 100.0 / totalOrders) : 0;

        request.setAttribute("totalUsers", totalUsers);
        request.setAttribute("totalOrders", totalOrders);
        request.setAttribute("totalRevenue", totalRevenue);
        request.setAttribute("totalProducts", totalProducts);
        
        request.setAttribute("todayOrders", todayOrders);
        request.setAttribute("todayRevenue", todayRevenue);
        request.setAttribute("pendingOrders", pendingOrders);
        request.setAttribute("lowStockProducts", lowStockProducts);
        request.setAttribute("topSellingItems", topSellingItems);
        request.setAttribute("maxSold", maxSold);
        request.setAttribute("recentOrders", recentOrders);
        
        request.setAttribute("userGrowth", userGrowth);
        request.setAttribute("orderGrowth", orderGrowth);
        request.setAttribute("revenueGrowth", revenueGrowth);
        
        request.setAttribute("percentCompleted", percentCompleted);
        request.setAttribute("percentProcessing", percentProcessing);
        request.setAttribute("percentPending", percentPending);
        request.setAttribute("percentCancelled", percentCancelled);

        request.setAttribute("pageContent", "/view/admin/dashboard.jsp");
        request.setAttribute("pageCss", "dashboard.css");
        request.setAttribute("active", "dashboard");
        request.setAttribute("user", user);
        request.getRequestDispatcher("/view/admin/baseAdmin.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}