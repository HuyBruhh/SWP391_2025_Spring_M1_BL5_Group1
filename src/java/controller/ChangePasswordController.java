/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import dao.AccountDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import model.*;

@WebServlet(name = "ChangePasswordController", urlPatterns = {"/changePassword"})
public class ChangePasswordController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Account account = (Account) req.getSession().getAttribute("user");
        if (account == null) {
            req.getRequestDispatcher("GuestController").forward(req, resp);
        } else {
            req.getRequestDispatcher("change-password.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Account account = (Account) req.getSession().getAttribute("user");
        AccountDAO dbAccount = new AccountDAO();
        if (account == null) {
            req.getRequestDispatcher("GuestController").forward(req, resp);
        } else {
            System.out.println(account.getUserID());
            System.out.println(account.getUserMail());
            Account accountInDb = dbAccount.findByEmail(account.getUserMail());

            String oldPassword = req.getParameter("oldPassword");
            String password = req.getParameter("password");
            String rePassword = req.getParameter("rePassword");

            // Kiểm tra trường chỉ chứa dấu cách
            if (isOnlySpaces(oldPassword)) {
                req.setAttribute("message", "Password cannot be only spaces");
                req.getRequestDispatcher("change-password.jsp").forward(req, resp);
                return;
            }
            if (isOnlySpaces(password)) {
                req.setAttribute("message", "Password cannot be only spaces");
                req.getRequestDispatcher("change-password.jsp").forward(req, resp);
                return;
            }
            if (isOnlySpaces(rePassword)) {
                req.setAttribute("message", "Password cannot be only spaces");
                req.getRequestDispatcher("change-password.jsp").forward(req, resp);
                return;
            }

            // Kiểm tra dấu cách ở đầu hoặc cuối
            if (hasLeadingOrTrailingSpaces(oldPassword)) {
                req.setAttribute("message", "Password is incorrect");
                req.getRequestDispatcher("change-password.jsp").forward(req, resp);
                return;
            }
            if (hasLeadingOrTrailingSpaces(password)) {
                req.setAttribute("message", "Password must be at least 8 characters long and include at least one uppercase letter and one special character.");
                req.getRequestDispatcher("change-password.jsp").forward(req, resp);
                return;
            }
            if (hasLeadingOrTrailingSpaces(rePassword)) {
                req.setAttribute("message", "Password must be at least 8 characters long and include at least one uppercase letter and one special character.");
                req.getRequestDispatcher("change-password.jsp").forward(req, resp);
                return;
            }

            // Kiểm tra mật khẩu cũ
            if (!oldPassword.equals(accountInDb.getUserPassword())) {
                req.setAttribute("message", "Your old password is wrong");
                req.getRequestDispatcher("change-password.jsp").forward(req, resp);
                return;
            }

            // Kiểm tra mật khẩu mới có giống mật khẩu cũ không
            if (password.equals(oldPassword)) {
                req.setAttribute("message", "New password cannot be the same as the old password.");
                req.getRequestDispatcher("change-password.jsp").forward(req, resp);
                return;
            }

            // Kiểm tra định dạng mật khẩu mới
            if (!password.matches("^(?=.*\\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&*])[A-Za-z\\d!@#$%^&*]{8,}$")) {
                req.setAttribute("message", "Password must be at least 8 characters long and include at least one uppercase letter and one special character.");
                req.getRequestDispatcher("change-password.jsp").forward(req, resp);
                return;
            }

            // Kiểm tra mật khẩu mới và mật khẩu lặp lại có khớp không
            if (!password.equals(rePassword)) {
                req.setAttribute("message", "Your repeat password is wrong");
                req.getRequestDispatcher("change-password.jsp").forward(req, resp);
                return;
            }

            // Cập nhật mật khẩu mới
            accountInDb.setUserPassword(password);
            dbAccount.updatePassword(accountInDb);
            session.invalidate();
            req.getRequestDispatcher("login.jsp").forward(req, resp);
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