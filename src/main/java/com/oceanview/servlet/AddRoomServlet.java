package com.oceanview.servlet;

import com.oceanview.util.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/addRoom")
public class AddRoomServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String roomNum = request.getParameter("roomNumber");
        String type = request.getParameter("roomType");
        int floor = Integer.parseInt(request.getParameter("floorNumber"));
        int maxGuests = Integer.parseInt(request.getParameter("maxGuests"));
        double price = Double.parseDouble(request.getParameter("price"));
        String amenities = request.getParameter("amenities");

        String sql = "INSERT INTO rooms (room_number, room_type, floor_number, max_guests, price_per_night, status, amenities) VALUES (?, ?, ?, ?, ?, 'AVAILABLE', ?)";

        try (Connection con = DBConnection.getConnection(); PreparedStatement pst = con.prepareStatement(sql)) {
            pst.setString(1, roomNum);
            pst.setString(2, type);
            pst.setInt(3, floor);
            pst.setInt(4, maxGuests);
            pst.setDouble(5, price);
            pst.setString(6, amenities);

            pst.executeUpdate();
            response.sendRedirect("manager/addRoom.jsp?msg=success");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("manager/addRoom.jsp?error=true");
        }
    }
}