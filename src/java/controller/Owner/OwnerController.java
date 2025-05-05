package controller.Owner;

import com.google.gson.Gson;
import com.google.gson.JsonSyntaxException;
import com.google.gson.reflect.TypeToken;
import dao.RenterDAO;
import dao.RequestDAO;
import java.lang.reflect.Type;
import dao.RoomDAO;
import dao.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import java.util.ArrayList;
import java.util.Vector;
import jakarta.servlet.http.Part;
import java.io.BufferedReader;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.time.LocalDate;
import java.time.Period;
import java.time.format.DateTimeParseException;
import java.util.Base64;
import java.util.Locale;
import model.*;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

@WebServlet(name = "OwnerController", urlPatterns = {"/OwnerController"})
@MultipartConfig
public class OwnerController extends HttpServlet {

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
        String service = request.getParameter("service");
        HttpSession session = request.getSession();
        UserDAO userDAO = new UserDAO();
        String email = (String) session.getAttribute("email");
        String password = (String) session.getAttribute("password");
        int userRole = userDAO.getUserRoleByEmailAndPassword(email, password);
        if (userRole != 2) {
            request.setAttribute("error", "You have to login first!!!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        if (service == null) {
            service = "OwnerHome";
        }
        request.setAttribute("service", service);

        if (service.equals("OwnerHome")) {
            OwnerHome(request, response);
        } else if (service.equals("pagingRoom")) {
            listRoom(request, response);
        } else if (service.equals("ownerProfile")) {
            getOwnerProfile(request, response, 0);
        } else if (service.equals("editOwnerProfile")) {
            getOwnerProfile(request, response, 1);
        } else if (service.equals("updateOwnerProfile")) {
            updateOwnerProfile(request, response);
        } else if (service.equals("updateAvatar")) {
            updateAvatar(request, response);
        } else if (service.equals("roomDetail")) {
            roomDetail(request, response, 0);
        } else if (service.equals("editRoom")) {
            roomDetail(request, response, 1);
        } else if (service.equals("deleteItem")) {
            deleteItem(request, response);
        } else if (service.equals("addItem")) {
            addItem(request, response);
        } else if (service.equals("updateRoomDetail")) {
            updateRoomDetail(request, response);
        } else if (service.equals("updateRoomItem")) {
            updateRoomItem(request, response);
        } else if (service.equals("listrequest")) {
            requestList(request, response, 0);
        } else if (service.equals("changereqstatus")) {
            requestList(request, response, 1);
        } else if (service.equals("updateRoomStatus")) {
            updateRoomStatus(request, response);
        } else if (service.equals("setUnderRepair")) {
            setUnderRepair(request, response);
        }
        else if (service.equals("addRoom")) {
            addRoom(request, response);
        }
    }

    private void OwnerHome(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("Owner/OwnerHome.jsp").forward(request, response);
    }

    private void listRoom(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            HttpSession session = request.getSession();
    int ownerID = (int) session.getAttribute("userID");
    
 String rawPage = request.getParameter("page");
    int page = 1;
    if (rawPage != null) {
        try { page = Math.max(1, Integer.parseInt(rawPage)); }
        catch (NumberFormatException ignored) {}
    }

    final int PAGE_SIZE = 6;
    RoomDAO dao = new RoomDAO();

    // tổng phòng và tổng trang
    int totalRooms = dao.countRoomsByOwnerId(ownerID);
    int totalPage = (totalRooms + PAGE_SIZE - 1) / PAGE_SIZE;

    // lấy rooms theo trang
    List<Rooms> rooms = dao.getRoomsByOwnerId(ownerID, page, PAGE_SIZE);

    request.setAttribute("roomList", rooms);
    request.setAttribute("currentPage", page);
    request.setAttribute("totalPage", totalPage);
    request.getRequestDispatcher("Owner/rooms.jsp")
           .forward(request, response);
    }

    private void roomDetail(HttpServletRequest request, HttpServletResponse response, int flag) throws ServletException, IOException {
        RoomDAO dao = new RoomDAO();
        RenterDAO daoRenter = new RenterDAO();
        HttpSession session = request.getSession();
        
        int roomID = Integer.parseInt(request.getParameter("roomID"));
        RoomDetailSe roomDetail = dao.getRoomDetail(roomID);
        
        BigDecimal rawFee = dao.getRoomFee(roomID);
        BigDecimal displayFee = rawFee.multiply(BigDecimal.valueOf(1000));
        DecimalFormatSymbols symbols = new DecimalFormatSymbols(new Locale("vi","VN"));
        symbols.setGroupingSeparator('.');
        DecimalFormat df = new DecimalFormat("#,##0", symbols);
        String formattedFee = df.format(displayFee); 
        
        request.setAttribute("formattedFee", formattedFee);
        List<String> listNameRenter = daoRenter.getRenterName(roomID);
        request.setAttribute("roomDetail", roomDetail);
        request.setAttribute("listNameRenter", listNameRenter);
        session.setAttribute("roomID", roomID);

        if (flag == 0) {
            request.getRequestDispatcher("Owner/roomDetail.jsp").forward(request, response);
        } else if (flag == 1) {
            List<String> listItemNames = dao.getItemName();
            String[] listItem = listItemNames.toArray(new String[0]);
            request.setAttribute("listItem", listItem);
            request.getRequestDispatcher("Owner/editRoom.jsp").forward(request, response);
        }
    }

    private void addRoom(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String flag = request.getParameter("flag");
        if (flag != null && Integer.parseInt(flag) == 1) { // form submit
            RoomDAO dao = new RoomDAO();
            int ownerID = (int) request.getSession().getAttribute("userID");
            int roomNumber = Integer.parseInt(request.getParameter("roomNumber").trim());
            int roomFloor = Integer.parseInt(request.getParameter("roomFloor").trim());
            if (dao.isExistRoom(roomNumber, roomFloor, ownerID)) {
                request.setAttribute("error", "Room number and room floor is exist!");
                request.getRequestDispatcher("Owner/add-room.jsp").forward(request, response);
                return;
            }

            int roomSize = Integer.parseInt(request.getParameter("roomSize").trim());

            Part photo = request.getPart("roomImg");
            byte[] roomImg_raw = convertInputStreamToByteArray(photo.getInputStream());
            String roomImg = Base64.getEncoder().encodeToString(roomImg_raw);

            String feeInput = request.getParameter("roomFee").trim();       // e.g. "800.000" hoặc "1234500"
            String cleaned  = feeInput.replace(".", "");                    // "800000" hoặc "1234500"
            BigDecimal roomFee = new BigDecimal(cleaned);                   // 800000 hoặc 1234500

            Room r = new Room(roomNumber, roomFloor, roomSize, roomFee, roomImg);
            dao.addRoom(r, ownerID);
             int roomID = dao.getLastestRoom().getRoomID();
             request.getRequestDispatcher("OwnerController?service=roomDetail&roomID=" + roomID).forward(request, response);

        } else {
            request.getRequestDispatcher("Owner/add-room.jsp").forward(request, response);
        }
    }

    private void deleteItem(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RoomDAO dao = new RoomDAO();
        int roomID = Integer.parseInt(request.getParameter("roomID"));
        int itemID = Integer.parseInt(request.getParameter("itemID"));
        int remove = dao.deleteRoomItem(roomID, itemID);
        request.getRequestDispatcher("OwnerController?service=editRoom").forward(request, response);
    }

    private void addItem(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RoomDAO dao = new RoomDAO();
        String itemName = request.getParameter("itemName");
        int roomID = Integer.parseInt(request.getParameter("roomID"));
        int quantity = Integer.parseInt(request.getParameter("quantity").trim());
        int itemID = dao.getItemIDOrQuantityByItemName(itemName, 0, 0);
        RoomDetailSe roomDetail = dao.getRoomDetail(roomID);

        String[] listItemName = roomDetail.getItemName();
        for (String string : listItemName) {
            if (string.equalsIgnoreCase(itemName)) {
                int newQuantity = dao.getItemIDOrQuantityByItemName(itemName, 1, roomID) + quantity;
                int updateQuantity = dao.updateItemQuantity(roomID, itemID, newQuantity);
                request.getRequestDispatcher("OwnerController?service=editRoom").forward(request, response);
                return;
            }
        }
        int addItem = dao.addRoomItem(roomID, itemID, quantity);
        request.getRequestDispatcher("OwnerController?service=editRoom").forward(request, response);
    }

    private void getOwnerProfile(HttpServletRequest request, HttpServletResponse response, int flag) throws ServletException, IOException {
        RoomDAO dao = new RoomDAO();
        HttpSession session = request.getSession();

        int userID = (int) session.getAttribute("userID");

        User ownerProfile = dao.getOwnerProfileByID(userID);
        request.setAttribute("ownerProfile", ownerProfile);
        if (flag == 0) {
            request.getRequestDispatcher("Owner/ownerProfile.jsp").forward(request, response);
        } else if (flag == 1) {
            request.getRequestDispatcher("Owner/formOwnerProfile.jsp").forward(request, response);
        }
    }

    private void updateAvatar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RoomDAO dao = new RoomDAO();
        Part photo = request.getPart("img");
        HttpSession session = request.getSession();
        int userID = (int) session.getAttribute("userID");
        byte[] avatar_raw = convertInputStreamToByteArray(photo.getInputStream());
        String avatar = Base64.getEncoder().encodeToString(avatar_raw);
        int updateAvatar = dao.updateAvatar(new User(15, avatar));
        request.getRequestDispatcher("OwnerController?service=editOwnerProfile").forward(request, response);
    }

    private void updateRoomDetail(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RoomDAO dao = new RoomDAO();
        List<Rooms> listRoom = dao.getRooms();
        int roomID = Integer.parseInt(request.getParameter("roomID"));
        RoomDetailSe roomDetail = dao.getRoomDetail(roomID);
        int currentRoomNumber = roomDetail.getRoomNumber();
        double roomFee = 0;
        int roomNumber = 0;

        try {
            roomNumber = Integer.parseInt(request.getParameter("roomNumber").trim());
            if (roomNumber <= 0) {
                request.setAttribute("error", "Invalid room number");
                request.getRequestDispatcher("OwnerController?service=editRoom&roomID=" + roomID).forward(request, response);
                return;
            }
            if (!dao.isExistRoomNumber(roomNumber)) {
                if (roomNumber != dao.getCurrentRoomNumber(roomID)) {
                    request.setAttribute("error", "Room number is exist!!!");
                    request.getRequestDispatcher("OwnerController?service=editRoom&roomID=" + roomID).forward(request, response);
                    return;
                }
            }

        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid room number");
            request.getRequestDispatcher("OwnerController?service=editRoom&roomID=" + roomID).forward(request, response);
            return;
        }

        try {
            String s = request.getParameter("roomFee").trim();
            String cleaned = s.replace(".", "");
            double feeVND = Double.parseDouble(cleaned);
            roomFee = feeVND / 1000;  // nếu bạn vẫn lưu theo nghìn VND
            if (roomFee <= 0) {
                request.setAttribute("error", "Room Fee have to great than 0!!!");
                request.getRequestDispatcher("OwnerController?service=editRoom&roomID=" + roomID).forward(request, response);
                return;
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid room fee");
            request.getRequestDispatcher("OwnerController?service=editRoom&roomID=" + roomID).forward(request, response);
            return;
        }
        
        String[] quantities = request.getParameterValues("quantities");
    if (quantities != null) {
        for (String qStr : quantities) {
            try {
                int q = Integer.parseInt(qStr.trim());
                if (q <= 0) {
                    request.setAttribute("error", "Item quantity must be greater than 0.");
                    request.getRequestDispatcher("OwnerController?service=editRoom&roomID=" + roomID)
                           .forward(request, response);
                    return;
                }
            } catch (NumberFormatException ex) {
                request.setAttribute("error", "Invalid quantity format.");
                request.getRequestDispatcher("OwnerController?service=editRoom&roomID=" + roomID)
                       .forward(request, response);
                return;
            }
        }
    }

        Part photo = request.getPart("roomImg");
        String roomImg; 
if (photo != null && photo.getSize() > 0) {
    String contentType = photo.getContentType();
    // chỉ chấp nhận định dạng ảnh
    if (!(contentType.equals("image/jpeg")
       || contentType.equals("image/png")
       || contentType.equals("image/jpg"))) 
    {
        request.setAttribute("error", "Invalid room image format (chỉ JPG/PNG).");
        request.getRequestDispatcher("OwnerController?service=editRoom&roomID=" + roomID)
               .forward(request, response);
        return;
    }
    byte[] roomImg_raw = convertInputStreamToByteArray(photo.getInputStream());
    roomImg = Base64.getEncoder().encodeToString(roomImg_raw);
} else {
    // người dùng không upload ảnh mới => giữ nguyên ảnh cũ
    roomImg = dao.getRoomDetail(roomID).getRoomImg();
}

        int updateRoomDetail = dao.updateRoomDetail(roomID, roomFee, roomImg, roomNumber);
        request.getRequestDispatcher("OwnerController?service=roomDetail").forward(request, response);
    }

    private void updateOwnerProfile(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    RoomDAO dao = new RoomDAO();
    HttpSession session = request.getSession();
    int userID = (int) session.getAttribute("userID");

    boolean hasError = false;
    String fullName = request.getParameter("fullName").trim();
    String dob      = request.getParameter("dob");
    String gender   = request.getParameter("gender");
    String phone    = request.getParameter("phone");
    String address  = request.getParameter("address");

    // Validate họ và tên
    if (fullName.isEmpty()) {
        hasError = true;
        request.setAttribute("fullNameError", "Fullname is required.");
    }
    // Validate số điện thoại
    if (phone == null || phone.length() != 10 || !phone.startsWith("0") || !phone.matches("\\d+")) {
        hasError = true;
        request.setAttribute("phoneError", "Invalid phone number.");
    }
    // Validate địa chỉ
    if (address == null || address.isBlank()) {
        hasError = true;
        request.setAttribute("addressError", "Address is required.");
    }
    // Validate ngày sinh (tuổi 18–110)
    if (dob != null && !dob.isEmpty()) {
        try {
            LocalDate birthDate = LocalDate.parse(dob);
            int age = Period.between(birthDate, LocalDate.now()).getYears();
            if (age < 18) {
                hasError = true;
                request.setAttribute("dobError", "You must be at least 18 years old");
            } else if (age > 110) {
                hasError = true;
                request.setAttribute("dobError", "Your age must not exceed 110.");
            }
        } catch (DateTimeParseException ex) {
            hasError = true;
            request.setAttribute("dobError", "Invalid date of birth format.");
        }
    }

    if (hasError) {
        // Load lại profile để hiển thị form cùng lỗi
        User ownerProfile = dao.getOwnerProfileByID(userID);
        request.setAttribute("ownerProfile", ownerProfile);
        request.getRequestDispatcher("/Owner/formOwnerProfile.jsp")
               .forward(request, response);
    } else {
        // Thực hiện cập nhật
        // Giả sử constructor của User: User(int userID, String fullName, String gender, String dob, String address, String phone)
        User updated = new User(userID, fullName, gender, dob, address, phone);
        dao.updateOwnerProfile(updated);

        // Chuyển về trang xem profile sau khi cập nhật thành công
        response.sendRedirect(request.getContextPath() + "/OwnerController?service=ownerProfile");
    }
    }

    private void updateRoomItem(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RoomDAO dao = new RoomDAO();
        HttpSession session = request.getSession();
        BufferedReader reader = request.getReader();
        StringBuilder sb = new StringBuilder();
        String line;

        while ((line = reader.readLine()) != null) {
            sb.append(line);
        }

        String json = sb.toString();
        System.out.println("Received JSON: " + json);
        int roomID_raw = (int) session.getAttribute("roomID");

        try {
            if (!json.isEmpty()) {
                JSONParser parser = new JSONParser();
                JSONArray jsonArray = (JSONArray) parser.parse(json);

                for (Object obj : jsonArray) {
                    JSONObject jsonObject = (JSONObject) obj;
                    String itemIDStr = (String) jsonObject.get("itemID");
                    String itemName = (String) jsonObject.get("itemName");
                    String quantityStr = (String) jsonObject.get("quantity");
                    String roomIDStr = (String) jsonObject.get("roomID");

                    int itemID = Integer.parseInt(itemIDStr);
                    int quantity = Integer.parseInt(quantityStr);
                    int roomID = Integer.parseInt(roomIDStr);
                    if (quantity <= 0) {
                // nếu quantity không hợp lệ, trả về editRoom với thông báo
                request.setAttribute("error", "Quantity must be greater than 0");
                request.getRequestDispatcher("OwnerController?service=editRoom&roomID=" + roomID)
                       .forward(request, response);
                return;
            } else {
                        dao.updateItemQuantity(roomID, itemID, quantity);
                    }

                }
            } else {
                System.out.println("Received empty JSON.");
            }

            response.sendRedirect("OwnerController?service=roomDetail&roomID=" + roomID_raw);
        } catch (ParseException e) {
            e.printStackTrace();
        }
    }

    public byte[] convertInputStreamToByteArray(InputStream inputStream) throws IOException {
        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        byte[] buffer = new byte[4096]; // Sử dụng một buffer có kích thước lớn hơn cho hiệu suất tốt hơn
        int bytesRead;
        while ((bytesRead = inputStream.read(buffer)) != -1) {
            outputStream.write(buffer, 0, bytesRead);
        }
        return outputStream.toByteArray();
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
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private void requestList(HttpServletRequest request, HttpServletResponse response, int flag) throws ServletException, IOException {
        RequestDAO requestDAO = new RequestDAO();
        HttpSession session = request.getSession();
        int ownerID = (int) session.getAttribute("userID");
        if (flag == 0) {
            List<RequestList> requests = requestDAO.getReqListByOwnerID(ownerID);
            request.setAttribute("requests", requests);
            request.setAttribute("debugOwnerID", ownerID);

            request.getRequestDispatcher("Owner/OwnerRequest.jsp").forward(request, response);
        } else if (flag == 1) {
            // REQUEST STATUS UPDATE
            String rawRequestId = request.getParameter("requestId");
            String status = request.getParameter("status");

            if (rawRequestId != null && status != null) {
                try {
                    int requestId = Integer.parseInt(rawRequestId);
                    // Fetch the current request
                    RequestList currentRequest = requestDAO.getRequestByID(requestId);

                    if (currentRequest != null) {
                        // Update the request status regardless of the current state
                        boolean updateSuccess = requestDAO.updateRequestStatus(status, requestId);

                        if (updateSuccess) {
                            // Set success message
                            request.getSession().setAttribute("message", "Request status updated successfully.");
                        } else {
                            // Set failure message
                            request.getSession().setAttribute("message", "Request status updated successfully.");
                        }
                    } else {
                        // Set message if request does not exist
                        request.getSession().setAttribute("message", "Request not found.");
                    }
                } catch (NumberFormatException e) {
                    // Handle invalid request ID format
                    request.getSession().setAttribute("message", "Invalid request ID format.");
                }
            } else {
                // Set message if status or requestId is invalid
                request.getSession().setAttribute("message", "Invalid request parameters.");
            }

            // Redirect back to the list page
            response.sendRedirect("OwnerController?service=listrequest");
        }
    }

    private void updateRoomStatus(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RoomDAO dao = new RoomDAO();
        int roomID = Integer.parseInt(request.getParameter("roomID"));
        int roomStatus = Integer.parseInt(request.getParameter("roomStatus"));
        int roomOccupant = Integer.parseInt(request.getParameter("roomOccupant"));

        if (roomOccupant > 0) {
            request.setAttribute("error", "There is someone renting a room!!!");
            request.getRequestDispatcher("OwnerController?service=editRoom&roomID=" + roomID).forward(request, response);
            return;
        }
        if (roomStatus == 2) {
            int update = dao.updateRoomStatus(roomID, 1); // cap nhat dang sua thanh san sang cho thue
        } else if (roomStatus == 1) {
            int update = dao.updateRoomStatus(roomID, 2); // cap nhat san sang cho thue thanh dang sua
        }

        request.getRequestDispatcher("OwnerController?service=editRoom&roomID=" + roomID).forward(request, response);
    }

    private void setUnderRepair(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RoomDAO dao = new RoomDAO();
        int roomID = Integer.parseInt(request.getParameter("roomID"));
        int roomStatus = Integer.parseInt(request.getParameter("roomStatus"));
        int updateRoomStatus = Integer.parseInt(request.getParameter("updateRoomStatus"));

        if (roomStatus == 2) {
            if (updateRoomStatus == 0) {
                int update = dao.updateRoomStatus(roomID, 0);
            }
        } else if (roomStatus == 0) {
            if (updateRoomStatus == 2) {
                int update = dao.updateRoomStatus(roomID, 2);
            }
        }
        request.setAttribute("error", "Update status successfully!!!");
        request.getRequestDispatcher("OwnerController?service=editRoom&roomID=" + roomID).forward(request, response);
    }

}
