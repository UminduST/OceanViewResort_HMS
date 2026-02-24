<%@ page import="com.oceanview.dao.RoomDAO" %>
<%@ page import="com.oceanview.model.Room" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Security check
    if (session.getAttribute("userId") == null) { response.sendRedirect("../login.jsp"); return; }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Book a Room</title>
    <style>
        body { font-family: sans-serif; background-color: #f4f7f6; padding: 20px; }
        .form-container { background: white; padding: 30px; max-width: 500px; margin: auto; border-radius: 10px; box-shadow: 0 5px 15px rgba(0,0,0,0.1); }
        input, select { width: 100%; padding: 10px; margin: 10px 0; border: 1px solid #ccc; border-radius: 5px; }
        button { background-color: #28a745; color: white; border: none; padding: 15px; width: 100%; font-size: 16px; cursor: pointer; }
    </style>
</head>
<body>
<div class="form-container">
    <h2>Book Your Stay 🏨</h2>
    <form action="../addReservation" method="post">

        <label>Select Room:</label>
        <select name="roomId" required>
            <%
                RoomDAO dao = new RoomDAO();
                List<Room> availableRooms = dao.getAvailableRooms();
                for(Room r : availableRooms) {
            %>
            <option value="<%= r.getRoomId() %>">
                Room <%= r.getRoomNumber() %> - <%= r.getRoomType() %> ($<%= r.getPricePerNight() %>/night)
            </option>
            <% } %>
        </select>

        <label>Check-in Date:</label>
        <input type="date" name="checkIn" required>

        <label>Check-out Date:</label>
        <input type="date" name="checkOut" required>

        <button type="submit">Confirm Booking</button>
    </form>
    <br>
    <center><a href="../dashboard/guestDashboard.jsp">Back to Dashboard</a></center>
</div>
</body>
</html>