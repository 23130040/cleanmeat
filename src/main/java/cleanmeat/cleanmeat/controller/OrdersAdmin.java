package cleanmeat.cleanmeat.controller;

import cleanmeat.cleanmeat.model.Orders;
import cleanmeat.cleanmeat.model.User;
import cleanmeat.cleanmeat.service.OrdersService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonSerializer;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@WebServlet(name = "orders-admin", value = "/orders-admin")
public class OrdersAdmin extends HttpServlet {
    private final Gson gson;

    public OrdersAdmin() {
        this.gson = new GsonBuilder()
                .registerTypeAdapter(LocalDateTime.class, (JsonSerializer<LocalDateTime>) (src, typeOfSrc, context) -> 
                    context.serialize(src.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"))))
                .create();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        OrdersService ordersService = new OrdersService();

        if ("getDetail".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            Orders order = ordersService.getOrderDetail(id);
            
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            PrintWriter out = response.getWriter();
            out.print(gson.toJson(order));
            out.flush();
            return;
        }

        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

        int countPending = ordersService.countOrdersByStatus("pending") + ordersService.countOrdersByStatus("Chờ xác nhận");
        int countDelivery = ordersService.countOrdersByStatus("delivery") + ordersService.countOrdersByStatus("Đang xử lý");
        int countFinished = ordersService.countOrdersByStatus("finished") + ordersService.countOrdersByStatus("Hoàn thành");
        int countCancelled = ordersService.countOrdersByStatus("cancelled") + ordersService.countOrdersByStatus("Đã hủy");
        
        request.setAttribute("countPending", countPending);
        request.setAttribute("countDelivery", countDelivery);
        request.setAttribute("countFinished", countFinished);
        request.setAttribute("countCancelled", countCancelled);

        String statusParam = request.getParameter("status");
        String searchParam = request.getParameter("search");
        
        // Keep original status for UI highlighting
        request.setAttribute("currentStatus", statusParam);
        request.setAttribute("currentSearch", searchParam);

        // Map UI status to DB status
        String dbStatus = null;
        if ("pending".equals(statusParam) || "Chờ duyệt".equals(statusParam)) dbStatus = "Chờ xác nhận";
        else if ("processing".equals(statusParam) || "Đang xử lý".equals(statusParam)) dbStatus = "Đang xử lý";
        else if ("finished".equals(statusParam) || "Hoàn thành".equals(statusParam)) dbStatus = "Hoàn thành";
        else if ("cancelled".equals(statusParam) || "Đã huỷ".equals(statusParam)) dbStatus = "Đã hủy";

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
        
        int totalItems = ordersService.countFilteredOrders(dbStatus, searchParam);
        int totalPages = (int) Math.ceil((double) totalItems / limit);
        
        if (page > totalPages && totalPages > 0) {
            page = totalPages;
        } else if (page < 1) {
            page = 1;
        }
        
        int offset = (page - 1) * limit;

        List<Orders> orders = ordersService.getFilteredOrders(dbStatus, searchParam, limit, offset);
        
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
        request.setAttribute("pageJs", "ordersAdmin.js");
        
        request.getRequestDispatcher("/view/admin/baseAdmin.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        OrdersService ordersService = new OrdersService();
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

        if ("updateStatus".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            String status = request.getParameter("status");
            String note = request.getParameter("note");
            String changedBy = (currentUser != null) ? currentUser.getName() : "System";

            boolean success = ordersService.updateOrderStatus(id, status, changedBy, note);
            
            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            if (success) {
                out.print("{\"success\": true}");
            } else {
                out.print("{\"success\": false, \"message\": \"Failed to update status\"}");
            }
            out.flush();
        }
    }
}
