package cleanmeat.cleanmeat.controller;

import cleanmeat.cleanmeat.model.User;
import cleanmeat.cleanmeat.service.AddressService;
import cleanmeat.cleanmeat.service.UserService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;

@WebServlet(name = "account", value = "/account")
public class Account extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            User user = (User) session.getAttribute("user");
            AddressService addressService = new AddressService();
            request.setAttribute("addresses", addressService.getAddressesByUserId(user.getId()));
        }

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
        UserService userService = new UserService();
        User user = (User) session.getAttribute("user");
        String action = request.getParameter("action");

        if ("addAddress".equals(action)) {
            String address = request.getParameter("streetAddress");
            String isDefaultParam = request.getParameter("isDefault");
            boolean isDefault = (isDefaultParam != null && isDefaultParam.equals("on"));
            AddressService addressService = new AddressService();
            addressService.addAddress(user.getId(), address, isDefault);
            response.sendRedirect(request.getContextPath() + "/account#addresses");
            return;
        }

        if ("setDefaultAddress".equals(action)) {
            int addressId = Integer.parseInt(request.getParameter("addressId"));
            AddressService addressService = new AddressService();
            addressService.setDefaultAddress(user.getId(), addressId);
            response.sendRedirect(request.getContextPath() + "/account#addresses");
            return;
        }

        if ("deleteAddress".equals(action)) {
            int addressId = Integer.parseInt(request.getParameter("addressId"));
            AddressService addressService = new AddressService();
            addressService.deleteAddress(addressId);
            response.sendRedirect(request.getContextPath() + "/account#addresses");
            return;
        }
        if ("changePassword".equals(action)) {
            String oldPassword = request.getParameter("oldPassword");
            String newPassword = request.getParameter("newPassword");
            String confirmNew = request.getParameter("confirmNew");

            String error = userService.validatePassword(user.getId(), oldPassword, newPassword, confirmNew);
            if (error != null) {
                session.setAttribute("error", error);
                response.sendRedirect(request.getContextPath() + "/account?updated=error#change-password");
                return;
            }

            boolean updated = userService.changePassword(user.getId(), newPassword);
            if (updated) {
                response.sendRedirect(request.getContextPath() + "/account?updated=success#change-password");
            } else {
                response.sendRedirect(request.getContextPath() + "/account?updated=failed#change-password");
            }
            return;
        }
        if ("deactivateAccount".equals(action)) {
            String confirmPassword = request.getParameter("confirmPassword");
            String error = userService.validatePassword(user.getId(), confirmPassword);
            if (error != null) {
                session.setAttribute("error", error);
                response.sendRedirect(request.getContextPath() + "/account?confirm=error#settings");
                return;
            }
            boolean deactivated = userService.deactivatedAccount(user.getId());
            if (deactivated) {
                response.sendRedirect(request.getContextPath() + "/account?deactivated=success#settings");
            } else {
                response.sendRedirect(request.getContextPath() + "/account?deactivated=failed#settings");
            }
            return;
        }

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
        boolean updated = userService.updateProfile(user.getId(), name, phone, gender, birthday);
        if (updated) {
            User updatedUsser = userService.findById(user.getId());
            session.setAttribute("user", updatedUsser);
            response.sendRedirect(request.getContextPath() + "/account?updated=success#personal-info");
        } else {
            response.sendRedirect(request.getContextPath() + "/account#personal-info");
        }
    }
}