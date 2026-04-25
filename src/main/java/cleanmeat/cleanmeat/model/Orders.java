package cleanmeat.cleanmeat.model;

import java.io.Serializable;
import cleanmeat.cleanmeat.model.Address;
import java.time.LocalDateTime;

public class Orders implements Serializable {
    private int id;
    private int user_id;
    private double total_price;
    private String status;
    private LocalDateTime created_at;
    private LocalDateTime updated_at;
    private int address_id;
    private int transport_id;
    private int payment_id;

    private String user_name;
    private String user_email;
    private String payment_method;
    private String transport_method;
    
    private java.util.List<OrdersItem> items;
    private Address address;
    private java.util.List<OrdersStatusHistory> statusHistory;

    public Orders() {
    }

    public Orders(int id, int user_id, double total_price, String status, LocalDateTime created_at, LocalDateTime updated_at, int address_id, int transport_id, int payment_id) {
        this.id = id;
        this.user_id = user_id;
        this.total_price = total_price;
        this.status = status;
        this.created_at = created_at;
        this.updated_at = updated_at;
        this.address_id = address_id;
        this.transport_id = transport_id;
        this.payment_id = payment_id;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public double getTotal_price() {
        return total_price;
    }

    public void setTotal_price(double total_price) {
        this.total_price = total_price;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public LocalDateTime getCreated_at() {
        return created_at;
    }

    public void setCreated_at(LocalDateTime created_at) {
        this.created_at = created_at;
    }

    public LocalDateTime getUpdated_at() {
        return updated_at;
    }

    public void setUpdated_at(LocalDateTime updated_at) {
        this.updated_at = updated_at;
    }

    public int getAddress_id() {
        return address_id;
    }

    public void setAddress_id(int address_id) {
        this.address_id = address_id;
    }

    public int getTransport_id() {
        return transport_id;
    }

    public void setTransport_id(int transport_id) {
        this.transport_id = transport_id;
    }

    public int getPayment_id() {
        return payment_id;
    }

    public void setPayment_id(int payment_id) {
        this.payment_id = payment_id;
    }

    public String getOrderIDFormatted() {
        return "#CM" + String.format("%03d", id) + user_id + created_at.toString();
    }
    
    public String getShortOrderID() {
        return String.format("ORD-%04d", id);
    }
    
    public String getUser_name() { return user_name; }
    public void setUser_name(String user_name) { this.user_name = user_name; }

    public String getUser_email() { return user_email; }
    public void setUser_email(String user_email) { this.user_email = user_email; }

    public String getPayment_method() { return payment_method; }
    public void setPayment_method(String payment_method) { this.payment_method = payment_method; }

    public String getTransport_method() { return transport_method; }
    public void setTransport_method(String transport_method) { this.transport_method = transport_method; }

    public java.util.List<OrdersItem> getItems() { return items; }
    public void setItems(java.util.List<OrdersItem> items) { this.items = items; }

    public Address getAddress() { return address; }
    public void setAddress(Address address) { this.address = address; }

    public java.util.Date getCreated_at_as_date() {
        return created_at != null ? java.sql.Timestamp.valueOf(created_at) : null;
    }

    public java.util.Date getUpdated_at_as_date() {
        return updated_at != null ? java.sql.Timestamp.valueOf(updated_at) : null;
    }
    public java.util.List<OrdersStatusHistory> getStatusHistory() { return statusHistory; }
    public void setStatusHistory(java.util.List<OrdersStatusHistory> statusHistory) { this.statusHistory = statusHistory; }
}
