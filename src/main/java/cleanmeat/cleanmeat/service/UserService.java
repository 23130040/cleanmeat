package cleanmeat.cleanmeat.service;

import cleanmeat.cleanmeat.dao.UserDAO;
import cleanmeat.cleanmeat.dao.UserDAOImpl;
import cleanmeat.cleanmeat.model.User;
import cleanmeat.cleanmeat.security.PasswordUtil;
import cleanmeat.cleanmeat.security.TokenUtil;
import cleanmeat.cleanmeat.utils.EmailUtil;
import cleanmeat.cleanmeat.validate.UserValidate;

import java.time.LocalDate;
import java.util.List;

public class UserService {
    private UserDAO userDAO = new UserDAOImpl();

    public List<User> getAllUsers() {
        return userDAO.findAll();
    }

    public int countTotalUsers() {
        return userDAO.countAll();
    }

    public double calculateUserGrowth() {
        return userDAO.calculateUserGrowth();
    }

    public List<User> searchUsers(String query) {
        return userDAO.search(query);
    }

    public List<User> searchUsers(String query, String role, String status) {
        return userDAO.findAllFiltered(query, role, status);
    }

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
        if (!UserValidate.passwordValidate(password))
            return "Mật khẩu không đủ mạnh!";
        return null;
    }

    public boolean signUp(String username, String email, String phone, String password) {
        User user = new User();
        user.setName(username);
        user.setEmail(email);
        user.setPhone(phone);
        user.setPassword(PasswordUtil.hashPassword(password));
        user.setBirthday(LocalDate.now());
        user.setGender("Other");
        user.setRole("customer");
        user.setStatus(false);
        String token = TokenUtil.generateToken();
        user.setVerify_token(token);
        EmailUtil.sendVerificationEmail(user.getEmail(), token);
        boolean inserted = userDAO.insert(user);
        if (inserted) {
            EmailUtil.sendVerificationEmail(user.getEmail(), token);
        }
        return inserted;
    }

    public boolean verifyEmail(String token) {
        if (userDAO.findByVerifyToken(token) != null) {
            return userDAO.verifyEmail(token);
        }
        return false;
    }

    public String validateSignIn(String email, String password) {
        if (email == "" || email.trim().isEmpty())
            return "Email không được để trống!";
        if (password == "" || password.trim().isEmpty())
            return "Mật khẩu không được để trống!";
        if (!UserValidate.emailValidate(email))
            return "Email không đúng định dạng";
        if (!userDAO.existsByEmail(email))
            return "Email hoặc mật khẩu không đúng!";
        User user = userDAO.findByEmail(email);
        if (!PasswordUtil.verifyPassword(password, user.getPassword()))
            return "Email hoặc mật khẩu không đúng!";
        if (!user.isStatus())
            return "Tài khoản này chưa được xác thực hoặc đã bị khóa!";
        return null;
    }

    public boolean updateInfoAdmin(int id, String name, String phone) {
        return userDAO.updateInfoAdmin(id, name, phone);
    }

    public User signin(String email, String password) {
        return userDAO.findByEmail(email);
    }

    public boolean updateProfile(int id, String name, String phone, String gender, LocalDate birthday) {
        User user = new User();
        user.setId(id);
        user.setName(name);
        user.setPhone(phone);
        user.setGender(gender);
        user.setBirthday(birthday);
        return userDAO.updateProfile(user);
    }

    public User findById(int id) {
        return userDAO.findById(id);
    }

    public String validatePassword(int id, String oldPassword, String newPassword, String confirmPassword) {
        User user = userDAO.findById(id);
        if (!PasswordUtil.verifyPassword(oldPassword, user.getPassword()))
            return "Mật khẩu hiện tại không đúng!";
        if (newPassword.equals(oldPassword))
            return "Mật khẩu mới không được trùng với mật khẩu hiện tại";
        if (!UserValidate.passwordValidate(newPassword))
            return "Mật khẩu mới không đủ mạnh!";
        if (!newPassword.equals(confirmPassword))
            return "Mật khẩu xác nhận không khớp";
        return null;
    }

    public String validatePassword(int id, String password) {
        User user = userDAO.findById(id);
        if (!PasswordUtil.verifyPassword(password, user.getPassword()))
            return "Mật khẩu không đúng!";
        return null;
    }

    public boolean changePassword(int id, String newPassword) {
        String hashedPassword = PasswordUtil.hashPassword(newPassword);
        return userDAO.updatePassword(id, hashedPassword);
    }

    public boolean deactivatedAccount(int id) {
        return userDAO.updateStatus(id);
    }

    public boolean updateAvatar(int id, String avatarUrl) {
        return userDAO.updateAvatar(id, avatarUrl);
    }

    public boolean updateRoleAndStatus(int id, String role, boolean status) {
        return userDAO.updateRoleAndStatus(id, role, status);
    }

    public boolean deleteUser(int id) {
        return userDAO.delete(id);
    }
}
