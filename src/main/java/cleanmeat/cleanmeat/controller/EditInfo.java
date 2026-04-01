package cleanmeat.cleanmeat.controller;

import cleanmeat.cleanmeat.model.User;
import cleanmeat.cleanmeat.service.UserService;
import cleanmeat.cleanmeat.utils.R2Util;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet("/edit-info")
@MultipartConfig
public class EditInfo extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/sign-in");
            return;
        }
        UserService userService = new UserService();
        String action = request.getParameter("action");
        if ("changeInfo".equals(action)) {
            Part avatarPart = request.getPart("avatar");
            boolean avatarUpdated = false;
            boolean uploadAttempted = avatarPart != null && avatarPart.getSize() > 0;

            if (uploadAttempted) {
                String fileName = user.getId() + "_" + avatarPart.getSubmittedFileName();
                R2Util r2Util = new R2Util();
                String avatarUrl = r2Util.uploadFile(fileName, avatarPart.getInputStream(), avatarPart.getSize(), avatarPart.getContentType());
                avatarUpdated = userService.updateAvatar(user.getId(), avatarUrl);
            }
            
            String name = request.getParameter("name");
            String phone = request.getParameter("phone");

            boolean infoUpdated = userService.updateInfoAdmin(user.getId(), name, phone);

            boolean isSuccess = infoUpdated && (!uploadAttempted || avatarUpdated);

            String redirectUrl = request.getHeader("referer");
            if (redirectUrl == null || redirectUrl.contains("/edit-info")) {
                redirectUrl = request.getContextPath() + "/news-admin";
            }

            redirectUrl = redirectUrl.replaceAll("[&?]success=[^&]*", "");
            redirectUrl = redirectUrl.replaceAll("[&?]error=[^&]*", "");
            redirectUrl = redirectUrl.replaceAll("[&?]updated=[^&]*", "");
            
            String separator = redirectUrl.contains("?") ? "&" : "?";

            if (isSuccess) {
                User userUpdated = userService.findById(user.getId());
                session.setAttribute("user", userUpdated);
                response.sendRedirect(redirectUrl + separator + "success=info_updated");
            } else {
                response.sendRedirect(redirectUrl + separator + "error=update_failed");
            }
        } else if ("changePassword".equals(action)) {
            String oldPassword = request.getParameter("oldPassword");
            String newPassword = request.getParameter("newPassword");
            String confirmPassword = request.getParameter("confirmPassword");

            String validationError = userService.validatePassword(user.getId(), oldPassword, newPassword, confirmPassword);

            String redirectUrl = request.getHeader("referer");
            if (redirectUrl == null) {
                redirectUrl = request.getContextPath() + "/dashboard";
            }
            redirectUrl = redirectUrl.replaceAll("[&?]success=[^&]*", "");
            redirectUrl = redirectUrl.replaceAll("[&?]error=[^&]*", "");
            String separator = redirectUrl.contains("?") ? "&" : "?";

            if (validationError == null) {
                boolean isChanged = userService.changePassword(user.getId(), newPassword);
                if (isChanged) {
                    response.sendRedirect(redirectUrl + separator + "success=password_updated");
                } else {
                    response.sendRedirect(redirectUrl + separator + "error=update_failed");
                }
            } else {
                String errorParam = "update_failed";
                if (validationError.contains("hiện tại không đúng")) errorParam = "wrong_password";
                else if (validationError.contains("không đủ mạnh")) errorParam = "not_strong";
                else if (validationError.contains("không khớp")) errorParam = "mismatch";
                else if (validationError.contains("trùng với mật khẩu hiện tại")) errorParam = "same_as_old";
                
                response.sendRedirect(redirectUrl + separator + "error=" + errorParam);
            }
        }
    }

}