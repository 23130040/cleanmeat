package cleanmeat.cleanmeat.controller;

import cleanmeat.cleanmeat.dao.PaymentDAO;
import cleanmeat.cleanmeat.dao.PaymentDAOImpl;
import cleanmeat.cleanmeat.model.Payment;
import cleanmeat.cleanmeat.model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "payment-admin", value = "/payment-admin")
public class PaymentAdmin extends HttpServlet {
    private PaymentDAO paymentDAO = new PaymentDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

        List<Payment> payments = paymentDAO.findAll();

        request.setAttribute("payments", payments);
        request.setAttribute("adminTitle", "Quản lý phương thức thanh toán");
        request.setAttribute("active", "payment-admin");
        request.setAttribute("user", currentUser);
        request.setAttribute("pageContent", "/view/admin/paymentAdmin.jsp");
        request.setAttribute("pageCss", "paymentAdmin.css");
        request.setAttribute("pageJs", "paymentAdmin.js");
        request.getRequestDispatcher("/view/admin/baseAdmin.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

        String action = request.getParameter("action");
        if ("toggleStatus".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            boolean status = Boolean.parseBoolean(request.getParameter("status"));
            paymentDAO.updateStatus(id, status);
            response.sendRedirect(request.getContextPath() + "/payment-admin?success=payment_updated");
        } else if ("add".equals(action)) {
            String name = request.getParameter("name");
            boolean status = request.getParameter("status") != null;
            Payment payment = new Payment();
            payment.setName(name);
            payment.setStatus(status);
            paymentDAO.insert(payment);
            response.sendRedirect(request.getContextPath() + "/payment-admin?success=payment_added");
        } else if ("edit".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            Payment payment = new Payment();
            payment.setId(id);
            payment.setName(name);
            paymentDAO.update(payment);
            response.sendRedirect(request.getContextPath() + "/payment-admin?success=payment_updated");
        } else if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            paymentDAO.delete(id);
            response.sendRedirect(request.getContextPath() + "/payment-admin?success=payment_deleted");
        }
    }
}
