package cleanmeat.cleanmeat.controller;

import cleanmeat.cleanmeat.dao.OriginDAO;
import cleanmeat.cleanmeat.dao.OriginDAOImpl;
import cleanmeat.cleanmeat.model.Origin;
import cleanmeat.cleanmeat.model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "origin-admin", value = "/origin-admin")
public class OriginAdmin extends HttpServlet {
    private OriginDAO originDAO = new OriginDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

        List<Origin> origins = originDAO.findAll();

        request.setAttribute("origins", origins);
        request.setAttribute("adminTitle", "Quản lý xuất xứ");
        request.setAttribute("active", "origin-admin");
        request.setAttribute("user", currentUser);
        request.setAttribute("pageContent", "/view/admin/originAdmin.jsp");
        request.setAttribute("pageCss", "originAdmin.css");
        request.setAttribute("pageJs", "originAdmin.js");
        request.getRequestDispatcher("/view/admin/baseAdmin.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("add".equals(action)) {
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            
            Origin origin = new Origin();
            origin.setName(name);
            origin.setDescription(description);
            
            originDAO.insert(origin);
            response.sendRedirect(request.getContextPath() + "/origin-admin?success=origin_added");
        } else if ("edit".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            
            Origin origin = new Origin();
            origin.setId(id);
            origin.setName(name);
            origin.setDescription(description);
            
            originDAO.update(origin);
            response.sendRedirect(request.getContextPath() + "/origin-admin?success=origin_updated");
        } else if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            originDAO.delete(id);
            response.sendRedirect(request.getContextPath() + "/origin-admin?success=origin_deleted");
        }
    }
}
