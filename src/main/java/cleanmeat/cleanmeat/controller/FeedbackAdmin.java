package cleanmeat.cleanmeat.controller;

import cleanmeat.cleanmeat.dao.FeedbackDAO;
import cleanmeat.cleanmeat.dao.FeedbackDAOImpl;
import cleanmeat.cleanmeat.model.Feedback;
import cleanmeat.cleanmeat.model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "feedback-admin", value = "/feedback-admin")
public class FeedbackAdmin extends HttpServlet {
    private FeedbackDAO feedbackDAO = new FeedbackDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

        List<Feedback> feedbacks = feedbackDAO.findAll();

        request.setAttribute("feedbacks", feedbacks);
        request.setAttribute("adminTitle", "Quản lý phản hồi");
        request.setAttribute("active", "feedback-admin");
        request.setAttribute("user", currentUser);
        request.setAttribute("pageContent", "/view/admin/feedbackAdmin.jsp");
        request.setAttribute("pageCss", "feedbackAdmin.css");
        request.setAttribute("pageJs", "feedbackAdmin.js");
        request.getRequestDispatcher("/view/admin/baseAdmin.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            feedbackDAO.delete(id);
            response.sendRedirect(request.getContextPath() + "/feedback-admin?success=feedback_deleted");
        }
    }
}
