// Servlet to calculate stay duration and total cost
package com.oceanview.servlet;

import com.oceanview.dao.RoomDAO;
import com.oceanview.util.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

@WebServlet("/addReservation")
public class AddReservationServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        // 1. Get User ID from session and Form Data
        int userId = (int) session.getAttribute("userId");
        int roomId = Integer.parseInt(request.getParameter("roomId"));
        String checkIn = request.getParameter("checkIn");
        String checkOut = request.getParameter("checkOut");

        // 2. Calculate Total Amount
        LocalDate inDate = LocalDate.parse(checkIn);
        LocalDate outDate = LocalDate.parse(checkOut);
        long days = ChronoUnit.DAYS.between(inDate, outDate);

        RoomDAO roomDao = new RoomDAO();
        double price = roomDao.getRoomPriceById(roomId);
        double totalAmount = days * price;

        // 3. Insert into Database
        String sql = "INSERT INTO reservations (user_id, room_id, check_in, check_out, status, total_amount) VALUES (?, ?, ?, ?, 'BOOKED', ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {
            pst.setInt(1, userId);
            pst.setInt(2, roomId);
            pst.setString(3, checkIn);
            pst.setString(4, checkOut);
            pst.setDouble(5, totalAmount);

            int rows = pst.executeUpdate();
            if (rows > 0) {
                // 4. Update Room Status
                roomDao.updateRoomStatus(roomId, "BOOKED");
                response.sendRedirect("reservation/viewMyReservations.jsp?msg=success");
            } else {
                response.sendRedirect("reservation/addReservation.jsp?error=true");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("reservation/addReservation.jsp?error=db");
        }
    }
}