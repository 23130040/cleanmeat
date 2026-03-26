package cleanmeat.cleanmeat.dao;

import cleanmeat.cleanmeat.model.Notification;

public interface NotificationDAO {
    public Notification findById(int id);

    public boolean insert(Notification notification);

    public boolean delete(int id);
}
