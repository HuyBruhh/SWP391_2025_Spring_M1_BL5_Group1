package controller.Admin;

import dao.DAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.regex.Pattern;


@WebServlet(name="Edit", urlPatterns={"/edac"})
public class Edit extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Edit</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Edit at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String spassword = request.getParameter("password");
        String srole = request.getParameter("role");
        String smail = request.getParameter("email");
        
        // Lưu lại giá trị đã nhập vào session để hiển thị lại
        request.getSession().setAttribute("editEmail", smail);
        request.getSession().setAttribute("editRole", srole);
        // Không lưu password vì lý do bảo mật
        
        try {
            int role = Integer.parseInt(srole);
            if (role < 1 || role > 4) {  // Phạm vi role từ 1-4
                request.getSession().setAttribute("errorMessage", "Role must be between 1 and 4.");
                response.sendRedirect("manage");  // Chuyển hướng về trang manage để hiển thị modal
                return;
            }
            
            if (!isValidPassword(spassword)) {
                request.getSession().setAttribute("errorMessage", "Password must contain at least 8 characters, including at least one letter, one number, and one special character (!@#$%^&*).");
                response.sendRedirect("manage");  // Chuyển hướng về trang manage để hiển thị modal
                return;
            }
            
            // Nếu validate thành công
            DAO dao = new DAO();
            dao.editAccount(smail, spassword, srole);
            
            // Thêm thông báo thành công
            request.getSession().setAttribute("successMessage", "Account updated successfully!");
            response.sendRedirect("manage");
            
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("errorMessage", "Invalid role format. Must be a number.");
            response.sendRedirect("manage");
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "An error occurred while updating the account: " + e.getMessage());
            response.sendRedirect("manage");
        }
    }
    
    private boolean isValidPassword(String password) {
        // Regex để kiểm tra mật khẩu:
        // - Tối thiểu 8 ký tự
        // - Ít nhất một chữ cái
        // - Ít nhất một số
        // - Ít nhất một ký tự đặc biệt (!@#$%^&*)
        String regex = "^(?=.*[a-zA-Z])(?=.*\\d)(?=.*[!@#$%^&*]).{8,}$";
        return Pattern.compile(regex).matcher(password).matches();
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}