<%-- Implemented room creation functionality --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add New Room</title>
    <style>
        body { font-family: sans-serif; background-color: #f4f7f6; display: flex; justify-content: center; padding-top: 40px; }
        .form-box { background: white; padding: 30px; border-radius: 10px; box-shadow: 0 4px 15px rgba(0,0,0,0.1); width: 400px; text-align: center; }
        input, select { width: 90%; padding: 10px; margin: 10px 0; border: 1px solid #ccc; border-radius: 5px; }
        button { background-color: #343a40; color: white; border: none; padding: 12px; width: 100%; border-radius: 5px; cursor: pointer; font-size: 16px; margin-top: 10px;}
        button:hover { background-color: #ffc107; color: black; font-weight: bold; }
    </style>
</head>
<body>
<div class="form-box">
    <h2>🏗️ Create New Room</h2>
    <% if ("success".equals(request.getParameter("msg"))) { %>
    <p style="color: green; font-weight: bold;">Room created successfully!</p>
    <% } %>
    <form action="../addRoom" method="post">
        <input type="text" name="roomNumber" placeholder="Room Number (e.g., 401)" required>
        <select name="roomType" required>
            <option value="Standard">Standard</option>
            <option value="Deluxe">Deluxe</option>
            <option value="Suite">Suite</option>
        </select>
        <input type="number" name="floorNumber" placeholder="Floor Number" required>
        <input type="number" name="maxGuests" placeholder="Max Guests Allowed" required>
        <input type="number" name="price" step="0.01" placeholder="Price Per Night ($)" required>
        <input type="text" name="amenities" placeholder="Amenities (WiFi, TV, Balcony)" required>
        <button type="submit">Save Room</button>
    </form>
    <br><a href="../dashboard/managerDashboard.jsp" style="text-decoration: none; color: #555;">⬅ Back to Dashboard</a>
</div>
</body>
</html>