package cleanmeat.cleanmeat.dao;

import cleanmeat.cleanmeat.model.Feedback;

import java.util.List;

public interface FeedbackDAO {
    public Feedback findById(int id);

    public List<Feedback> findAll();

    public boolean insert(Feedback feedback);

    public boolean update(Feedback feedback);

    public boolean delete(int id);

    public List<Feedback> findByItemId(int itemId);

}
