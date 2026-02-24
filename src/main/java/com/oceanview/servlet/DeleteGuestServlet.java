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
import java.sql.SQLIntegrityConstraintViolationException;

@WebServlet("/deleteGuest")
public class DeleteGuestServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int userId = Integer.parseInt(request.getParameter("id"));
        String sql = "DELETE FROM users WHERE user_id = ? AND role = 'GUEST'";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {

            pst.setInt(1, userId);
            int rows = pst.executeUpdate();

            if (rows > 0) {
                response.sendRedirect("receptionist/manageGuests.jsp?msg=deleted");
            } else {
                response.sendRedirect("receptionist/manageGuests.jsp?error=notfound");
            }
        } catch (SQLIntegrityConstraintViolationException e) {
            // This happens if the guest has active reservations!
            response.sendRedirect("receptionist/manageGuests.jsp?error=hasBooking");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("receptionist/manageGuests.jsp?error=true");
        }
    }
}