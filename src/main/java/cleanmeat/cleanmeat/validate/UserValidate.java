package cleanmeat.cleanmeat.validate;

import jakarta.mail.internet.AddressException;
import jakarta.mail.internet.InternetAddress;

public class UserValidate {

    public static boolean emailValidate(String email) {
        try {
            InternetAddress emailAddr = new InternetAddress(email);
            emailAddr.validate();
            return true;
        } catch (AddressException e) {
            return false;
        }
    }

    public static boolean passwordValidate(String password) {
        return password.matches("^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[\\W_]).{8,}$");
    }
}
