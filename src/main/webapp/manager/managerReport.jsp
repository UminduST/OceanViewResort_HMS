<%-- Created executive analytics dashboard --%>
<%@ page import="com.oceanview.dao.ReportDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  // Security check: Only Managers allowed!
  if (session.getAttribute("userId") == null || !"MANAGER".equals(session.getAttribute("role"))) {
    response.sendRedirect("../login.jsp");
    return;
  }
%>
<!DOCTYPE html>
<html>
<head>
  <title>Hotel Analytics Report</title>
  <style>
    body { font-family: sans-serif; background-color: #f4f7f6; padding: 20px; }
    .header { text-align: center; color: #343a40; margin-bottom: 30px; }
    .dashboard-container { display: flex; flex-wrap: wrap; justify-content: center; gap: 20px; max-width: 900px; margin: auto; }
    .stat-card { background: white; padding: 30px; border-radius: 10px; box-shadow: 0 4px 15px rgba(0,0,0,0.1); width: 350px; text-align: center; border-top: 5px solid #343a40; }
    .stat-card.revenue { border-top-color: #28a745; }
    .stat-card.bookings { border-top-color: #007bff; }
    .stat-card.available { border-top-color: #17a2b8; }
    .stat-card.occupied { border-top-color: #dc3545; }
    .stat-value { font-size: 2.5em; font-weight: bold; margin: 10px 0; color: #333; }
    .stat-label { font-size: 1.2em; color: #666; text-transform: uppercase; letter-spacing: 1px; }
    .back-btn { display: block; width: 200px; margin: 40px auto; padding: 12px; text-align: center; background-color: #ffc107; color: black; font-weight: bold; text-decoration: none; border-radius: 5px; }
    .back-btn:hover { background-color: #e0a800; }
  </style>
</head>
<body>

<%
  // Fetch all the data dynamically from the database
  ReportDAO dao = new ReportDAO();
  double totalRevenue = dao.calculateRevenue();
  int totalBookings = dao.getTotalBookings();
  int availableRooms = dao.getRoomCountByStatus("AVAILABLE");
  int occupiedRooms = dao.getRoomCountByStatus("BOOKED");
%>

<div class="header">
  <h1>📈 Hotel Analytics & Revenue Report</h1>
  <p>Real-time overview of Ocean View Resort performance.</p>
</div>

<div class="dashboard-container">

  <div class="stat-card revenue">
    <div class="stat-label">Total Revenue</div>
    <div class="stat-value">$<%= String.format("%.2f", totalRevenue) %></div>
    <p style="color: gray; font-size: 14px;">From Checked-Out Stays</p>
  </div>

  <div class="stat-card bookings">
    <div class="stat-label">Total Bookings</div>
    <div class="stat-value"><%= totalBookings %></div>
    <p style="color: gray; font-size: 14px;">All time reservations</p>
  </div>

  <div class="stat-card available">
    <div class="stat-label">Available Rooms</div>
    <div class="stat-value"><%= availableRooms %></div>
    <p style="color: gray; font-size: 14px;">Ready for guests</p>
  </div>

  <div class="stat-card occupied">
    <div class="stat-label">Occupied Rooms</div>
    <div class="stat-value"><%= occupiedRooms %></div>
    <p style="color: gray; font-size: 14px;">Currently booked/in-use</p>
  </div>

</div>

<a href="../dashboard/managerDashboard.jsp" class="back-btn">⬅ Back to Dashboard</a>

</body>
</html>