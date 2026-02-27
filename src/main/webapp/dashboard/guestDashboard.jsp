<%-- Added branding and favicon wave logo across app --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    if (session.getAttribute("userId") == null) { response.sendRedirect("../login.jsp"); return; }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Guest Dashboard</title>
    <link rel="icon" href="data:image/svg+xml,<svg xmlns=%22http://www.w3.org/2000/svg%22 viewBox=%220 0 100 100%22><text y=%22.9em%22 font-size=%2290%22>🌊</text></svg>">
    <style>
        body { font-family: sans-serif; background-color: #eef2f3; margin: 0; }
        .header { background-color: #17a2b8; color: white; padding: 20px; text-align: center; }
        .container { padding: 20px; display: flex; gap: 20px; justify-content: center; flex-wrap: wrap; }
        .card { background: white; padding: 25px; border-radius: 10px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); width: 220px; text-align: center; }
        .btn { display: inline-block; padding: 10px 15px; margin-top: 10px; text-decoration: none; color: white; border-radius: 5px; background-color: #007bff; transition: 0.3s; }
        .btn-green { background-color: #28a745; }
        .logout { float: right; margin-top: -40px; margin-right: 20px; color: white; text-decoration: none; font-weight: bold; }
    </style>
</head>
<body>
<div class="header">
    <h1>Welcome, <%= session.getAttribute("username") %></h1>
    <a href="../logout" class="logout">Logout ➜</a>
</div>

<div class="container">
    <div class="card">
        <h3>🏨 Book a Room</h3>
        <p>Reserve your perfect stay.</p>
        <a href="../reservation/addReservation.jsp" class="btn btn-green">New Booking</a>
    </div>

    <div class="card">
        <h3>🧳 My Bookings</h3>
        <p>View reservations & print bills.</p>
        <a href="../reservation/viewMyReservations.jsp" class="btn">View Details</a>
    </div>

    <div class="card">
        <h3>🛏️ View Rooms</h3>
        <p>See all our room types & prices.</p>
        <a href="../reservation/roomsList.jsp" class="btn">Room List</a>
    </div>

    <div class="card">
        <h3>❓ Help & Support</h3>
        <p>Need assistance using the system?</p>
        <a href="../guestHelp.jsp" class="btn">Get Help</a>
    </div>
</div>
</body>
</html>