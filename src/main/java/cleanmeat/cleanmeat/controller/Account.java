package cleanmeat.cleanmeat.controller;

import cleanmeat.cleanmeat.model.User;
import cleanmeat.cleanmeat.service.UserService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.Date;

@WebServlet(name = "account", value = "/account")
public class Account extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("pageTitle", "Tài khoản");
        request.setAttribute("pageContent", "/view/account.jsp");
        request.setAttribute("pageCss", "account.css");
        request.getRequestDispatcher("/view/base.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/sign-in");
            return;
        }
        User user = (User) session.getAttribute("user");
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String gender = request.getParameter("gender");
        String birthdayStr = request.getParameter("birthday");

        LocalDate birthday = null;
        if (birthdayStr != null && !birthdayStr.trim().isEmpty()) {
            try {
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
                birthday = LocalDate.parse(birthdayStr, formatter);
            } catch (DateTimeParseException ex) {
                request.setAttribute("error", "Ngày sinh không đúng định dạng dd/MM/yyyy!");
                doGet(request, response);
                return;
            }
        }

        if (name == null || name.trim().isEmpty()) {
            request.setAttribute("error", "Họ và tên không được để trống!");
            doGet(request, response);
            return;
        }

        if (phone == null || phone.trim().isEmpty()) {
            request.setAttribute("error", "Số điện thoại không được để trống!");
            doGet(request, response);
            return;
        }

        UserService userService = new UserService();
        boolean updated = userService.updateProfile(user.getId(), name, phone, gender, birthday);

        if (updated) {
            User updatedUsser = userService.findById(user.getId());
            session.setAttribute("user", updatedUsser);
            response.sendRedirect(request.getContextPath() + "/account?update-profile=success");
        } else {
            response.sendRedirect(request.getContextPath() + "/account?update-profile=failed");
        }
    }
}