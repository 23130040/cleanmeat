package cleanmeat.cleanmeat.controller;

import cleanmeat.cleanmeat.dao.SystemConfigDAO;
import cleanmeat.cleanmeat.dao.SystemConfigDAOImpl;
import cleanmeat.cleanmeat.model.SystemConfig;
import cleanmeat.cleanmeat.model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "system-admin", value = "/system-admin")
public class SystemConfigAdmin extends HttpServlet {
    private SystemConfigDAO systemConfigDAO = new SystemConfigDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        SystemConfig config = systemConfigDAO.getConfig();
        
        request.setAttribute("config", config);
        request.setAttribute("adminTitle", "Cấu hình hệ thống");
        request.setAttribute("active", "system-admin");
        request.setAttribute("user", user);
        request.setAttribute("pageContent", "/view/admin/systemConfigAdmin.jsp");
        request.setAttribute("pageCss", "systemConfigAdmin.css");
        request.setAttribute("pageJs", "systemConfigAdmin.js");
        request.getRequestDispatcher("/view/admin/baseAdmin.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User admin = (User) session.getAttribute("user");
        
        if (admin == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/system-admin?error=missing_id");
            return;
        }

        int id = Integer.parseInt(idParam);
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String hotline = request.getParameter("hotline");
        String tax_code = request.getParameter("tax_code");
        String facebook = request.getParameter("facebook");
        String address = request.getParameter("address");
        String logo_url = request.getParameter("logo_url");
        
        SystemConfig config = new SystemConfig(id, name, email, hotline, tax_code, facebook, address, logo_url, admin.getId());
        
        if (systemConfigDAO.updateConfig(config)) {
            response.sendRedirect(request.getContextPath() + "/system-admin?success=config_updated");
        } else {
            response.sendRedirect(request.getContextPath() + "/system-admin?error=update_failed");
        }
    }
}
