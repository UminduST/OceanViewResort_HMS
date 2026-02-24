package com.oceanview.dao;

import com.oceanview.model.Reservation;
import com.oceanview.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReservationDAO {

    // 1. Fetch reservations for a specific Guest (Used by Guest Dashboard)
    public List<Reservation> getReservationsByUserId(int userId) {
        List<Reservation> list = new ArrayList<>();
        String sql = "SELECT r.*, rm.room_number, rm.room_type FROM reservations r " +
                "JOIN rooms rm ON r.room_id = rm.room_id WHERE r.user_id = ? ORDER BY r.created_at DESC";
        try (Connection con = DBConnection.getConnection(); PreparedStatement pst = con.prepareStatement(sql)) {
            pst.setInt(1, userId);
            ResultSet rs = pst.executeQuery();
            while (rs.next()) list.add(mapReservation(rs, false));
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    // 2. Fetch a single reservation by ID (Used for Billing)
    public Reservation getReservationById(int id) {
        Reservation r = null;
        String sql = "SELECT r.*, rm.room_number, rm.room_type FROM reservations r " +
                "JOIN rooms rm ON r.room_id = rm.room_id WHERE r.reservation_id = ?";
        try (Connection con = DBConnection.getConnection(); PreparedStatement pst = con.prepareStatement(sql)) {
            pst.setInt(1, id);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) r = mapReservation(rs, false);
        } catch (SQLException e) { e.printStackTrace(); }
        return r;
    }

    // 3. Fetch ALL reservations (Used by Receptionist Front Desk)
    public List<Reservation> getAllReservations() {
        List<Reservation> list = new ArrayList<>();
        // Notice we JOIN the users table here to get the first & last name!
        String sql = "SELECT r.*, rm.room_number, rm.room_type, u.first_name, u.last_name FROM reservations r " +
                "JOIN rooms rm ON r.room_id = rm.room_id " +
                "JOIN users u ON r.user_id = u.user_id ORDER BY r.check_in ASC";
        try (Connection con = DBConnection.getConnection(); PreparedStatement pst = con.prepareStatement(sql); ResultSet rs = pst.executeQuery()) {
            while (rs.next()) list.add(mapReservation(rs, true));
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    // 4. Update the Status of a Reservation (Check-in / Check-out)
    public void updateReservationStatus(int resId, String status) {
        String sql = "UPDATE reservations SET status = ? WHERE reservation_id = ?";
        try (Connection con = DBConnection.getConnection(); PreparedStatement pst = con.prepareStatement(sql)) {
            pst.setString(1, status);
            pst.setInt(2, resId);
            pst.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }

    // Helper Method to map database rows to Java Objects cleanly
    private Reservation mapReservation(ResultSet rs, boolean includeGuestName) throws SQLException {
        Reservation r = new Reservation();
        r.setReservationId(rs.getInt("reservation_id"));
        r.setUserId(rs.getInt("user_id"));
        r.setRoomId(rs.getInt("room_id"));
        r.setCheckIn(rs.getString("check_in"));
        r.setCheckOut(rs.getString("check_out"));
        r.setStatus(rs.getString("status"));
        r.setTotalAmount(rs.getDouble("total_amount"));
        r.setRoomNumber(rs.getString("room_number"));
        r.setRoomType(rs.getString("room_type"));
        if (includeGuestName) {
            r.setGuestName(rs.getString("first_name") + " " + rs.getString("last_name"));
        }
        return r;
    }
}