package cleanmeat.cleanmeat.model;

import java.io.Serializable;
import java.time.LocalDateTime;

public class OrdersStatusHistory implements Serializable {
    private int id;
    private int order_id;
    private String status_from;
    private String status_to;
    private String changed_by;
    private LocalDateTime changed_at;
    private String note;

    public OrdersStatusHistory() {}

    public OrdersStatusHistory(int id, int order_id, String status_from, String status_to, String changed_by, LocalDateTime changed_at, String note) {
        this.id = id;
        this.order_id = order_id;
        this.status_from = status_from;
        this.status_to = status_to;
        this.changed_by = changed_by;
        this.changed_at = changed_at;
        this.note = note;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getOrder_id() { return order_id; }
    public void setOrder_id(int order_id) { this.order_id = order_id; }

    public String getStatus_from() { return status_from; }
    public void setStatus_from(String status_from) { this.status_from = status_from; }

    public String getStatus_to() { return status_to; }
    public void setStatus_to(String status_to) { this.status_to = status_to; }

    public String getChanged_by() { return changed_by; }
    public void setChanged_by(String changed_by) { this.changed_by = changed_by; }

    public LocalDateTime getChanged_at() { return changed_at; }
    public void setChanged_at(LocalDateTime changed_at) { this.changed_at = changed_at; }

    public String getNote() { return note; }
    public void setNote(String note) { this.note = note; }
}
