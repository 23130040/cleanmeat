package cleanmeat.cleanmeat.dao;

import cleanmeat.cleanmeat.model.Category;

import java.util.List;

public interface CategoryDAO {
    public Category findById(int id);

    public List<Category> findAll();

    public boolean insert(Category category);

    public boolean update(Category category);

    public boolean delete(int id);
}
