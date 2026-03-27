package cleanmeat.cleanmeat.utils;
import java.util.Properties;
import jakarta.mail.*;
import jakarta.mail.internet.*;
public class EmailUtil {
    private static final String FROM_EMAIL = "bichdantqn2005@gmail.com";
    private static final String APP_PASSWORD = "xlbd kooq kvrg ajrq";
    public static void sendVerificationEmail(String to, String token) {
        String link = "http://localhost:8080/cleanmeat_war/verify-email?token=" + token;
        String subject = "Xác thực tài khoản";
        String content = "Click vào link để xác thực:\n" + link;

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props,
                new Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(FROM_EMAIL, APP_PASSWORD);
                    }
                });
        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(FROM_EMAIL));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            message.setSubject(subject);
            message.setText(content);
            Transport.send(message);
        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }
    }
}
