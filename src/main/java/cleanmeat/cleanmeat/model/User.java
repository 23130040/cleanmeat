package cleanmeat.cleanmeat.model;

import java.io.Serializable;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class User implements Serializable {
    private int id;
    private String name;
    private String email;
    private String password;
    private String phone;
    private String gender;
    private LocalDate birthday;
    private String role;
    private String avatar;
    private LocalDateTime created_at;
    private LocalDateTime updated_at;
    private boolean status;
    private String verify_token;

    public User() {
    }

    public User(int id, String name, String email, String password, String phone, String gender, LocalDate birthday, String role, String avatar, LocalDateTime created_at, LocalDateTime updated_at, boolean status, String verify_token) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.password = password;
        this.phone = phone;
        this.gender = gender;
        this.birthday = birthday;
        this.role = role;
        this.avatar = avatar;
        this.created_at = created_at;
        this.updated_at = updated_at;
        this.status = status;
        this.verify_token = verify_token;
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

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public LocalDate getBirthday() {
        return birthday;
    }

    public void setBirthday(LocalDate birthday) {
        this.birthday = birthday;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
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

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public String getVerify_token() {
        return verify_token;
    }

    public void setVerify_token(String verify_token) {
        this.verify_token = verify_token;
    }

    public String getBirthdayFormatted() {
        if (birthday == null) return "";
        return birthday.format(DateTimeFormatter.ofPattern("dd/MM/yyyy"));
    }
}
