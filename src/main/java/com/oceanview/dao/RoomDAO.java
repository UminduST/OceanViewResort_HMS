package com.oceanview.dao;

import com.oceanview.model.Room;
import com.oceanview.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class RoomDAO {

    // Fetch ONLY available rooms for the Guest
    public List<Room> getAvailableRooms() {
        List<Room> rooms = new ArrayList<>();
        String sql = "SELECT * FROM rooms WHERE status = 'AVAILABLE'";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement pst = con.prepareStatement(sql);
             ResultSet rs = pst.executeQuery()) {
            while (rs.next()) {
                Room r = new Room();
                r.setRoomId(rs.getInt("room_id"));
                r.setRoomNumber(rs.getString("room_number"));
                r.setRoomType(rs.getString("room_type"));
                r.setPricePerNight(rs.getDouble("price_per_night"));
                rooms.add(r);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return rooms;
    }

    // Get price by ID
    public double getRoomPriceById(int roomId) {
        double price = 0;
        String sql = "SELECT price_per_night FROM rooms WHERE room_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {
            pst.setInt(1, roomId);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) price = rs.getDouble("price_per_night");
        } catch (Exception e) { e.printStackTrace(); }
        return price;
    }

    // Update room status to BOOKED
    public void updateRoomStatus(int roomId, String status) {
        String sql = "UPDATE rooms SET status = ? WHERE room_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {
            pst.setString(1, status);
            pst.setInt(2, roomId);
            pst.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }
    // --- LEGACY METHODS TO FIX COMPILATION ERRORS ---
    // (Used by older servlets. We will update them later)

    public double getRoomPrice(String roomType) {
        double price = 0;
        String sql = "SELECT price_per_night FROM rooms WHERE room_type = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {
            pst.setString(1, roomType);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) price = rs.getDouble("price_per_night");
        } catch (Exception e) { e.printStackTrace(); }
        return price;
    }

    public boolean updateRoomPrice(String roomType, double newPrice) {
        String sql = "UPDATE rooms SET price_per_night = ? WHERE room_type = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {
            pst.setDouble(1, newPrice);
            pst.setString(2, roomType);
            return pst.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); return false; }
    }
}
