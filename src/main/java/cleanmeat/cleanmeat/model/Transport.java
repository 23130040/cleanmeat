package cleanmeat.cleanmeat.model;

import java.io.Serializable;
import java.time.LocalDateTime;

public class Transport implements Serializable {
    private int id;
    private String name;
    private int base_fee;
    private int estimate_day;
    private boolean status;
    private int free_ship;
    private LocalDateTime created_at;
    private LocalDateTime updated_at;

    public Transport() {}

    public Transport(int id, String name, int base_fee, int estimate_day, boolean status, int free_ship, LocalDateTime created_at, LocalDateTime updated_at) {
        this.id = id;
        this.name = name;
        this.base_fee = base_fee;
        this.estimate_day = estimate_day;
        this.status = status;
        this.free_ship = free_ship;
        this.created_at = created_at;
        this.updated_at = updated_at;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getBase_fee() {
        return base_fee;
    }

    public void setBase_fee(int base_fee) {
        this.base_fee = base_fee;
    }

    public int getEstimate_day() {
        return estimate_day;
    }

    public void setEstimate_day(int estimate_day) {
        this.estimate_day = estimate_day;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public LocalDateTime getCreated_at() {
        return created_at;
    }

    public void setCreated_at(LocalDateTime created_at) {
        this.created_at = created_at;
    }

    public int getFree_ship() {
        return free_ship;
    }

    public void setFree_ship(int free_ship) {
        this.free_ship = free_ship;
    }

    public LocalDateTime getUpdated_at() {
        return updated_at;
    }

    public void setUpdated_at(LocalDateTime updated_at) {
        this.updated_at = updated_at;
    }
}
