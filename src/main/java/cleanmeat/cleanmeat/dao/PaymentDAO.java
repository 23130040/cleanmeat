package cleanmeat.cleanmeat.dao;

import cleanmeat.cleanmeat.model.Payment;

import java.util.List;

public interface PaymentDAO {
    public boolean insert(Payment payment);

    public Payment findById(int id);

    public boolean updateStatus(int id, boolean status);

    public List<Payment> findByStatus(boolean status);

    public List<Payment> findAll();
}
