<%@ page import="com.oceanview.util.DBConnection" %>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Our Rooms</title>
    <style>
        body { font-family: sans-serif; background-color: #f4f7f6; padding: 20px; }
        .table-container { background: white; padding: 20px; border-radius: 10px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); max-width: 800px; margin: auto; }
        table { width: 100%; border-collapse: collapse; margin-top: 15px; }
        th, td { padding: 12px; text-align: left; border-bottom: 1px solid #ddd; }
        th { background-color: #17a2b8; color: white; }
        .status-available { color: green; font-weight: bold; }
        .status-booked { color: red; font-weight: bold; }
    </style>
</head>
<body>
<div class="table-container">
    <h2 style="text-align: center;">🛏️ Browse Our Rooms</h2>
    <table>
        <tr>
            <th>Room No.</th>
            <th>Type</th>
            <th>Max Guests</th>
            <th>Price / Night</th>
            <th>Status</th>
        </tr>
        <%
            try (Connection con = DBConnection.getConnection();
                 Statement st = con.createStatement();
                 ResultSet rs = st.executeQuery("SELECT * FROM rooms")) {

                while (rs.next()) {
                    String status = rs.getString("status");
                    String statusClass = status.equals("AVAILABLE") ? "status-available" : "status-booked";
        %>
        <tr>
            <td><%= rs.getString("room_number") %></td>
            <td><%= rs.getString("room_type") %></td>
            <td><%= rs.getInt("max_guests") %> People</td>
            <td>$<%= rs.getDouble("price_per_night") %></td>
            <td class="<%= statusClass %>"><%= status %></td>
        </tr>
        <%
                }
            } catch (Exception e) { e.printStackTrace(); }
        %>
    </table>
    <br>
    <center><a href="../dashboard/guestDashboard.jsp" style="color: #007bff; text-decoration: none;">⬅ Back to Dashboard</a></center>
</div>
</body>
</html>