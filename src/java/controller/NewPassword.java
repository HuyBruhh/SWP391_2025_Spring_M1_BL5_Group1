package controller;

import dao.AccountDAO;
import java.io.IOException;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/newPassword")
public class NewPassword extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        RequestDispatcher dispatcher = request.getRequestDispatcher("newPassword.jsp");

        // Kiểm tra email có trong session không
        if (email == null) {
            request.setAttribute("errorMessage", "Session expired. Please try again.");
            dispatcher.forward(request, response);
            return;
        }

        // Kiểm tra mật khẩu và xác nhận mật khẩu không null hoặc trống
        if (password == null || confirmPassword == null || password.isEmpty() || confirmPassword.isEmpty()) {
            request.setAttribute("errorMessage", "Please enter both password fields.");
            dispatcher.forward(request, response);
            return;
        }

        // Kiểm tra chỉ chứa dấu cách
        if (isOnlySpaces(password) || isOnlySpaces(confirmPassword)) {
            request.setAttribute("errorMessage", "Password cannot be only spaces.");
            dispatcher.forward(request, response);
            return;
        }

        // Kiểm tra dấu cách ở đầu hoặc cuối
        if (hasLeadingOrTrailingSpaces(password) || hasLeadingOrTrailingSpaces(confirmPassword)) {
            request.setAttribute("errorMessage", "Password cannot have leading or trailing spaces.");
            dispatcher.forward(request, response);
            return;
        }

        // Kiểm tra mật khẩu và xác nhận mật khẩu có khớp không
        if (!password.equals(confirmPassword)) {
            request.setAttribute("errorMessage", "Passwords do not match.");
            dispatcher.forward(request, response);
            return;
        }

        // Kiểm tra định dạng mật khẩu
        if (!password.matches("^(?=.*\\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&*])[A-Za-z\\d!@#$%^&*]{8,}$")) {
            request.setAttribute("errorMessage", "Password must be at least 8 characters long, include at least one number, one letter, and one special character.");
            dispatcher.forward(request, response);
            return;
        }

        try {
            AccountDAO accountDAO = new AccountDAO();
            boolean updated = accountDAO.updateUserPassword(email, password);

            if (updated) {
                // Xóa OTP và email khỏi session
                session.removeAttribute("otp");
                session.removeAttribute("email");
                request.setAttribute("status", "Reset Success");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            } else {
                request.setAttribute("status", "Reset Failed");
                dispatcher.forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred. Please try again.");
            dispatcher.forward(request, response);
        }
    }

    // Phương thức kiểm tra chỉ chứa dấu cách
    private boolean isOnlySpaces(String value) {
        return value != null && value.trim().isEmpty();
    }

    // Phương thức kiểm tra dấu cách ở đầu hoặc cuối
    private boolean hasLeadingOrTrailingSpaces(String value) {
        if (value == null) return false;
        return !value.equals(value.trim());
    }
}