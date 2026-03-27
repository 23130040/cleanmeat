package cleanmeat.cleanmeat.service;

import cleanmeat.cleanmeat.dao.UserDAO;
import cleanmeat.cleanmeat.dao.UserDAOImpl;
import cleanmeat.cleanmeat.model.User;

import java.time.LocalDate;

public class UserService {
    private UserDAO userDAO = new UserDAOImpl();

    public String validateSignUp(String username, String email, String phone, String password, String confirmPassword) {
        if (username == null || username.trim().isEmpty())
            return "Họ và tên không được để trống!";
        if (email == null || email.trim().isEmpty())
            return "Email không được để trống!";
        if (phone == null || phone.trim().isEmpty())
            return "Số điện thoại không được để trống!";
        if (password == null || password.trim().isEmpty())
            return "Mật khẩu không được để trống!";
        if (confirmPassword == null || confirmPassword.trim().isEmpty())
            return "Mật khẩu xác nhận không được để trống!";
        if (userDAO.existsByEmail(email))
            return "Email đã tồn tại!";
        if (!validatePassword(password))
            return "Mật khẩu không đủ mạnh!";
        return null;
    }

    private boolean validatePassword(String password) {
        return password.matches("^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[\\W_]).{8,}$");
    }

    public boolean signUp(String username, String email, String phone, String password) {
        User user = new User();
        user.setName(username);
        user.setEmail(email);
        user.setPhone(phone);
        user.setPassword(password);
        user.setBirthday(LocalDate.now());
        user.setGender("Other");
        user.setRole("customer");
        user.setStatus(true);
        return userDAO.insert(user);
    }
}
