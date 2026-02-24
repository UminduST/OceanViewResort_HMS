<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    if (session.getAttribute("userId") == null || !"RECEPTIONIST".equals(session.getAttribute("role"))) {
        response.sendRedirect("../login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Receptionist Dashboard</title>
    <link rel="icon" href="data:image/svg+xml,<svg xmlns=%22http://www.w3.org/2000/svg%22 viewBox=%220 0 100 100%22><text y=%22.9em%22 font-size=%2290%22>🌊</text></svg>">
    <style>
        body { font-family: sans-serif; background-color: #eef2f3; margin: 0; }
        .header { background-color: #6f42c1; color: white; padding: 20px; text-align: center; border-bottom: 4px solid #563d7c; }
        .container { padding: 20px; display: flex; gap: 20px; justify-content: center; flex-wrap: wrap; max-width: 1000px; margin: auto; }
        .card { background: white; padding: 20px; border-radius: 10px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); width: 250px; text-align: center; }
        .btn { display: inline-block; padding: 10px 15px; margin-top: 10px; text-decoration: none; color: white; border-radius: 5px; background-color: #6f42c1; transition: 0.3s; width: 80%; }
        .btn-danger { background-color: #dc3545; }
        .btn-success { background-color: #28a745; }
        .logout { float: right; margin-top: -40px; margin-right: 20px; color: #ffdf7e; text-decoration: none; font-weight: bold; }
    </style>
</head>
<body>
<div class="header">
    <h1>Receptionist Dashboard - <%= session.getAttribute("username") %></h1>
    <a href="../logout" class="logout">Logout ➜</a>
</div>

<div class="container">
    <div class="card">
        <h3>🛏️ Manage Rooms</h3>
        <p>Update room statuses (Cleaning, Available).</p>
        <a href="../receptionist/updateRoomStatus.jsp" class="btn">Update Status</a>
    </div>

    <div class="card">
        <h3>👥 Manage Guests</h3>
        <p>View and remove guest accounts.</p>
        <a href="../receptionist/manageGuests.jsp" class="btn btn-danger">Guest Accounts</a>
    </div>

    <div class="card">
        <h3>🛎️ Front Desk</h3>
        <p>Check guests in and out of the resort.</p>
        <a href="../receptionist/manageBookings.jsp" class="btn btn-success">Manage Bookings</a>
    </div>

    <div class="card">
        <h3>📄 Billing</h3>
        <p>Print invoices for guests.</p>
        <a href="../reservation/viewReservation.jsp" class="btn">Search Invoices</a>
    </div>
</div>
</body>
</html>