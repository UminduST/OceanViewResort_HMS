<%@ page import="com.oceanview.dao.ReservationDAO" %>
<%@ page import="com.oceanview.model.Reservation" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Security check: Make sure a user is logged in
    if (session.getAttribute("userId") == null) { response.sendRedirect("../login.jsp"); return; }
%>
<!DOCTYPE html>
<html>
<head>
    <title>My Reservations</title>
    <style>
        body { font-family: sans-serif; background-color: #f4f7f6; padding: 20px; }
        .table-container { background: white; padding: 20px; border-radius: 10px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); max-width: 900px; margin: auto; }
        table { width: 100%; border-collapse: collapse; margin-top: 15px; }
        th, td { padding: 12px; text-align: center; border-bottom: 1px solid #ddd; }
        th { background-color: #007bff; color: white; }
        .status-booked { color: #d35400; font-weight: bold; }
        .btn-print { background-color: #28a745; color: white; padding: 5px 10px; text-decoration: none; border-radius: 3px; font-size: 14px; }
        .back-link { display: block; margin-top: 20px; text-align: center; color: #007bff; text-decoration: none; }
    </style>
</head>
<body>

<div class="table-container">
    <h2 style="text-align: center;">🧳 My Bookings</h2>

    <% if ("success".equals(request.getParameter("msg"))) { %>
    <p style="color: green; text-align: center; font-weight: bold;">Booking Successful!</p>
    <% } %>

    <table>
        <tr>
            <th>ID</th>
            <th>Room</th>
            <th>Type</th>
            <th>Check-in</th>
            <th>Check-out</th>
            <th>Status</th>
            <th>Total Amount</th>
            <th>Action</th>
        </tr>
        <%
            int userId = (int) session.getAttribute("userId");
            ReservationDAO dao = new ReservationDAO();
            List<Reservation> myList = dao.getReservationsByUserId(userId);

            if (myList.isEmpty()) {
        %>
        <tr><td colspan="8">You have no reservations yet.</td></tr>
        <%  } else {
            for (Reservation r : myList) {
        %>
        <tr>
            <td>#<%= r.getReservationId() %></td>
            <td><%= r.getRoomNumber() %></td>
            <td><%= r.getRoomType() %></td>
            <td><%= r.getCheckIn() %></td>
            <td><%= r.getCheckOut() %></td>
            <td class="status-booked"><%= r.getStatus() %></td>
            <td>$<%= r.getTotalAmount() %></td>
            <td>
                <a href="../generateBill?id=<%= r.getReservationId() %>" class="btn-print">📄 Bill</a>
            </td>
        </tr>
        <%      }
        }
        %>
    </table>

    <a href="../dashboard/guestDashboard.jsp" class="back-link">⬅ Back to Dashboard</a>
</div>

</body>
</html>