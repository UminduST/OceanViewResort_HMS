// Logic to trigger cleaning status on checkout
package com.oceanview.servlet;

import com.oceanview.dao.ReservationDAO;
import com.oceanview.dao.RoomDAO;
import com.oceanview.model.Reservation;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/updateBooking")
public class UpdateBookingServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int resId = Integer.parseInt(request.getParameter("id"));
        String action = request.getParameter("action"); // 'checkin' or 'checkout'

        ReservationDAO resDao = new ReservationDAO();
        RoomDAO roomDao = new RoomDAO();

        if ("checkin".equals(action)) {
            // Update Reservation to CHECKED_IN
            resDao.updateReservationStatus(resId, "CHECKED_IN");

        } else if ("checkout".equals(action)) {
            // 1. Update Reservation to CHECKED_OUT
            resDao.updateReservationStatus(resId, "CHECKED_OUT");

            // 2. Automatically set the Room to CLEANING
            Reservation r = resDao.getReservationById(resId);
            roomDao.updateRoomStatus(r.getRoomId(), "CLEANING");
        }

        response.sendRedirect("receptionist/manageBookings.jsp?msg=success");
    }
}