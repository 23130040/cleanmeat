package cleanmeat.cleanmeat.dao;

import cleanmeat.cleanmeat.model.User;

import java.util.List;

public interface UserDAO {
    public User findById(int id);

    public List<User> findAll();

    public int countAll();

    public boolean insert(User user);

    public boolean updateProfile(User user);

    public boolean delete(int id);

    public boolean existsByEmail(String email);

    public User findByVerifyToken(String token);

    public boolean verifyEmail(String token);

    public User findByEmail(String email);

    public boolean updatePassword(int id, String password);

    public boolean updateStatus(int id);

    public boolean updateAvatar(int id, String avatarUrl);

    public boolean updateInfoAdmin(int id, String name, String phone);

    public double calculateUserGrowth();

    public List<User> search(String query);

    public List<User> findAllFiltered(String query, String role, String status);

    public boolean updateRoleAndStatus(int id, String role, boolean status);
}
