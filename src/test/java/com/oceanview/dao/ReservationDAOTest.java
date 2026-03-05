package com.oceanview.dao;

import com.oceanview.model.Reservation;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.DisplayName;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

/**
 * Integration Tests for ReservationDAO.
 * NOTE: Ensure your MySQL database is RUNNING before executing these tests.
 */
public class ReservationDAOTest {

    private ReservationDAO reservationDAO;

    // This runs before EVERY single test to initialize the DAO
    @BeforeEach
    public void setUp() {
        reservationDAO = new ReservationDAO();
    }

    @Test
    @DisplayName("Test fetching reservations for a specific Guest")
    public void testGetReservationsByUserId() {
        // Assuming a guest with user_id 1 exists in your database
        int testUserId = 1;
        List<Reservation> reservations = reservationDAO.getReservationsByUserId(testUserId);

        // Assert that the list initializes properly (even if empty, it shouldn't be null)
        assertNotNull(reservations, "The reservation list should not be null.");
        System.out.println("Found " + reservations.size() + " reservations for User ID: " + testUserId);
    }

    @Test
    @DisplayName("Test fetching a single reservation by its ID")
    public void testGetReservationById() {
        // Assuming reservation_id 1 exists
        int testResId = 1;

        // We ensure the complex JOIN SQL syntax is correct and executes cleanly
        assertDoesNotThrow(() -> {
            Reservation r = reservationDAO.getReservationById(testResId);
            if (r != null) {
                System.out.println("Successfully fetched Reservation #" + r.getReservationId() + " for Room: " + r.getRoomNumber());
            } else {
                System.out.println("Reservation #" + testResId + " does not exist, but query executed successfully.");
            }
        }, "Fetching a reservation by ID should not throw an SQL exception.");
    }

    @Test
    @DisplayName("Test fetching ALL reservations for the Front Desk")
    public void testGetAllReservations() {
        List<Reservation> allReservations = reservationDAO.getAllReservations();

        // Assert that the query pulling from reservations, rooms, and users works
        assertNotNull(allReservations, "The master reservation list should not be null.");
        System.out.println("Total reservations across the entire hotel: " + allReservations.size());
    }

    @Test
    @DisplayName("Test updating a reservation's status")
    public void testUpdateReservationStatus() {
        int testResId = 1;
        String newStatus = "CHECKED_IN";

        // Assert that the UPDATE statement executes without crashing
        assertDoesNotThrow(() -> {
            reservationDAO.updateReservationStatus(testResId, newStatus);
        }, "Updating reservation status should not throw any SQL exceptions.");
    }
}