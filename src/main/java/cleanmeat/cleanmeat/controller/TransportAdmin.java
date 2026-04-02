package cleanmeat.cleanmeat.controller;

import cleanmeat.cleanmeat.dao.TransportDAO;
import cleanmeat.cleanmeat.dao.TransportDAOImpl;
import cleanmeat.cleanmeat.model.Transport;
import cleanmeat.cleanmeat.model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "transport-admin", value = "/transport-admin")
public class TransportAdmin extends HttpServlet {
    private TransportDAO transportDAO = new TransportDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

        List<Transport> transports = transportDAO.findAll();

        request.setAttribute("transports", transports);
        request.setAttribute("adminTitle", "Quản lý đơn vị vận chuyển");
        request.setAttribute("active", "transport-admin");
        request.setAttribute("user", currentUser);
        request.setAttribute("pageContent", "/view/admin/transportAdmin.jsp");
        request.setAttribute("pageCss", "transportAdmin.css");
        request.setAttribute("pageJs", "transportAdmin.js");
        request.getRequestDispatcher("/view/admin/baseAdmin.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("toggleStatus".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            boolean status = Boolean.parseBoolean(request.getParameter("status"));
            transportDAO.updateStatus(id, status);
            response.sendRedirect(request.getContextPath() + "/transport-admin?success=transport_updated");
        } else if ("add".equals(action)) {
            String name = request.getParameter("name");
            int fee = Integer.parseInt(request.getParameter("base_fee"));
            int days = Integer.parseInt(request.getParameter("estimated_day"));
            int freeShip = Integer.parseInt(request.getParameter("free_ship"));
            boolean status = request.getParameter("status") != null;
            
            Transport transport = new Transport();
            transport.setName(name);
            transport.setBase_fee(fee);
            transport.setEstimate_day(days);
            transport.setFree_ship(freeShip);
            transport.setStatus(status);
            
            transportDAO.insert(transport);
            response.sendRedirect(request.getContextPath() + "/transport-admin?success=transport_added");
        } else if ("edit".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            int fee = Integer.parseInt(request.getParameter("base_fee"));
            int days = Integer.parseInt(request.getParameter("estimated_day"));
            int freeShip = Integer.parseInt(request.getParameter("free_ship"));
            
            Transport transport = new Transport();
            transport.setId(id);
            transport.setName(name);
            transport.setBase_fee(fee);
            transport.setEstimate_day(days);
            transport.setFree_ship(freeShip);
            transport.setStatus(true);
            
            transportDAO.update(transport);
            response.sendRedirect(request.getContextPath() + "/transport-admin?success=transport_updated");
        } else if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            transportDAO.delete(id);
            response.sendRedirect(request.getContextPath() + "/transport-admin?success=transport_deleted");
        }
    }
}
