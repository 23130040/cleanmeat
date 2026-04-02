package cleanmeat.cleanmeat.controller;

import cleanmeat.cleanmeat.dao.ContactDAO;
import cleanmeat.cleanmeat.dao.ContactDAOImpl;
import cleanmeat.cleanmeat.model.Contact;
import cleanmeat.cleanmeat.model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "contact-admin", value = "/contact-admin")
public class ContactAdmin extends HttpServlet {
    private ContactDAO contactDAO = new ContactDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        List<Contact> contacts = contactDAO.findAll();
        
        request.setAttribute("contacts", contacts);
        request.setAttribute("adminTitle", "Quản lý liên hệ");
        request.setAttribute("active", "contact-admin");
        request.setAttribute("user", user);
        request.setAttribute("pageContent", "/view/admin/contactAdmin.jsp");
        request.setAttribute("pageCss", "contactAdmin.css");
        request.setAttribute("pageJs", "contactAdmin.js");
        request.getRequestDispatcher("/view/admin/baseAdmin.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User admin = (User) session.getAttribute("user");
        String action = request.getParameter("action");
        
        if ("updateStatus".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            String status = request.getParameter("status");
            contactDAO.updateStatus(id, status, admin.getId());
            response.sendRedirect(request.getContextPath() + "/contact-admin?success=contact_updated");
        } else if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            contactDAO.delete(id);
            response.sendRedirect(request.getContextPath() + "/contact-admin?success=contact_deleted");
        }
    }
}
