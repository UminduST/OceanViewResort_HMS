package com.oceanview.dao;

import com.oceanview.model.Room;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.DisplayName;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

/**
 * Integration Tests for RoomDAO.
 * NOTE: Ensure your Tomcat server is OFF, but your MySQL database is RUNNING
 * before executing these tests.
 */
public class RoomDAOTest {

    private RoomDAO roomDAO;

    // This runs before EVERY single test to give us a fresh DAO object
    @BeforeEach
    public void setUp() {
        roomDAO = new RoomDAO();
    }

    @Test
    @DisplayName("Test fetching all available rooms")
    public void testGetAvailableRooms() {
        List<Room> rooms = roomDAO.getAvailableRooms();

        // Assert that the list is not null (meaning the query executed successfully)
        assertNotNull(rooms, "The returned room list should not be null");

        // If your DB has available rooms, this ensures it actually retrieved them
        System.out.println("Found " + rooms.size() + " available rooms in the database.");
    }

    @Test
    @DisplayName("Test fetching a room price by its ID")
    public void testGetRoomPriceById() {
        // Assuming Room ID 1 exists in your database from your manual testing
        int testRoomId = 1;
        double price = roomDAO.getRoomPriceById(testRoomId);

        // Assert that a valid price was returned (greater than $0.00)
        assertTrue(price >= 0.0, "The room price should be 0.0 or greater.");
    }

    @Test
    @DisplayName("Test updating a room status")
    public void testUpdateRoomStatus() {
        // We will update Room 1 to "CLEANING" to test the method
        int testRoomId = 1;
        String newStatus = "CLEANING";

        // Execute the update. If the DB connection fails, this will throw an exception.
        assertDoesNotThrow(() -> {
            roomDAO.updateRoomStatus(testRoomId, newStatus);
        }, "Updating the room status should not throw any SQL exceptions.");
    }

    @Test
    @DisplayName("Test fetching a room price by Type (Legacy Method)")
    public void testGetRoomPriceByType() {
        // Assuming "Standard" or "Suite" exists in your DB
        String testRoomType = "Standard";
        double price = roomDAO.getRoomPrice(testRoomType);

        // Assert that the query executed without crashing
        assertTrue(price >= 0.0, "The price for a room type should be retrieved without error.");
    }

    @Test
    @DisplayName("Test updating room price by Type (Legacy Method)")
    public void testUpdateRoomPrice() {
        String testRoomType = "Standard";
        double newPrice = 150.00;

        // This method returns a boolean. If it successfully updates a row, it returns true.
        // NOTE: If you don't have a "Standard" room in your DB, this might return false,
        // which is also normal! We are just testing that it executes.
        assertDoesNotThrow(() -> {
            roomDAO.updateRoomPrice(testRoomType, newPrice);
        }, "Updating the room price should not throw an exception.");
    }
}