package com.oceanview.servlet;

import com.oceanview.dao.ReservationDAO;
import com.oceanview.model.Reservation;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

@WebServlet("/generateBill")
public class BillServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int resId = Integer.parseInt(request.getParameter("id"));

            ReservationDAO resDao = new ReservationDAO();
            Reservation r = resDao.getReservationById(resId);

            // Calculate Nights for display purposes
            LocalDate checkIn = LocalDate.parse(r.getCheckIn());
            LocalDate checkOut = LocalDate.parse(r.getCheckOut());
            long nights = ChronoUnit.DAYS.between(checkIn, checkOut);

            // Send data to the Guest Bill Page
            request.setAttribute("reservation", r);
            request.setAttribute("nights", nights);

            request.getRequestDispatcher("reservation/guestBill.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("dashboard/guestDashboard.jsp?error=BillFailed");
        }
    }
}