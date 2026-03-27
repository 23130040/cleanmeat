package cleanmeat.cleanmeat.dao;

import cleanmeat.cleanmeat.model.User;

import java.util.List;

public interface UserDAO {
    public User findById(int id);

    public List<User> findAll();

    public boolean insert(User user);

    public boolean update(User user);

    public boolean delete(int id);

    public boolean existsByEmail(String email);

    public User findByVerifyToken(String token);

    public boolean verifyEmail(String token);

}
