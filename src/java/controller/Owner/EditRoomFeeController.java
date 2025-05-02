/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.Owner;

import dao.BillDAO;
import dao.RoomDAO;
import model.Bill;
import model.Room;
import model.UsagePrice;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "EditRoomFeeController", urlPatterns = {"/EditRoomFeeController"})
public class EditRoomFeeController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
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
            out.println("<title>Servlet EditRoomFeeController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditRoomFeeController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String billId_raw = request.getParameter("id");

        HttpSession session = request.getSession();
        BillDAO daoBill = new BillDAO();
        int billId = 0;
        try {
            billId = Integer.parseInt(billId_raw);
            Bill bill = daoBill.getBillBybillID(billId);

            if (bill == null) {
                request.setAttribute("errorMessage", "Bill not found");
                request.getRequestDispatcher("Owner/error.jsp").forward(request, response);
                return;
            }

            // Store billID in session
            session.setAttribute("billID", billId);

            // Get roomID from the bill and store it in session
            int roomID = bill.getRoomID(); // Ensure your Bill model has getRoomID() method
            session.setAttribute("roomID", roomID);

            // Get room details using the correct roomID
            RoomDAO daoRoom = new RoomDAO();
            Room room = daoRoom.getRoomDetailByID(roomID);

            UsagePrice price = daoBill.getEWPrice();
            double eprice = price.getEprice();
            double wprice = price.getWprice();

            // Lấy tiền điện nước từ bill
            double eBill = bill.getElectric(); // Phương thức lấy tiền điện từ Bill
            double wBill = bill.getWater();    // Phương thức lấy tiền nước từ Bill

            // Tính ngược lại số lượng điện nước đã sử dụng để hiển thị trên form
            double elnum = (eprice > 0) ? eBill / eprice : 0;
            double wnum = (wprice > 0) ? wBill / wprice : 0;

            // Thêm thông tin vào request để hiển thị trên form
            request.setAttribute("eprice", eprice);
            request.setAttribute("wprice", wprice);
            request.setAttribute("elnum", elnum);  // Số lượng điện
            request.setAttribute("wnum", wnum);    // Số lượng nước
            request.setAttribute("room", room);
            request.setAttribute("billDetail", bill);

        } catch (NumberFormatException e) {
            System.err.println("Failed to parse ID: " + e);
            request.setAttribute("errorMessage", "Invalid bill ID format");
            request.getRequestDispatcher("Owner/error.jsp").forward(request, response);
            return;
        } catch (Exception e) {
            System.err.println("Error while processing request: " + e);
            request.setAttribute("errorMessage", "An error occurred while processing your request");
            request.getRequestDispatcher("Owner/error.jsp").forward(request, response);
            return;
        }

        request.getRequestDispatcher("Owner/editroomfee.jsp").forward(request, response);
    }

    /**
     * Validates that a value is divisible by a specified divisor
     *
     * @param value The value to check
     * @param divisor The divisor to check against
     * @return True if the value is divisible by the divisor, false otherwise
     */
    private boolean isDivisibleBy(double value, double divisor) {
        // Handle potential floating point precision issues
        double remainder = value % divisor;
        return Math.abs(remainder) < 0.00001; // Very small threshold for floating point comparison
    }

    /**
     * Rounds a value up to be divisible by a specified divisor
     *
     * @param value The value to round
     * @param divisor The divisor to ensure divisibility by
     * @return The rounded value
     */
    private double roundToDivisible(double value, double divisor) {
        return Math.ceil(value / divisor) * divisor;
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Get billID from session
            HttpSession session = request.getSession();
            if (session.getAttribute("billID") == null) {
                request.setAttribute("errorMessage", "Bill ID not found in session");
                request.getRequestDispatcher("Owner/error.jsp").forward(request, response);
                return;
            }

            int billId = Integer.parseInt(session.getAttribute("billID").toString());
            int roomID = Integer.parseInt(session.getAttribute("roomID").toString());

            // Parse and validate form data
            double service = Double.parseDouble(request.getParameter("service"));

            // Lấy số lượng điện nước đã sử dụng
            double elnum = Double.parseDouble(request.getParameter("electric"));
            double wnum = Double.parseDouble(request.getParameter("water"));

            // Lấy đơn giá điện nước
            BillDAO billDAO = new BillDAO();
            UsagePrice price = billDAO.getEWPrice();
            double eprice = price.getEprice();
            double wprice = price.getWprice();

            // Tính tổng tiền điện và nước
            double etotal = eprice * elnum;
            double wtotal = wprice * wnum;

            // Kiểm tra và làm tròn tiền điện để chia hết cho 2.5
            if (!isDivisibleBy(etotal, 3)) {
                etotal = roundToDivisible(etotal, 3);
            }

// Kiểm tra và làm tròn tiền nước để chia hết cho 10
            if (!isDivisibleBy(wtotal, 10)) {
                wtotal = roundToDivisible(wtotal, 10);
            }

            BigDecimal roomFee = new BigDecimal(request.getParameter("roomFee"));
            double other = Double.parseDouble(request.getParameter("other"));
            double penMoney = Double.parseDouble(request.getParameter("penMoney"));
            String deadline = request.getParameter("deadline");
            String payAt = request.getParameter("payAt");

            // Sử dụng etotal và wtotal đã làm tròn
            boolean success = billDAO.updateFeeById(billId, service, etotal, wtotal, roomFee, other, penMoney, deadline, payAt);

            String updateMessage = success ? "Update Successful" : "Update Failed";
            request.setAttribute("updateMessage", updateMessage);

            if (success) {
                // If successful, redirect to a confirmation page or back to the room fee list
                request.getRequestDispatcher("/Owner/editroomfee.jsp?id=" + roomID).forward(request, response);
            } else {
                // If failed, return to the edit page
                request.getRequestDispatcher("Owner/editroomfee.jsp").forward(request, response);
            }

        } catch (NumberFormatException e) {
            System.err.println("Error parsing form data: " + e);
            request.setAttribute("errorMessage", "Invalid input data format");
            request.getRequestDispatcher("Owner/editroomfee.jsp").forward(request, response);
        } catch (Exception e) {
            System.err.println("Error updating fee: " + e);
            request.setAttribute("errorMessage", "An error occurred while updating the fee");
            request.getRequestDispatcher("Owner/editroomfee.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
