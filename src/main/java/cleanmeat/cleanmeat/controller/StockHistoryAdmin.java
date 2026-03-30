package cleanmeat.cleanmeat.controller;

import cleanmeat.cleanmeat.model.StockHistory;
import cleanmeat.cleanmeat.model.User;
import cleanmeat.cleanmeat.service.StockHistoryService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "stock-history-admin", value = "/stock-history-admin")
public class StockHistoryAdmin extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

        StockHistoryService stockHistoryService = new StockHistoryService();
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

        int totalItems = stockHistoryService.countAllHistory();
        int totalPages = (int) Math.ceil((double) totalItems / limit);

        if (page > totalPages && totalPages > 0) {
            page = totalPages;
        } else if (page < 1) {
            page = 1;
        }

        int offset = (page - 1) * limit;

        List<StockHistory> historyList = stockHistoryService.getHistoryByPage(limit, offset);

        int sumImport = stockHistoryService.getSumQuantityByType("import");
        if (sumImport == 0) sumImport = stockHistoryService.getSumQuantityByType("Nhập kho");

        int sumExport = stockHistoryService.getSumQuantityByType("export");
        if (sumExport == 0) sumExport = stockHistoryService.getSumQuantityByType("Xuất kho");

        request.setAttribute("historyList", historyList);
        request.setAttribute("sumImport", sumImport);
        request.setAttribute("sumExport", sumExport);

        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalItems", totalItems);
        request.setAttribute("limit", limit);
        request.setAttribute("offset", offset);

        request.setAttribute("adminTitle", "Lịch sử kho hàng");
        request.setAttribute("active", "inventory-admin");
        request.setAttribute("user", currentUser);
        request.setAttribute("pageContent", "/view/admin/stockhistoryadmin.jsp");
        request.setAttribute("pageCss", "inventoryAdmin.css");

        request.getRequestDispatcher("/view/admin/baseAdmin.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
