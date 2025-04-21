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
import java.net.URLEncoder;
import model.Account;
import model.User;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.Files;
import java.util.Base64;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.crypto.SecretKey;

@WebServlet(urlPatterns = {"/verifyCode"})
public class verifyCode extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        String code = request.getParameter("code");
        String email = (String) session.getAttribute("email");
        String phone = (String) session.getAttribute("phone");
        String username = (String) session.getAttribute("username");
        String gender = (String) session.getAttribute("gender");
        String dob = (String) session.getAttribute("dob");
        String password = (String) session.getAttribute("password");
        String address = (String) session.getAttribute("address");
        String role = (String) session.getAttribute("role");
        RegisterDAO dao = new RegisterDAO();

        Path defaultImg = Paths.get("images/default.jpg");
        byte[] userAvatar_raw = convertPathToByteArray(defaultImg);
        String userAvatar = Base64.getEncoder().encodeToString(userAvatar_raw);

        String authCode = (String) session.getAttribute("authCode");
        Long codeGeneratedTime = (Long) session.getAttribute("codeGeneratedTime");

        if (authCode != null && codeGeneratedTime != null) {
            long currentTime = System.currentTimeMillis();
            long timeElapsed = (currentTime - codeGeneratedTime) / 1000;

            if (timeElapsed > 120) {
                request.setAttribute("message", "Verification code expired");
                request.getRequestDispatcher("verifyCode.jsp").forward(request, response);
            } else if (authCode.equals(code)) {
                // Xác định userRole dựa trên role
                int userRole = role.equals("renter") ? 1 : 2; // 1 cho renter, 2 cho owner
                int addAccount = dao.addAccount(new Account(email, password, userRole));
                int addUser = dao.addUser(new User(addAccount, username, gender, dob,
                        address, phone, userAvatar), addAccount);
                session.removeAttribute("authCode");
                request.setAttribute("error", "Successful account registration");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            } else {
                request.setAttribute("message", "Confirmation code is incorrect");
                request.getRequestDispatcher("verifyCode.jsp").forward(request, response);
            }
        } else {
            response.getWriter().println("Confirmation code not found. Please try again.");
        }
    }

    private byte[] convertPathToByteArray(Path path) {
        try {
            return Files.readAllBytes(path);
        } catch (IOException e) {
            e.printStackTrace();
            return new byte[0];
        }
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