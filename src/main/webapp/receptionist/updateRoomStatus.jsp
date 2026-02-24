<%@ page import="com.oceanview.util.DBConnection" %>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Room Status</title>
    <style>
        body { font-family: sans-serif; background-color: #f4f7f6; padding: 20px; }
        .table-container { background: white; padding: 20px; border-radius: 10px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); max-width: 800px; margin: auto; }
        table { width: 100%; border-collapse: collapse; margin-top: 15px; }
        th, td { padding: 12px; text-align: center; border-bottom: 1px solid #ddd; }
        th { background-color: #6f42c1; color: white; }
        select { padding: 5px; }
        button { background-color: #007bff; color: white; border: none; padding: 6px 12px; cursor: pointer; border-radius: 3px; }
    </style>
</head>
<body>
<div class="table-container">
    <h2 style="text-align: center;">🛏️ Update Room Availability</h2>
    <% if ("updated".equals(request.getParameter("msg"))) { %>
    <p style="color: green; text-align: center;">Room status updated successfully!</p>
    <% } %>

    <table>
        <tr>
            <th>Room No.</th>
            <th>Type</th>
            <th>Current Status</th>
            <th>Update Status</th>
        </tr>
        <%
            try (Connection con = DBConnection.getConnection();
                 Statement st = con.createStatement();
                 ResultSet rs = st.executeQuery("SELECT * FROM rooms ORDER BY room_number ASC")) {

                while (rs.next()) {
                    int roomId = rs.getInt("room_id");
                    String currentStatus = rs.getString("status");
        %>
        <tr>
            <td><%= rs.getString("room_number") %></td>
            <td><%= rs.getString("room_type") %></td>
            <td style="font-weight: bold; color: <%= currentStatus.equals("AVAILABLE") ? "green" : (currentStatus.equals("BOOKED") ? "red" : "orange") %>">
                <%= currentStatus %>
            </td>
            <td>
                <form action="../updateRoomStatus" method="post" style="margin: 0;">
                    <input type="hidden" name="roomId" value="<%= roomId %>">
                    <select name="status">
                        <option value="AVAILABLE" <%= currentStatus.equals("AVAILABLE") ? "selected" : "" %>>AVAILABLE</option>
                        <option value="BOOKED" <%= currentStatus.equals("BOOKED") ? "selected" : "" %>>BOOKED</option>
                        <option value="CLEANING" <%= currentStatus.equals("CLEANING") ? "selected" : "" %>>CLEANING</option>
                    </select>
                    <button type="submit">Update</button>
                </form>
            </td>
        </tr>
        <%      }
        } catch (Exception e) { e.printStackTrace(); }
        %>
    </table>
    <br>
    <%
        String currentRole = (String) session.getAttribute("role");
        String dashLink = "../login.jsp";
        if ("MANAGER".equals(currentRole)) {
            dashLink = "../dashboard/managerDashboard.jsp";
        } else if ("RECEPTIONIST".equals(currentRole)) {
            dashLink = "../dashboard/receptionistDashboard.jsp";
        }
    %>
    <center><a href="<%= dashLink %>" style="text-decoration: none; color: #6f42c1;">⬅ Back to Dashboard</a></center>
</div>
</body>
</html>