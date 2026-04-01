package cleanmeat.cleanmeat.controller;

import cleanmeat.cleanmeat.dao.CategoryDAO;
import cleanmeat.cleanmeat.dao.CategoryDAOImpl;
import cleanmeat.cleanmeat.model.Category;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "category-admin", value = "/category-admin")
public class  CategoryAdmin extends HttpServlet {
    private final CategoryDAO categoryDAO = new CategoryDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Category> categories = categoryDAO.findAll();
        request.setAttribute("categories", categories);
        
        request.setAttribute("active", "category-admin");
        request.setAttribute("adminTitle", "Quản lý danh mục");
        request.setAttribute("pageContent", "/view/admin/categoryAdmin.jsp");
        request.setAttribute("pageCss", "categoryAdmin.css");
        request.setAttribute("pageJs", "categoryAdmin.js");
        
        request.getRequestDispatcher("/view/admin/baseAdmin.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        boolean success = false;
        String errorType = "update_failed";

        try {
            if ("add".equals(action)) {
                String name = request.getParameter("name");
                String description = request.getParameter("description");
                if (name == null || name.trim().isEmpty()) {
                    response.sendRedirect(request.getContextPath() + "/category-admin?error=invalid_data");
                    return;
                }
                Category category = new Category();
                category.setName(name.trim());
                category.setDescription(description != null ? description.trim() : "");
                success = categoryDAO.insert(category);
            } else if ("update".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                String name = request.getParameter("name");
                String description = request.getParameter("description");
                Category category = categoryDAO.findById(id);
                if (category != null) {
                    category.setName(name.trim());
                    category.setDescription(description != null ? description.trim() : "");
                    success = categoryDAO.update(category);
                }
            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                success = categoryDAO.delete(id);
            }

            if (success) {
                response.sendRedirect(request.getContextPath() + "/category-admin?success=category_updated");
            } else {
                response.sendRedirect(request.getContextPath() + "/category-admin?error=" + errorType);
            }
        } catch (Exception e) {
            e.printStackTrace();
            if (e.getMessage() != null && e.getMessage().contains("Duplicate entry")) {
                errorType = "duplicate_name";
            }
            response.sendRedirect(request.getContextPath() + "/category-admin?error=" + errorType);
        }
    }
}
