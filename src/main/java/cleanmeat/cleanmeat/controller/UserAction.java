package cleanmeat.cleanmeat.controller;

import cleanmeat.cleanmeat.model.User;
import cleanmeat.cleanmeat.service.UserService;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet(name = "user-action", value = "/user-action")
public class UserAction extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String idStr = request.getParameter("id");
        if (idStr != null) {
            try {
                int id = Integer.parseInt(idStr);
                UserService userService = new UserService();
                User user = userService.findById(id);
                if (user != null) {
                    user.setPassword(null);
                    Gson gson = new GsonBuilder()
                        .registerTypeAdapter(java.time.LocalDateTime.class, (com.google.gson.JsonSerializer<java.time.LocalDateTime>) (src, typeOfSrc, context) -> 
                            new com.google.gson.JsonPrimitive(src.format(java.time.format.DateTimeFormatter.ISO_LOCAL_DATE_TIME)))
                        .registerTypeAdapter(java.time.LocalDate.class, (com.google.gson.JsonSerializer<java.time.LocalDate>) (src, typeOfSrc, context) -> 
                            new com.google.gson.JsonPrimitive(src.format(java.time.format.DateTimeFormatter.ISO_LOCAL_DATE)))
                        .create();
                    String json = gson.toJson(user);
                    response.getWriter().write(json);
                } else {
                    response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                }
            } catch (NumberFormatException e) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        String idStr = request.getParameter("id");
        
        UserService userService = new UserService();
        Map<String, Object> result = new HashMap<>();
        Gson gson = new Gson();

        try {
            int id = Integer.parseInt(idStr);
            if ("update".equals(action)) {
                String role = request.getParameter("role");
                boolean status = Boolean.parseBoolean(request.getParameter("status"));
                boolean success = userService.updateRoleAndStatus(id, role, status);
                result.put("success", success);
                result.put("message", success ? "Cập nhật thành công!" : "Cập nhật thất bại!");
            } else if ("delete".equals(action)) {
                boolean success = userService.deactivatedAccount(id);
                result.put("success", success);
                result.put("message", success ? "Vô hiệu hóa thành công!" : "Vô hiệu hóa thất bại!");
            }
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "Lỗi: " + e.getMessage());
        }

        response.getWriter().write(gson.toJson(result));
    }
}
