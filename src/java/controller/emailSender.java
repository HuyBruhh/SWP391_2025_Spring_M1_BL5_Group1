package controller;

import dao.RegisterDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.Random;
import java.util.Properties;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javax.mail.*;
import javax.mail.internet.*;
import model.Account;
import model.User;
import java.util.Calendar;
import java.util.Date;
import java.text.SimpleDateFormat;
import java.text.ParseException;

@WebServlet(name = "emailSender", urlPatterns = {"/emailSender"})
public class emailSender extends HttpServlet {

    private static final String PHONE_NUMBER_REGEX = "^(0|\\+84)[0-9]{9}$";
    private static final String EMAIL_REGEX = "^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$";
    private static final String PASSWORD_REGEX = "^(?=.*[A-Z])(?=.*[!@#$%^&*]).{8,}$";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        RegisterDAO dao = new RegisterDAO();

        // Lấy dữ liệu từ form
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String username = request.getParameter("username");
        String gender = request.getParameter("gender");
        String dob = request.getParameter("dob");
        String password = request.getParameter("password");
        String repassword = request.getParameter("repassword");
        String address = request.getParameter("address");
        String role = request.getParameter("role");
        List<Account> listAccount = dao.getListAccount();

        // Trim dữ liệu (yêu cầu e)
        email = trim(email);
        phone = trim(phone);
        username = trim(username);
        gender = trim(gender);
        dob = trim(dob);
        password = trim(password);
        repassword = trim(repassword);
        address = trim(address);
        role = trim(role);

        // Khởi tạo biến lỗi
        StringBuilder error = new StringBuilder();

        // Kiểm tra trường bắt buộc (yêu cầu b)
        if (isEmpty(username)) {
            error.append("Username is required. ");
        }
        if (isEmpty(email)) {
            error.append("Email is required. ");
        }
        if (isEmpty(phone)) {
            error.append("Phone is required. ");
        }
        if (isEmpty(password)) {
            error.append("Password is required. ");
        }
        if (isEmpty(repassword)) {
            error.append("Confirm Password is required. ");
        }
        if (isEmpty(address)) {
            error.append("Address is required. ");
        }
        if (isEmpty(role)) {
            error.append("Role is required. ");
        }

        // Kiểm tra trường chỉ chứa dấu cách (yêu cầu d)
        if (isOnlySpaces(username)) {
            error.append("Username cannot be only spaces. ");
        }
        if (isOnlySpaces(email)) {
            error.append("Email cannot be only spaces. ");
        }
        if (isOnlySpaces(phone)) {
            error.append("Phone cannot be only spaces. ");
        }
        if (isOnlySpaces(password)) {
            error.append("Password cannot be only spaces. ");
        }
        if (isOnlySpaces(repassword)) {
            error.append("Confirm Password cannot be only spaces. ");
        }
        if (isOnlySpaces(address)) {
            error.append("Address cannot be only spaces. ");
        }

        // Kiểm tra độ dài tối đa (yêu cầu a)
        if (!checkMaxLength(username, 30)) {
            error.append("Username must be less than 30 characters. ");
        }
        if (!checkMaxLength(email, 100)) {
            error.append("Email must be less than 100 characters. ");
        }
        if (!checkMaxLength(phone, 12)) {
            error.append("Phone must be less than 12 characters. ");
        }
        if (!checkMaxLength(password, 50)) {
            error.append("Password must be less than 50 characters. ");
        }
        if (!checkMaxLength(repassword, 50)) {
            error.append("Confirm Password must be less than 50 characters. ");
        }
        if (!checkMaxLength(address, 50)) {
            error.append("Address must be less than 50 characters. ");
        }

        // Kiểm tra định dạng (yêu cầu c - chỉ áp dụng cho email, phone, dob)
        if (!isEmpty(email) && !isOnlySpaces(email) && !isValidEmail(email)) {
            error.append("Invalid email format. ");
        }
        if (!isEmpty(phone) && !isOnlySpaces(phone) && !isValidPhone(phone)) {
            error.append("Phone must be in Vietnamese format (e.g., 0123456789 or +84123456789). ");
        }
        if (!isEmpty(dob) && !isValidDateAndAge(dob)) {
            error.append("You must be at least 18 years old. ");
        }
        if (!isEmpty(password) && !isOnlySpaces(password) && !isValidPassword(password)) {
            error.append("Password must be at least 8 characters long and include at least one uppercase letter and one special character. ");
        }

        // Kiểm tra password và repassword khớp nhau
        if (!isEmpty(password) && !isEmpty(repassword) && !password.equals(repassword)) {
            error.append("Password and Confirm Password do not match. ");
        }

        // Kiểm tra email đã tồn tại
        for (Account account : listAccount) {
            if (email.equals(account.getUserMail())) {
                error.append("Email already exists!!! ");
            }
        }

        // Nếu có lỗi, gửi lại thông báo lỗi về JSP
        if (error.length() > 0) {
            request.setAttribute("error", error.toString());
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Random OTP
        String code = generateRandomCode();
        // Send email
        boolean emailSent = sendEmail(email, code);

        if (emailSent) {
            // Save the confirmation code and send to session
            HttpSession session = request.getSession();
            session.setAttribute("authCode", code);
            session.setAttribute("codeGeneratedTime", System.currentTimeMillis());

            session.setAttribute("email", email);
            session.setAttribute("phone", phone);
            session.setAttribute("username", username);
            session.setAttribute("gender", gender);
            session.setAttribute("dob", dob);
            session.setAttribute("password", password);
            session.setAttribute("address", address);
            session.setAttribute("role", role); // Lưu role vào session

            // Send redirect to verify page
            request.getRequestDispatcher("verifyCode.jsp").forward(request, response);
        } else {
            response.getWriter().println("Sending email failed. Please try again.");
        }
    }

    private boolean sendEmail(String recipient, String code) throws UnsupportedEncodingException {
        // Email account information
        String email = "huyphqhe170146@fpt.edu.vn";
        String appPassword = "hnvm cprk dgio llqh";
        String smtpHost = "smtp.gmail.com";
        int smtpPort = 587;

        Properties props = new Properties();
        props.put("mail.smtp.host", smtpHost);
        props.put("mail.smtp.port", smtpPort);
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Authenticator auth = new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(email, appPassword);
            }
        };

        Session session = Session.getInstance(props, auth);

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(email, "Admin"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipient));
            message.setSubject("Verification");
            message.setText("Your verification code is: " + code);

            Transport.send(message);

            return true;
        } catch (MessagingException e) {
            e.printStackTrace(); // Log error details to the console
            log("Error sending email: " + e.getMessage(), e); // Write errors to the servlet log
            return false;
        }
    }

    private String generateRandomCode() {
        String chars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
        StringBuilder code = new StringBuilder();
        Random rnd = new Random();
        while (code.length() < 6) {
            int index = rnd.nextInt(chars.length());
            code.append(chars.charAt(index));
        }
        return code.toString();
    }

    // Validation methods
    private boolean isEmpty(String value) {
        return value == null || value.trim().isEmpty();
    }

    private boolean checkMaxLength(String value, int maxLength) {
        if (value == null) return true;
        return value.length() <= maxLength;
    }

    private boolean isValidEmail(String email) {
        if (email == null) return false;
        Pattern pattern = Pattern.compile(EMAIL_REGEX);
        Matcher matcher = pattern.matcher(email);
        return matcher.matches();
    }

    private boolean isValidPhone(String phone) {
        if (phone == null) return false;
        Pattern pattern = Pattern.compile(PHONE_NUMBER_REGEX);
        Matcher matcher = pattern.matcher(phone);
        return matcher.matches();
    }

    private boolean isValidDateAndAge(String date) {
        if (date == null || date.isEmpty()) return true; // Not required
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        sdf.setLenient(false);
        try {
            Date parsedDate = sdf.parse(date);
            Calendar dob = Calendar.getInstance();
            dob.setTime(parsedDate);
            Calendar today = Calendar.getInstance();
            today.setTime(new Date()); // Ngày hiện tại: 21/04/2025
            int age = today.get(Calendar.YEAR) - dob.get(Calendar.YEAR);
            if (today.get(Calendar.DAY_OF_YEAR) < dob.get(Calendar.DAY_OF_YEAR)) {
                age--;
            }
            return age >= 18; // Phải đủ 18 tuổi
        } catch (ParseException e) {
            return false;
        }
    }

    private boolean isValidPassword(String password) {
        if (password == null) return false;
        Pattern pattern = Pattern.compile(PASSWORD_REGEX);
        Matcher matcher = pattern.matcher(password);
        return matcher.matches();
    }

    private boolean isOnlySpaces(String value) {
        return value != null && value.trim().isEmpty();
    }

    private String trim(String value) {
        return value == null ? null : value.trim();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}