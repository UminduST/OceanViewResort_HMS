<%@ page import="com.oceanview.dao.ReservationDAO" %>
<%@ page import="com.oceanview.model.Reservation" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Search Reservation</title>
    <style>
        body { font-family: sans-serif; background-color: #eef2f3; text-align: center; padding-top: 50px; }
        .search-box { background: white; padding: 20px; display: inline-block; border-radius: 10px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); }
        .result-box { margin-top: 20px; background: #fff; padding: 20px; display: inline-block; border: 1px solid #ddd; text-align: left; width: 300px; }
        input { padding: 10px; width: 200px; }
        button { padding: 10px 20px; background: #007bff; color: white; border: none; cursor: pointer; }
        .success { color: green; font-weight: bold; }
        .back-btn { text-decoration: none; color: #007bff; font-weight: bold; }
    </style>
</head>
<body>

<%
    // 1. Updated to match the new Professional Database Roles (Uppercase!)
    String role = (String) session.getAttribute("role");
    String dashboardLink = "../login.jsp"; // Default fallback

    if ("RECEPTIONIST".equals(role)) {
        dashboardLink = "../dashboard/receptionistDashboard.jsp";
    } else if ("MANAGER".equals(role)) {
        dashboardLink = "../dashboard/managerDashboard.jsp";
    } else if ("GUEST".equals(role)) {
        dashboardLink = "../dashboard/guestDashboard.jsp";
    }
%>

<div class="search-box">
    <h2>🔎 Search Reservation</h2>
    <% if ("saved".equals(request.getParameter("msg"))) { %>
    <p class="success">Booking Saved Successfully!</p>
    <% } %>

    <form action="viewReservation.jsp" method="get">
        <input type="number" name="id" placeholder="Enter Reservation ID" required>
        <button type="submit">Search</button>
    </form>
    <br>
    <a href="<%= dashboardLink %>" class="back-btn">⬅ Back to Dashboard</a>
</div>

<%
    String idParam = request.getParameter("id");
    if (idParam != null) {
        ReservationDAO dao = new ReservationDAO();
        Reservation r = dao.getReservationById(Integer.parseInt(idParam));

        if (r != null) {
%>
<div class="result-box">
    <h3>Booking Details #<%= r.getReservationId() %></h3>
    <p><strong>Guest:</strong> <%= r.getGuestName() != null ? r.getGuestName() : "Guest" %></p>
    <p><strong>Room:</strong> <%= r.getRoomNumber() %> (<%= r.getRoomType() %>)</p>
    <p><strong>Check-In:</strong> <%= r.getCheckIn() %></p>
    <p><strong>Check-Out:</strong> <%= r.getCheckOut() %></p>
    <p><strong>Status:</strong> <span style="font-weight:bold; color: <%= r.getStatus().equals("CHECKED_OUT") ? "green" : "orange" %>;"><%= r.getStatus() %></span></p>
    <p><strong>Total Amount:</strong> $<%= r.getTotalAmount() %></p>

    <br><br>
    <center>
        <a href="../generateBill?id=<%= r.getReservationId() %>" style="background: orange; color: white; padding: 8px; text-decoration: none; border-radius: 5px;">📄 Generate Bill</a>
    </center>
</div>
<%
} else {
%>
<p style="color:red; margin-top:20px;">No reservation found with ID: <%= idParam %></p>
<%
        }
    }
%>

</body>
</html>