<%-- Completed Front Desk management dashboard --%>
<%@ page import="com.oceanview.dao.ReservationDAO" %>
<%@ page import="com.oceanview.model.Reservation" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Front Desk - Manage Bookings</title>
    <style>
        body { font-family: sans-serif; background-color: #f4f7f6; padding: 20px; }
        .table-container { background: white; padding: 20px; border-radius: 10px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); max-width: 1000px; margin: auto; }
        table { width: 100%; border-collapse: collapse; margin-top: 15px; }
        th, td { padding: 12px; text-align: center; border-bottom: 1px solid #ddd; }
        th { background-color: #28a745; color: white; }
        .btn-checkin { background-color: #17a2b8; color: white; padding: 6px 12px; text-decoration: none; border-radius: 3px; font-weight: bold; }
        .btn-checkout { background-color: #dc3545; color: white; padding: 6px 12px; text-decoration: none; border-radius: 3px; font-weight: bold; }
        .status-text { font-weight: bold; color: #555; }
    </style>
</head>
<body>
<div class="table-container">
    <h2 style="text-align: center;">🛎️ Front Desk Bookings</h2>

    <% if ("success".equals(request.getParameter("msg"))) { %>
    <p style="color: green; text-align: center; font-weight: bold;">Update Successful!</p>
    <% } %>

    <table>
        <tr>
            <th>ID</th>
            <th>Guest Name</th>
            <th>Room</th>
            <th>Check-in</th>
            <th>Check-out</th>
            <th>Status</th>
            <th>Action</th>
        </tr>
        <%
            ReservationDAO dao = new ReservationDAO();
            List<Reservation> allReservations = dao.getAllReservations();

            for (Reservation r : allReservations) {
        %>
        <tr>
            <td>#<%= r.getReservationId() %></td>
            <td><%= r.getGuestName() %></td>
            <td><%= r.getRoomNumber() %> (<%= r.getRoomType() %>)</td>
            <td><%= r.getCheckIn() %></td>
            <td><%= r.getCheckOut() %></td>
            <td class="status-text"><%= r.getStatus() %></td>
            <td>
                <% if ("BOOKED".equals(r.getStatus())) { %>
                <a href="../updateBooking?id=<%= r.getReservationId() %>&action=checkin" class="btn-checkin">Check In 🟢</a>
                <% } else if ("CHECKED_IN".equals(r.getStatus())) { %>
                <a href="../updateBooking?id=<%= r.getReservationId() %>&action=checkout" class="btn-checkout">Check Out 🔴</a>
                <% } else { %>
                <span style="color: gray;">Done ✔️</span>
                <% } %>
            </td>
        </tr>
        <% } %>
    </table>
    <br>
    <center><a href="../dashboard/receptionistDashboard.jsp" style="text-decoration: none; color: #28a745;">⬅ Back to Dashboard</a></center>
</div>
</body>
</html>