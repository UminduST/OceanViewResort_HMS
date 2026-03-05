package com.oceanview.dao;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.DisplayName;

import static org.junit.jupiter.api.Assertions.*;

/**
 * Integration Tests for ReportDAO.
 * NOTE: Ensure your MySQL database is RUNNING before executing these tests.
 */
public class ReportDAOTest {

    private ReportDAO reportDAO;

    // This runs before EVERY single test to initialize the DAO
    @BeforeEach
    public void setUp() {
        reportDAO = new ReportDAO();
    }

    @Test
    @DisplayName("Test calculation of Total Revenue")
    public void testCalculateRevenue() {
        // Execute the query to calculate revenue
        double revenue = reportDAO.calculateRevenue();

        // Assert that the revenue is correctly calculated as a positive number or zero
        assertTrue(revenue >= 0.0, "Total revenue should never be negative.");
        System.out.println("Total Revenue recorded in DB: $" + revenue);
    }

    @Test
    @DisplayName("Test counting Total Bookings Ever Made")
    public void testGetTotalBookings() {
        // Execute the query to count all reservations
        int totalBookings = reportDAO.getTotalBookings();

        // Assert that the total bookings count is zero or greater
        assertTrue(totalBookings >= 0, "Total bookings count should be 0 or greater.");
        System.out.println("Total Bookings recorded in DB: " + totalBookings);
    }

    @Test
    @DisplayName("Test counting rooms by AVAILABLE status")
    public void testGetRoomCountAvailable() {
        // Test counting available rooms
        int availableCount = reportDAO.getRoomCountByStatus("AVAILABLE");

        // Assert that the count is valid
        assertTrue(availableCount >= 0, "Available room count should be 0 or greater.");
        System.out.println("Available Rooms: " + availableCount);
    }

    @Test
    @DisplayName("Test counting rooms by CLEANING status")
    public void testGetRoomCountCleaning() {
        // Test counting rooms that currently need cleaning
        int cleaningCount = reportDAO.getRoomCountByStatus("CLEANING");

        // Assert that the count is valid
        assertTrue(cleaningCount >= 0, "Cleaning room count should be 0 or greater.");
    }
}