// SQL logic for revenue and occupancy reports
package com.oceanview.dao;

import com.oceanview.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class ReportDAO {

    // 1. Calculate Total Revenue (Only from completed stays)
    public double calculateRevenue() {
        double total = 0;
        String sql = "SELECT SUM(total_amount) AS revenue FROM reservations WHERE status = 'CHECKED_OUT'";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pst = con.prepareStatement(sql);
             ResultSet rs = pst.executeQuery()) {

            if (rs.next()) {
                total = rs.getDouble("revenue");
            }
        } catch (Exception e) { e.printStackTrace(); }
        return total;
    }

    // 2. Count Total Bookings Ever Made
    public int getTotalBookings() {
        int count = 0;
        String sql = "SELECT COUNT(*) AS total FROM reservations";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pst = con.prepareStatement(sql);
             ResultSet rs = pst.executeQuery()) {

            if (rs.next()) {
                count = rs.getInt("total");
            }
        } catch (Exception e) { e.printStackTrace(); }
        return count;
    }

    // 3. Count Rooms by their Current Status (Available, Booked, Cleaning)
    public int getRoomCountByStatus(String status) {
        int count = 0;
        String sql = "SELECT COUNT(*) AS total FROM rooms WHERE status = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {

            pst.setString(1, status);
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                count = rs.getInt("total");
            }
        } catch (Exception e) { e.printStackTrace(); }
        return count;
    }
}