/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.AccountDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Account;

@WebServlet(name = "LoginController", urlPatterns = {"/login"})
public class LoginController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Lấy dữ liệu từ form
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            // Trim email, nhưng không trim password
            email = trim(email);

            // Kiểm tra trường chỉ chứa dấu cách
            if (isOnlySpaces(email)) {
                request.setAttribute("message", "Email cannot be only spaces");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }
            if (isOnlySpaces(password)) {
                request.setAttribute("message", "Password cannot be only spaces");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }

            // Kiểm tra dấu cách ở đầu hoặc cuối của password
            if (hasLeadingOrTrailingSpaces(password)) {
                request.setAttribute("message", "Password cannot have spaces at the beginning or end");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }

            AccountDAO a = new AccountDAO();

            // Kiểm tra email có tồn tại không
            Account accountByEmail = a.findByEmail(email);
            if (accountByEmail == null) {
                request.setAttribute("message", "Email does not exist");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }

            // Kiểm tra mật khẩu (password không được trim)
            Account account = a.LoginAccount(email, password);
            if (account == null) {
                request.setAttribute("message", "Incorrect password");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }

            // Đăng nhập thành công
            HttpSession session = request.getSession();
            session.setAttribute("userID", account.getUserID());
            session.setAttribute("user", account);
            session.setAttribute("email", email);
            session.setAttribute("password", password);
            request.setAttribute("message", "Login successfully");

            int role = a.getUserRole(email, password);
            switch (role) {
                case 0:
                    response.sendRedirect(request.getContextPath() + "/error.jsp");
                    break;
                case 1:
                    response.sendRedirect(request.getContextPath() + "/renterhome");
                    break;
                case 2:
                    response.sendRedirect(request.getContextPath() + "/OwnerController");
                    break;
                case 3:
                    response.sendRedirect(request.getContextPath() + "/chartServlet");
                    break;
                case 4:
                    response.sendRedirect(request.getContextPath() + "/manage");
                    break;
                default:
                    request.setAttribute("message", "Invalid role");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                    break;
            }
        } catch (ServletException | IOException e) {
            Logger.getLogger(LoginController.class.getName()).log(Level.SEVERE, null, e);
            request.setAttribute("message", "An error occurred during login");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    // Phương thức trim
    private String trim(String value) {
        return value == null ? null : value.trim();
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